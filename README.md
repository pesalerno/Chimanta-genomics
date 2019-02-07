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

### Step 3: Filtering the SNP matrix.


After genotyping, we first exported the SNP matrix with minimal filter in *populations*: 
	
	populations -b 2 -P ./pop-comb-c/ -M ./pop-map-combine -fstats -k -p 1 -r 0.2  -t 8 --structure --genepop --vcf --plink --write_random_snp


We filtered the SNP matrix using [PLINK](http://pngu.mgh.harvard.edu/~purcell/plink/summary.shtml) in the following way:

For *Tepuihyla*, we ran (for each flag separately): 

	./plink --file input-name --geno 0.4 --mind 0.6 --maf 0.02 
	
For *Stefania*, we did: 

	./plink --file input-name --geno 0.5 --mind --0.5 --maf 0.02


In both cases, filtering parameters were based on the combination that increased the amount of individuals and SNPs retained in all populations. 


In *Tepuihyla*, the [resulting SNP matrix](https://github.com/pesalerno/Chimanta-genomics/blob/master/Tep-04-02-c.stru) used in downstream analyses had a total missingness of 0.885012 and retained 4776 SNPs and 71 individuals. 

In *Stefania*, the [resulting SNP matrix](https://github.com/pesalerno/Chimanta-genomics/blob/master/Stef-NEW-c.stru) used in downstream analyses had a total missingness of 0.883727 and retained 8734 SNPs and 46 individuals.

	>Correct matrices!!! (they have excluded individuals still in there)
 
###
###
Filtering out outlier loci
We ran PCAdapt for Stefania and for Tepuihyla using the code attached and found xx outliers for Stefania and XX outliers for Tepuihyla. 

PCAdapt outputs the "order" of the loci rather than the IDs of the loci themselves, so to exclude the outliers we generated a blacklist like this:

##Fetch identities of Tepuihyla adaptive loci:
awk '{print $16,$17,$34,$54,$60,$76,$129,$147,$179,$200,$218,$245,$305,$306,$308,$318,$319,$332,$333,$348,$356,$361,$369,$370,$371,$383,$393,$416,$423,$435,$447,$488,$491,$552,$558,$561,$566,$568,$585,$591,$604,$621,$638,$647,$660,$679,$680,$685,$686,$689,$693,$696,$702,$723,$733,$749,$764,$776,$787,$791,$816,$847,$851,$855,$901,$915,$918,$923,$963,$970,$990,$996,$1005,$1037,$1047,$1093,$1098,$1118,$1139,$1155,$1157,$1161,$1164,$1172,$1197,$1230,$1248,$1257,$1273,$1276,$1285,$1337,$1361,$1385,$1408,$1416,$1444,$1446,$1463,$1470,$1477,$1481,$1485,$1506,$1524,$1545,$1574,$1596,$1610,$1681,$1692,$1702,$1719,$1726,$1730,$1755,$1763,$1768,$1795,$1798,$1809,$1815,$1816,$1823,$1867,$1880,$1881,$1882,$1903,$1906,$1933,$1949,$1961,$1973,$2005,$2017,$2020,$2057,$2074,$2123,$2176,$2215,$2274,$2291,$2320,$2333,$2356,$2378,$2382,$2383,$2391,$2421,$2422,$2440,$2483,$2486,$2492,$2496,$2498,$2504,$2525,$2532,$2533,$2556,$2582,$2588,$2589,$2621,$2630,$2634,$2638,$2655,$2670,$2675,$2701,$2724,$2755,$2769,$2781,$2810,$2813,$2849,$2872,$2900,$2907,$2911,$2956,$2970,$3000,$3007,$3014,$3032,$3033,$3041,$3072,$3075,$3111,$3130,$3132,$3226,$3236,$3238,$3243,$3244,$3257,$3263,$3277,$3290,$3294,$3297,$3311,$3328,$3337,$3346,$3380,$3381,$3393,$3398,$3404,$3416,$3430,$3434,$3439,$3442,$3445,$3481,$3484,$3490,$3527,$3537,$3574,$3583,$3592,$3594,$3607,$3617,$3618,$3627,$3635,$3642,$3660,$3698,$3716,$3724,$3727,$3745,$3777,$3778,$3787,$3801,$3827,$3835,$3837,$3882,$3890,$3896,$3903,$3914,$3948,$3952,$3961,$3984,$3996,$3998,$4005,$4080,$4105,$4125,$4144,$4168,$4193,$4198,$4212,$4216,$4220,$4226,$4240,$4243,$4245,$4257,$4267,$4286,$4337,$4377,$4388,$4412,$4423,$4431,$4437,$4450,$4452,$4459,$4464,$4481,$4509,$4512,$4514,$4577,$4586,$4588,$4618,$4653,$4656,$4718,$4728,$4731,$4733,$4749}' Tepuihyla.stru > Tep_white-adaptive-loci.txt

##Fetch identities of Stefania adaptive loci: 


Which generates a line of the loci identities. Then doing a couple of find and replace arguments we obtain the whitelist file for putatively adaptive (outlier) loci based on PCAdapt.


find and replace :
	(d*)_\d*$
	\1


>Obtaining population stats using the program **populations** with a whitelist of loci and individuals that passed filters

	
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

#Step 4: Structure and population estimates in adegenet

We ran Principal Components and Discriminant Analyses using **adegenet**, and obtained some population measures using the package **hierfstat** in R. 

> The code used for adegenet and hierfstat analyses can be found [here](https://github.com/pesalerno/Chimanta-genomics/blob/master/adegenet-Tepuihyla-NEW.R) for *Tepuihyla* and [here](https://github.com/pesalerno/Chimanta-genomics/blob/master/adegenet-Stefania-NEW-b.R) for *Stefania*.


#Step 5: Obtaining maximum likelihood phylogenies for all datasets. 

To obtain SNP phylogenies with bootstraps for *Stefania* and *Tepuihyla*:

	./raxml-ng --all --msa Stef-NEW-c.phylip.txt --model GTR+G --tree pars {10} --bs-trees 200


To obtain mitochondrial phylogenies with bootstraps for *Stefania* and *Tepuihyla*:

	./raxmlHPC -m GTRGAMMA -m 12345 -# 20 -s inputname.phy -n outputname

>the above code does 20 ML searches and finds the best tree

	./raxmlHPC -m GTRGAMMA -p 12345 -b 12345 -# 1000 -s inputname.phy -n outputname

>the above code runs 1000 bootstraps

	./raxmlHPC -m GTRCAT -p 12345 -f b -t besttree -z bootstraps -n outputname 

>the above code writes the bootstraps onto the best likelihood tree. 
