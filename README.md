# Chimanta landscape genomics

![Mou icon](http://www.climax-magazine.com/wp-content/uploads/2013/02/Glowacz_Jaeger_des_Augenblicks_2_Snapseed.jpg)

## general workflow

**NOTE**: this workflow includes three general datasets for the two species, *Tepuihyla edelcae* and *Stefania ginesi*. The first two datasets are several libraries of ddRAD (Illumina 150bp PE) for both species, and the third dataset is Roche 454 data obtained for a single individual of *Tepuihyla edelcae*. Workflow goes from raw data to final analyses. Corresponding author <patriciasalerno@gmail.com>. All materials in this repository are the Intellectual Property of **Patricia E. Salerno** and official collaborators of this project.

### Step 1: De-multiplexing

#### 1.1. run process_radtags


- process_radtags is done for each separate library according to barcodes used. 

- make output folder with same name as code before running (in this case it's *process_rads*). 

In general code is:

	> process_radtags -p ./rawdata/ -b adapters_file.txt -o ./process_rads/  -c -q -r -D \
	--inline_index --renz_1 sphI --renz_2 mspI -i gzfastq 

**NOTE**: *(on 05/09/2015)* Need to re-do process rads!! I only did this for the forward reads initially since I had some issues previously and less reads were being kept (as far as I can remember). Now that I'm mapping, I relaly need to keep both!! at the very least for the reference genome and visualization steps.... then I can decide if they should be dropped from genotyping and variant calling steps....

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


Rename within each output directory, then only copy (instead of move! copy then delete) only the renamed files. I used Becca's [rename_barcodes_fixed.py](https://github.com/pesalerno/Chimanta-genomics/blob/master/rename_barcodes_fixed.py) script and ran in shell as such:

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

Then, run the R script [readcounts_scatterplot.R](https://github.com/pesalerno/Chimanta-genomics/blob/master/readcounts_scatterplot.R) to get a plot with ablines (average and st deviation) for each species and all individual read counts.

1. Plot for *Tepuihyla* read counts (excluding 454 data):



2. Plot for *Stefania* read counts:



### Step 2: 454 and RADseq data alignment on bwa


#### 2.1. Download reference genome (*Xenopus* and *Nanorana*) as input for bwa

Doing this from terminal within Stampede (TACC) and with command wget. First for *Xenopus*:

	> wget ftp://ftp.jgi-psf.org/pub/JGI_data/Frog/reads_single/xenopus0.fasta.Z

For *Nanorana*, there are four separate fasta "contig" files for the genome, available in this [address](http://www.ncbi.nlm.nih.gov/Traces/wgs/?val=JYOU01#contigs), and then I used wget for each copied link adress for each of the fasta files (same as above). 

**NOTE**: IGV visualization (on step 2.4) failed, I think it's because I didn't download the right files. I'm redoing this from [this link](http://gigadb.org/dataset/100132) and doing wget with a single fasta gzipped file, as such:


	> wget ftp://climb.genomics.cn/pub/10.5524/100001_101000/100132/Nanorana_parkeri\
			.genome.v2.fa.gz
	

#### 2.2. Create index for reference genome in bwa
I ran the single fasta gzipped file from *Nanorana*, using the stampede job scheduler within the bwa-analyses folder, as such:

	> bwa index Nanorana_parkeri.genome.v2.fa.gz
 
#### 2.3. Align 454 reads to reference genome
For longer reads, use bwasw command. Align 454 data to reference genome as such:

	> bwa bwasw -t 6  index.html?download=JYOU01.1.fsa_nt index.html?download=JYOU01.2.fsa_nt.gz index.html?download=JYOU01.3.fsa_nt.gz index.html?download=JYOU01.4.fsa_nt.gz 454Reads.JA11211_PS334_RL13.sff > aln.sam

--> we are using six threads (CPUs) for faster processing  

NEW code:

	> bwa bwasw -t 6 Nanorana_parkeri.genome.v2.fa.gz 454Reads.JA11211_PS334_RL13.sff > aln.sam

#### 2.4. Visualize alignment in IGV.

We need to visualize and export a fasta file of alignment before moving on to next step with the program Integrative Genomics Viewer [(IGV)](https://www.broadinstitute.org/software/igv/download). To do this, we need to convert output file from .sam to .bam format, which is the input format in IGV. We do this using the program [samtools](http://samtools.sourceforge.net/).

First, convert from SAM to BAM format:

	> module load samtools
	> samtools view -b -S -o 454-align.bam 454-align.sam
	
Second, sort and index the BAM file:

	> samtools sort 454-align.bam 454-align.sorted
	> samtools index 454-align.sorted.bam

Download relevant data files to personal computer so that we can visualize on IGV:

	> 454-align.sorted.bam
	> 454-align.sorted.bam.bai
	> all .fasta files for alignment

Then, in IGV, I need to create a .genome file using all the reference genome fasta files (in this case since there's four, I'm defining a directory as the input). Information on how to create the .genome file can be found [here](https://www.broadinstitute.org/software/igv/LoadGenome)


I will need to export this as fasta for using as new reference genome for step 2.4


#### 2.4. Align ddRAD data (for *Tepuihyla* and *Stefania* separately) to new reference genome from 454 + *Nanorana* data

--> I'm doing this for each species separately so that I can generate a different reference genome for *Tepuihyla* (454 data + all *Tepuihyla* ddRAD libraries) and *Stefania* (454 data + all *Stefania* ddRAD libraries).

For paired-end reads, you need to align each one separately to the reference genome: (following code was copy/pasted from a tutorial, so I need to personalize it after running this). In my case, since I have many individual libraries, I will align them to the reference genome **AFTER** they've been de-multiplexed, but before they've been through denovo_map (less data should be lost).

So, step by step for this section would be:

- Index new reference genome (454+*Nanorana*)

		> bwa index new-genome-file.fasta

- Align all demultiplexed/cleaned read files to the new reference genome. Need to do forward and reverse reads separately.

		> bwa mem -t 6 


- Visualize in IGV (follow same steps as above with .sam to .bam conversion)


		> module load samtools
		> samtools view -b -S -o 454-align.bam 454-align.sam
		> samtools sort 454-align.bam 454-align.sorted
		> samtools index 454-align.sorted.bam


#####2.4.4. Export as .fasta for importing as new reference genome in Stacks 

(I think I don't need to!! can use other formats, check Stacks manual--> can be in **.sam** or **.bam** formats)




###Step 3: Reference mapping on Stacks 

This is of course done with each species separately, and at this point of the work flow each species has its own reference genome. 

Reference genomes are:   
- *Tepuihyla*: (outut file from step 2.4.4)  
- *Stefania*: (output file from step 2.4.4)

Steps for reference mapping are the following (all steps within **Step 3** are identical for each species, unless otherwise noted): 

#####3.1. Generate popmap file

This file needs all individual IDs (file names excluding extension) in the first column, and populaiton assignment in second column of a tab delimited text file.

Export a list of all files into a text document, within the directory with all de-multiplexed sequences, as such:

	> ls > fileslist.txt

Eliminate file extension with find/replace, and add (tab) population assignment in numbers (1 through n) in second column.

#####3.2. Generate list of sequences to input into mapping script for Stacks

We need a list of every single sequence file that will be used as input for Stacks, organized in a single line (single line is due to Stampede cluster issues if kept in separate lines) in the following format:

	> -s ./Ab_365_CGAAT-CGATGT.1.fq -s ./all-other-files


Use files list generated above, without eliminating file extension, and with find/replace arguments in TextWrangler to change to above format. 

#####3.3. Run program ref.map.pl in Stacks

Instead of doing **denovo_map.pl**, I'm using the reference genome and running [ref.map.pl](http://creskolab.uoregon.edu/stacks/comp/ref_map.php) for validation and likely for keeping a larger number of contigs/snps.  

In general, script is as follows:

	> ref_map.pl -o /path/for/output -n 2 -m 2 -T 12 -O popmap.txt -b 1 -S -s ./all-sequences-here\
 
===> Explanation of flags and options is the following:   
**n=2** *Allow two mismatches between loci when building catalog (default=0)*  
**m=2** *Minimum depth of coverage to report a stack in pstacks (default=1)*  
**S** *(Disable recording SQL in database (because I'm running from server))*


#####3.4. Make genotype and haplotype corrections in Stacks

This step essentially re-runs all of the mapping pipeline (sstacks, ustacks, etc) in the program [rxstacks](http://creskolab.uoregon.edu/stacks/comp/rxstacks.php) in order to correct haplotype and SNP calls by population haplotype information. 

	> rxstacks -b 1 -P ./input-stacksoutput/ -o /new-output-path/ --prune_haplo --lnl_filter --lnl_dist 

 
===> Explanation of flags and options is the following:   
**--prune_haplo** *"prune out non-biological haplotypes unlikely to occur in population"*  
**--lnl_filter** *"filter calatog loci based on the mean log likelihood of the catalog locus in the population"*  
**--lnl_dist** *"print distribution of mean log likelihood required to keep a catalog locus"*  


From the stacks manual, *"we can bucket the log likelihood values to plot it more conveniently using the shell"*:

	> cat batch_1.rxstacks_lnls.tsv | grep -v "^#" | awk '{bucket=(int($2)); lnls[bucket] += 1} END { for (bucket in lnls) print bucket, "\t", lnls[bucket]}' | sort -n > lnls.tsv

Then we can generate a simple plot in R:



  
  
    
    
    



#### Images

An inline image ![Smaller icon](http://smallerapp.com/favicon.ico "Title here"), title is optional.

A ![Resize icon][2] reference style image.

[2]: http://resizesafari.com/favicon.ico "Title"


#### Hard Linebreak

End a line with two or more spaces will create a hard linebreak, called `<br />` in HTML. ( Control + Return )  
Above line ended with 2 spaces.

#### Horizontal Rules

Three or more asterisks or dashes:

***

---

- - - -



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
