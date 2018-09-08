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

Genotyping
-------

After finding the lowest genotyping error rate for our dataset and the appropriate *denovo_map.pl* parameters, we used the following code for our final genotyping:


        denovo_map.pl -T 16 -m 5 -M 2 -n 2 -S -b 2 -X "ustacks:--max_locus_stacks [3]" -o /path/to/denovomap_out/ \
        -s /path/to/rad_tags/filename.fq \ 

_________

Filtering SNP matrix.
------

After genotyping, we first exported the SNP matrix with minimal filter in *populations*: 

	>>populations 
	#!/bin/bash
	#SBATCH cluster specific information 

	populations -b 2 -P ./pop-comb-c/ -M ./pop-map-combine -fstats -k -p 1 -r 0.2  -t 8 --structure --genepop --vcf --plink --write_random_snp



Using [PLINK](http://pngu.mgh.harvard.edu/~purcell/plink/summary.shtml), we filtered our dataset in several steps.

First, we filtered out loci with too much missing data:

	./plink --file input-name --geno 0.5 --recode --out output-filename_a --noweb

Second, we filtered out individuals with too much missing data:

	./plink --file input-filename_a --mind 0.5 --recode --out output-filename_b --noweb
	
Third, we filtered out based on minor allele frequency cutoffs:

	./plink --file input-filename_b --maf 0.01 --recode --out output-filename_c --noweb
 
We did three maf cutoffs (0.01, 0.02, 0.05) to evaluate missingness of final matrices and whether basic population analyses vary with them. Based on [these](https://github.com/pesalerno/PUMAgenomics/blob/master/maf-filters.results.txt) results, we decided to be more stringent on initial loci filtered out (keep loci present in at least 75% of individuals) and less stringent on maf (filter out loci with maf<0.01). 

**ADDITIONAL FILTER:** We found that after base #94 there were a high number of SNPs ([see here](https://github.com/pesalerno/PUMAgenomics/blob/master/reads-SNPposition.png)which were likely due to sequencing error. To filter them out, we first saw the number of times base #90-96 were found in a given SNP list using the following code: 

	cat loci-rows.txt | awk '/_90/ {count++} END {print count}'
	
	cat loci-rows.txt | awk '/_96/ {count++} END {print count}' 


We decided to only eliminate the last base sequenced (#95) from the SNP file based on the [numbers obtained](https://github.com/pesalerno/PUMAgenomics/blob/master/loci-SNPs.txt). In order to create a blacklist of loci to eliminate from the SNP matrix, we used the following **grep** commands with the **.map** output from ***populations*** as follows: 

	\d\t(\d*_\d*)\t\d\t\d*$ ##find
	\1 ##replace

Saving the file as "loci_rows-to-filter.txt", we then saved the list of loci that should be blacklisted using this code: 

	cat loci_rows-to-filter.txt | awk '/_95/ {print}' > blacklist_95.txt


We then eliminated those loci using ***plink***, the .ped and .map outputs from populations and the blacklist of SNP position #95 using with the following code: 

	plink --file Puma-filtered-maf_01 --exclude blacklist_95.txt --recode --out filtered_b --noweb
	### file terminations don't need to be added if flag is --file


Obtaining population stats using the program **populations** with a whitelist of loci and individuals that passed filters
------
	
For downstream analyses, we used the final filters of loci with 75% individuals sequenced, individuals with no less than 50% missing data, maf 0.01, and filtering out the last sequnced base (#95). This final matrix had 12456 SNPs and a genotyping rate of 0.88. The structure matrix can be found [here](https://github.com/pesalerno/PUMAgenomics/blob/master/Puma_filtered_08_17_17.stru). 


In order to get the *populations* stats outputs from STACKS, we re-ran populations using a whitelist, which requires file that only has the locis ID and excludes the SNP position ID. Thus, only the first string before the underscore needs to be kept. The whitelist file format is ordered as a simple text file containing one catalog locus per line: 

		3
		7
		521
		11
		46

We used the ***.map*** output from the last ***plink*** filter in Text Wrangler, and generated the populations whitelist using find and replace arguments using **grep**:


	search for \d\t(\d*)_\d*\t\d\t\d*$
	replace with \1

Based the **.irem** file from the second iteration of *plink* we removed from the popmap (to use in populations input) the only  individual that did not pass **plink** filter (i.e. individuals with >50% missing data). Now we can run populations again using the whitelist of loci and the updated popmap file for loci and individuals to retain based on the plink filters. 

	populations -b 1 -P ./ -M ./popmap.txt  -p 1 -r 0.5 -W Pr-whitelist --write_random_snp --structure --plink --vcf --genepop --fstats --phylip
