# Chimanta landscape genomics

![Mou icon](http://www.climax-magazine.com/wp-content/uploads/2013/02/Glowacz_Jaeger_des_Augenblicks_2_Snapseed.jpg)

## general workflow

**NOTE**: this workflow includes three general datasets for the two species, *Tepuihyla edelcae* and *Stefania ginesi*. The first two datasets are several libraries of ddRAD (Illumina 150bp PE) for both species, and the third dataset is Roche 454 data obtained for a single individual of *Tepuihyla edelcae*. Workflow goes from raw data to final analyses.

### Step 1: De-multiplexing

#### 1.1. run process_radtags


- process_radtags is done for each separate library according to barcodes used. 

- make output folder with same name as code before running (in this case it's *process_rads*). 

In general code is:

	> process_radtags -p ./rawdata/ -b adapters_file.txt -o ./process_rads/  -c -q -r -D \
	--inline_index --renz_1 sphI --renz_2 mspI -i gzfastq 

Libraries for each are: 

1. *Tepuihyla*: 
	- pilot library, single individual (filename=) **need to get from Benni!**
	- Tep_1 (files=PES_Tep_1_ATCACG_L007_R1_001.fastq.gz; PES_Tep_1_ATCACG_L007_R2_001.fastq.gz)
	- Tep_2 (files=PES_Tep_2_CGATGT_L007_R1_001.fastq.gz; PES_Tep_2_CGATGT_L007_R2_001.fastq.gz)
2. *Stefania*:
	- pilot library, single individual (filename=) **need to get from Benni!**
	- Stefania_16 (files=Stef_12_18_ATCACG_L004_R1_001.fastq.gz; Stef_12_18_ATCACG_L004_R2_001.fastq.gz)
	- Stef_3 (files=Stef_3_ATCACG_L008_R1_001.fastq.gz; Stef_3_ATCACG_L008_R2_001.fastq.gz)
	- Stef_4 (files=Stef_4b_CGATGT_L008_R1_001.fastq; Stef_4b_CGATGT_L008_R2_001.fastq)



**NOTE**: For second *Stefania* library (also known as Stef_3 from raw data) five individuals always have zero reads kept after doing process_radtags. Lots of time went into figuring out why they were being dropped, using different combinations of raw data and barcode combinations but always had the same result. Thus, those five individuals are being dropped from dataset and subsequent analyses.

#### 1.2. rename barcodes before merging libraries


Rename within each output directory, then only copy (instead of move! copy then delete) only the renamed files. I used Becca's rename_barcodes_fixed.py script and ran in shell as such:

	> module load python
	> python rename_barcodes_fixed.py './' '*.fq' 'barcodes.txt'

The barcodes files is a simple tab delimited text file with the first column being old names (barcodes) and second column being new names (species ID, locality, etc).

#### 1.3. get read counts from each individual sample for both species

First, get total number of reads per individual after initial filter in process_radtags. Run the following script in the shell, inside folder with processed reads from all libraries (each species separately):

	echo -e 'SAMPLE_ID_FULL\tNUM_READS'
	
	for file in *.fq
	
	do
		echo -n $(basename $file .fq)$'\t'
		cat $file | grep '^@.*' | wc -l
	done


The above code will print to screen sample ID (tab) number of reads. Save to a file.

Then, run the R script 'readcounts_scatterplot.R' to get a plot with ablines (average and st deviation) for each species and all individual read counts.

1. Plot for *Tepuihyla* read counts (excluding 454 data):



2. Plot for *Stefania* read counts:



### Step 2: 454 and RADseq data mapping on bwa (and/or velvet?)


#### 2.1. Download reference genome (*Xenopus* and *Nanorana*) as input for bwa

Doing this from terminal within Stampede (TACC) and with command wget. First for *Xenopus*:

	> wget ftp://ftp.jgi-psf.org/pub/JGI_data/Frog/reads_single/xenopus0.fasta.Z

For *Nanorana*, there are four separate fasta "contig" files for the genome, available in this [address](http://www.ncbi.nlm.nih.gov/Traces/wgs/?val=JYOU01#contigs), and then I used wget for each copied link adress for each of the fasta files (same as above). 

#### 2.2. Create index for reference genome in bwa
For *Xenopus* (haven't made it work because of the .Z extension.... figure out or drop..?)

	> bwa index xenopus0.fasta.Z

For *Nanorana* I ran all four contig fasta files at once, using the stampede job scheduler within the bwa-analyses folder, as such:

	> bwa index index.html?download=JYOU01.1.fsa_nt index.html?download=JYOU01.2.fsa_nt.gzindex.html?download=JYOU01.3.fsa_nt.gzindex.html?download=JYOU01.4.fsa_nt.gz
 
#### 2.3. Align 454 reads to reference genome
For longer reads, use bwasw command. Align 454 data to reference genome as such:

	> bwa bwasw -t 6  index.html?download=JYOU01.1.fsa_nt index.html?download=JYOU01.2.fsa_nt.gz index.html?download=JYOU01.3.fsa_nt.gz index.html?download=JYOU01.4.fsa_nt.gz 454Reads.JA11211_PS334_RL13.sff > aln.sam

--> we are using six threads (CPUs) for faster processing

===> visualize data before moving on to next step

#### 2.4. Align ddRAD data (all libraries!) to reference genome and 454 data (maybe create new reference genome after step 2.3?)

For paired-end reads, you need to align each one separately to the reference genome: (following code copy/pasted from a tutorial, need to personalize after running this)

	> bwa aln -t 4 hg19bwaidx s_3_1_sequence.txt.gz >  s_3_1_sequence.txt.bwa
	> bwa aln -t 4 hg19bwaidx s_3_2_sequence.txt.gz >  s_3_2_sequence.txt.bwa
	> bwa sampe hg19bwaidx s_3_1_sequence.txt.bwa s_3_2_sequence.txt.bwa \
			s_3_1_sequence.txt.gz s_3_2_sequence.txt.gz > s_3_sequence.txt.sam




  



**strong** or __strong__ ( Cmd + B )

*emphasize* or _emphasize_ ( Shift + Cmd + I )

**Sometimes I want a lot of text to be bold.
Like, seriously, a _LOT_ of text**


#### Links and Email

An email <example@example.com> link.

Simple inline link <http://chenluois.com>, another inline link [Smaller](http://smallerapp.com), one more inline link with title [Resize](http://resizesafari.com "a Safari extension").

A [reference style][id] link. Input id, then anywhere in the doc, define the link with corresponding id:

[id]: http://mouapp.com "Markdown editor on Mac OS X"

Titles ( or called tool tips ) in the links are optional.

#### Images

An inline image ![Smaller icon](http://smallerapp.com/favicon.ico "Title here"), title is optional.

A ![Resize icon][2] reference style image.

[2]: http://resizesafari.com/favicon.ico "Title"

#### Inline code and Block code

Inline code are surround by `acute` key. To create a block code:

	Indent each line by at least 1 tab, or 4 spaces.
    var Mou = exactlyTheAppIwant; 

####  Ordered Lists

Ordered lists are created using "1." + Space:

1. Odered list item
2. Odered list item
3. Odered list item

#### Unordered Lists

Unordered list are created using "*" + Space:

* Unordered list item
* Unordered list item
* Unordered list item 

Or using "-" + Space:

- Unordered list item
- Unordered list item
- Unordered list item

#### Hard Linebreak

End a line with two or more spaces will create a hard linebreak, called `<br />` in HTML. ( Control + Return )  
Above line ended with 2 spaces.

#### Horizontal Rules

Three or more asterisks or dashes:

***

---

- - - -

#### Headers

Setext-style:

This is H1
==========

This is H2
----------

atx-style:

# This is H1
## This is H2
### This is H3
#### This is H4
##### This is H5
###### This is H6


### Shortcuts

#### View

* Toggle live preview: Cmd + I
* Left/Right = 1/1: Cmd + 0
* Left/Right = 3/1: Cmd + +
* Left/Right = 1/3: Cmd + -
* Toggle layout orientation: Cmd + L
* Toggle fullscreen: Control + Cmd + F

#### Actions

* Copy HTML: Option + Cmd + C
* Strong: Select text, Cmd + B
* Emphasize: Select text, Shift + Cmd + I
* Link: Select text, Control + Shift + L
* Image: Select text, Control + Shift + I
* Uppercase: Select text, Control + U
* Lowercase: Select text, Control + Shift + U
* Titlecase: Select text, Control + Option + U
* Select Word: Control + Option + W
* Select Line: Shift + Cmd + L
* Select All: Cmd + A
* Deselect All: Cmd + D
* Insert entity <: Control + Shift + ,
* Insert entity >: Control + Shift + .
* Insert entity &: Control + Shift + 7
* Insert entity Space: Control + Shift + Space
* Shift Line Left: Cmd + [
* Shift Line Right: Cmd + ]
* New Line: Cmd + Return
* Comment: Cmd + /
* Hard Linebreak: Control + Return

#### Edit

* Auto complete current word: Esc
* Find: Cmd + F
* Close find bar: Esc

#### Export

* Export HTML: Cmd + E


### And more?

Don't forget to check Preferences, lots of useful options are there. You can Disable/enable **Show Live Preview** in new documents, Disable/enable **Auto pair**, **Make links clickable in Editor view**, change **Base Font**, choose another **Theme** or create your own!

Follow [@chenluois](http://twitter.com/chenluois) on Twitter for the latest news.

For feedbacks, use the menu `Help` - `Send Feedback`
