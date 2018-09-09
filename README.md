# Chimantá Genomics

![Mou icon](http://www.climax-magazine.com/wp-content/uploads/2013/02/Glowacz_Jaeger_des_Augenblicks_2_Snapseed.jpg)

>Corresponding author <patriciasalerno@gmail.com>. All materials in this repository are the Intellectual Property of **Patricia E. Salerno** and official collaborators of this project.



## general workflow

**NOTE**: this workflow includes two datasets for the species *Tepuihyla edelcae* and *Stefania ginesi*, obtained using ddRAD (Illumina 150bp PE) for both species. Workflow goes from raw data to final analyses. 


>more info on each individual workflow can be found [here](https://github.com/pesalerno/Chimanta-genomics/blob/master/README_Stefania.txt) for *Stefania* and [here](https://github.com/pesalerno/Chimanta-genomics/blob/master/README_Tepuihyla.txt) for *Tepuihyla*.


### Step 1: De-multiplexing

#### 1.1. run process_radtags


- process_radtags is done for each separate library according to barcodes used. 

- make output folder with same name as code before running (in this case it's *process_rads*). 

In general code is:

	> process_radtags -p ./rawdata/ -b adapters_file.txt -o ./process_rads/  -c -q -r -D \
	--inline_index --renz_1 sphI --renz_2 mspI -i gzfastq 


Libraries for each are: 

1. *Tepuihyla*: 
	- Tep_1 (files=PES_Tep_1_ATCACG_L007_R1_001.fastq.gz; PES_Tep_1_ATCACG_L007_R2_001.fastq.gz)
	- Tep_2 (files=PES_Tep_2_CGATGT_L007_R1_001.fastq.gz; PES_Tep_2_CGATGT_L007_R2_001.fastq.gz)
2. *Stefania*:
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

Get total number of reads per individual after initial filter in process_radtags. Run the following script in the shell, inside folder with processed reads from all libraries (each species separately):

	echo -e 'SAMPLE_ID_FULL\tNUM_READS'
	
	for file in *.fq
	
	do
		echo -n $(basename $file .fq)$'\t'
		cat $file | grep '^@.*' | wc -l
	done




### Step 2: denovo genotyping


After exploring our dataset by running a few combinations of parameters -m, -n, and M, we used the following code for our final genotyping:


       denovo_map.pl -T 8 -m 2 -M 3 -n 2 -S -b 2 -o ./output-folder/ -s ./sequence_1.fq \


_________

### Step 2: Filtering the SNP matrix.


After genotyping, we first exported the SNP matrix with minimal filter in *populations*: 
	
	populations -b 2 -P ./pop-comb-c/ -M ./pop-map-combine -fstats -k -p 1 -r 0.2  -t 8 --structure --genepop --vcf --plink --write_random_snp


We filtered the SNP matrix using [PLINK](http://pngu.mgh.harvard.edu/~purcell/plink/summary.shtml) in the following way:

For *Tepuihyla*, we ran (for each flag separately): 

	./plink --file input-name --geno 0.4 --mind 0.6 --maf 0.02 
	
For *Stefania*, we did: 

	./plink --file input-name --geno 0.5 --mind --0.5 --maf 0.02


In both cases, filtering parameters were based on the combination that increased the amount of individuals and SNPs in all populations. 


In *Tepuihyla*, the [resulting SNP matrix](https://github.com/pesalerno/Chimanta-genomics/blob/master/Tep-04-02-c.stru) used in downstream analyses had a total missingness of 0.885012 and retained 4776 SNPs and 71 individuals. 

In *Stefania*, the [resulting SNP matrix](https://github.com/pesalerno/Chimanta-genomics/blob/master/Stef-NEW-c.stru) used in downstream analyses had a total missingness of 0.883727 and retained 8734 SNPs and 46 individuals.

 
###
###

###Obtaining population stats using the program **populations** with a whitelist of loci and individuals that passed filters

	


In order to get the *populations* stats outputs from STACKS, we re-ran populations using a whitelist, which requires file that only has the locis ID and excludes the SNP position ID. Thus, only the first string before the underscore needs to be kept. The whitelist file format is ordered as a simple text file containing one catalog locus per line: 

		3
		7
		521
		11
		46

We used the ***.map*** output from the last ***plink*** filter in Text Wrangler, and generated the populations whitelist using find and replace arguments using **grep**:


	search for \d\t(\d*)_\d*\t\d\t\d*$
	replace with \1

Based the **.irem** file from the second iteration of *plink* we removed from the popmap (to use in populations input) the only  individual that did not pass **plink** filter (i.e. individuals with >50% missing data). 

	populations -b 1 -P ./denovo-03-2017 -M ./popmap-Tep.txt  -t 36 -p 1 -r 0.5 -W Tep-whitelist --write_random_snp --phylip --structure --plink --vcf --genepop --fstats

##Step 3: Structure and population estimates in adegenet

We ran Principal Components and Discriminant Analyses using **adegenet**, and obtained some population measures using the package **hierfstat** in R. 

> The code used for adegenet and hierfstat analyses can be found [here](https://github.com/pesalerno/Chimanta-genomics/blob/master/adegenet-Tepuihyla-NEW.R) for *Tepuihyla* and [here](https://github.com/pesalerno/Chimanta-genomics/blob/master/adegenet-Stefania-NEW-b.R) for *Stefania*.


##Step 4: Obtaining maximum likelihood phylogenies with bootstraps for *Stefania* and *Tepuihyla* SNPs:

	./raxml-ng --all --msa Stef-NEW-c.phylip.txt --model GTR+G --tree pars {10} --bs-trees 200

