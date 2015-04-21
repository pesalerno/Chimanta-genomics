*****************************************************************************************
*																						*
*								1. PROCESS RADTAGS										*
*																						*
*****************************************************************************************

#1. make directory for data output that matches script before running
#2. run process_radtags

> process_radtags -p ./rawdata_3/ -b adapters_Stef-b.txt -o ./process_rads_3/  -c -q -r -D \ 
		--inline_index --renz_1 sphI --renz_2 mspI -i gzfastq 

##this was done for each of the THREE libraries separately, since they have overlapping barcodes

##Adaptors file for first 16 individual library "adapters_16.txt" is as follows:
GCATG	ATCACG
AACCA	ATCACG
CGATC	ATCACG
TCGAT	ATCACG
TGCAT	ATCACG
CAACC	ATCACG
GGTTG	ATCACG
AAGGA	ATCACG
AGCTA	ATCACG
ACACA	ATCACG
AATTA	ATCACG
ACGGT	ATCACG
ACTGG	ATCACG
ACTTC	ATCACG
ATACG	ATCACG
ATGAG	ATCACG

##Adaptors file for second library "adapters_Stef.txt" is as follows:
GCATG	ATCACG
AACCA	ATCACG
CGATC	ATCACG
TCGAT	ATCACG
TGCAT	ATCACG
CAACC	ATCACG
GGTTG	ATCACG
AAGGA	ATCACG
AGCTA	ATCACG
ACACA	ATCACG
AATTA	ATCACG
ACGGT	ATCACG
ACTGG	ATCACG
ACTTC	ATCACG
ATACG	ATCACG
ATGAG	ATCACG
ATTAC	ATCACG
CATAT	ATCACG
CGAAT	ATCACG
CGGCT	ATCACG
CGGTA	ATCACG
CGTAC	ATCACG
CGTCG	ATCACG
CTGAT	ATCACG
CTGCG	ATCACG

##Adaptors file for third library ("adapters_Stef-b.txt") is as follows:
GCATG	CGATGT
AACCA	CGATGT
CGATC	CGATGT
TCGAT	CGATGT
TGCAT	CGATGT
CAACC	CGATGT
GGTTG	CGATGT
AAGGA	CGATGT
AGCTA	CGATGT
ACACA	CGATGT
AATTA	CGATGT
ACGGT	CGATGT
ACTGG	CGATGT
ACTTC	CGATGT
ATACG	CGATGT
ATGAG	CGATGT
ATTAC	CGATGT
CATAT	CGATGT
CGAAT	CGATGT
CGGCT	CGATGT
CGGTA	CGATGT
CGTAC	CGATGT
CGTCG	CGATGT
CTGAT	CGATGT
CTGCG	CGATGT

##For second Stefania library (also known as Stef_3 from raw data) five individuals always
#####have zero reads kept after doing process_radtags. Lots of time went into figuring out why
#####they were being dropped, using different combinations of raw data and barcode combinations
#####but always had the same result. Thus, those five individuals are being dropped from dataset
#####and subsequent analyses. 

##List of sequences/samples in first library (Stefania_16)
Er_417_ACTTC-ATCACG.fq
Ch_318_GCATG-ATCACG.fq
Ab_381_AATTA-ATCACG.fq
Er_430_ATGAG-ATCACG.fq
Ab_373_AGCTA-ATCACG.fq
Ch_351_AAGGA-ATCACG.fq
Ch_347_CAACC-ATCACG.fq
Ch_319_AACCA-ATCACG.fq
Ab_379_ACACA-ATCACG.fq
Er_421_ATACG-ATCACG.fq
Er_415_ACTGG-ATCACG.fq
Ch_320_CGATC-ATCACG.fq
Ch_329_TGCAT-ATCACG.fq
Ch_328_TCGAT-ATCACG.fq
Ab_406_ACGGT-ATCACG.fq
Ch_350_GGTTG-ATCACG.fq


##List of sequences/samples in second library (Stefania_2)
Ab_384_CGTAC-ATCACG.fq
Ab_374_ACTTC-ATCACG.fq
Ch_316_GCATG-ATCACG.fq
Ch_349_AATTA-ATCACG.fq
Ab_383_CGGTA-ATCACG.fq
Ab_376_ATGAG-ATCACG.fq
Ch_326_AAGGA-ATCACG.fq
Ch_348_ACACA-ATCACG.fq
Ch_317_AACCA-ATCACG.fq
Ch_324_CAACC-ATCACG.fq
Ab_375_ATACG-ATCACG.fq
Ab_372_ACTGG-ATCACG.fq
Ch_321_CGATC-ATCACG.fq
Ch_323_TGCAT-ATCACG.fq
Ab_382_CGGCT-ATCACG.fq
Ch_322_TCGAT-ATCACG.fq
Ch_352_ACGGT-ATCACG.fq
Er_412_CTGCG-ATCACG.fq
Ch_325_GGTTG-ATCACG.fq
Ab_377_ATTAC-ATCACG.fq
##dropped sequences/individuals in second library:
Ch_327_AGCTA-ATCACG.fq
Ab_407_CTGAT-ATCACG.fq
Ab_405_CGTCG-ATCACG.fq
Ab_380_CGAAT-ATCACG.fq
Ab_378_CATAT-ATCACG.fq


##List of sequences/samples in third library (Stefania_3)
Er_469_CGTCG-CGATGT.fq
Er_425_ACACA-CGATGT.fq
Er_468_CGTAC-CGATGT.fq
Er_429_ACTTC-CGATGT.fq
Er_470_CTGAT-CGATGT.fq
Er_416_CGATC-CGATGT.fq
Er_431_ATACG-CGATGT.fq
Er_419_TGCAT-CGATGT.fq
Er_433_ATTAC-CGATGT.fq
Er_467_CGGTA-CGATGT.fq
Er_418_TCGAT-CGATGT.fq
Er_435_CGAAT-CGATGT.fq
Er_428_ACTGG-CGATGT.fq
Er_422_GGTTG-CGATGT.fq
Er_426_AATTA-CGATGT.fq
Er_434_CATAT-CGATGT.fq
Er_413_GCATG-CGATGT.fq
Er_432_ATGAG-CGATGT.fq
Er_427_ACGGT-CGATGT.fq
Er_414_AACCA-CGATGT.fq
Er_436_CGGCT-CGATGT.fq
Er_420_CAACC-CGATGT.fq
Er_424_AGCTA-CGATGT.fq
Er_423_AAGGA-CGATGT.fq
TNHC05833_CTGCG-CGATGT.fq

##NOTE: There is a single Tepuihyla sample in this library that will of course be transferred from 
#####this point on to the "Tepuihyla" workflow.

#####RENAMING FILES#####
##Must rename files before continuing to denovo_map, since names are identical according to
#####barcode overlap. Can use simple find/replace type commands in unix, just to separate
#####by library, but won't be informative down the road when analyzing data

##for renaming files, I'm using Becca's "rename_barcodes_fixed.py" python script:
> module load python
> module load pylauncher
> python rename_barcodes_final.py './' '*.fq' 'barcodes.txt'


*****************************************************************
*                                                               *
*            2.READ COUNTS AND QUALITY CHECKS                   *
*                                                               *
*****************************************************************

###1. GET TOTAL NUMBER OF READS PER INDIVIDUAL AFTER INITIAL FILTER IN process_radtags

####Run entire script in terminal in folder with all processed reads:

echo -e 'SAMPLE_ID_FULL\tNUM_READS'

for file in *.fq

do
	echo -n $(basename $file .fq)$'\t'
	cat $file | grep '^@.*' | wc -l
done
 
###this will print to screen sample ID (tab) number of reads. save to a file

#file1: read-counts-Stefania.txt
=======> NEED TO ADD READ COUNTS FOR PRELIMINARY STEFANIA LIBRARY

***********************************************
***********************************************
###get plot of number of reads per individual in R and get mean and median number of reads

##########code in R if importing only the reads files:

reads <- read.table("read-counts-Stefania.txt")
readsmatrix <- as.data.frame(reads)
readsmatrix
mean(readsmatrix$V2)
##result: [1] 841618.7
median(readsmatrix$V2)
##result: [1] 577996.5
plot(readsmatrix$V2)

###this results in a plot of just the raw reads. Would be useful to get residuals or something.
#####may be more informative to graph differently for downstream analyses, to check individuals	
#####that look odd in analyses such as PCA, Structure, etc.

#NOTE: LOOK AT FILE: "readcounts_scatterplot.R" TO GET MORE INFO ON GRAPHS. ADDED ABLINES FOR 
###MEDIAN, MEAN, STDEV FOR EACH TAXON


*******************************************************
*******************************************************
####RUN FASTQC TO PERFORM BASIC DATA QUALITY CHECKS####
*******************************************************
*******************************************************

##never done this! need to learn how to...



*****************************************************************
*                                                               *
*                   3.RUN STACKS DENOVO_MAP                     *
*                                                               *
*****************************************************************

##first make output folder as named in script
##then run denovo_map.pl as such:

denovo_map.pl -T 8 -m 2 -M 3 -n 2 -S -b 2 -o ./priors_test_single/ -s ./Ch_319_AACCA-ATCACG.fq \


####should look into the three flags (-m, -n, -o) and play around a bit with the inputs for them,
#######see if they greatly affect outcomes or not. Also, should run with popmap to be able to do the 
####### -rxhapstats that Kelly recommended (if possible).

###LOOK AT FILE denovo_Stef_03_02_15.sh for details on the rest of the sequences.
#####had to drop the five sequences that did not have any data associated to them after process_rads



*****************************************************************
*                                                               *
*                   4.MORE QUALITY FILTERS IN R                 *
*                                                               *
*****************************************************************


###From nick's scripts

##>> look at the distribution of SNP position to look at potential biases

##>> look at number of SNPs per "tag" (locus)

##>> look at number of alleles per SNP > relevant also to Kelly's issue

##>> look at minor allele frequencies... filter?

##>>look at potential contaminants in BLAST

####create vector for coordinates of SNPs to be removed based on above distributions. This needs
#######to be done on a per-dataset basis. After figuring out above potential biases, then I will
#######decide which SNPs to keep and thus modify the code below that I got from Nick.

blk.coords = vector()
# this will find tags for removal
temp=substr(Bbi.all@loc.names,
            data.frame(matrix(unlist(gregexpr("_",Bbi.all@loc.names)), byrow=T))[,1],
            nchar(Bbi.all@loc.names))
blk.coords=which(temp%in%blk.list)     

# this will find snps for removal
temp=substr(Bbi.all@loc.names,
            1,
            data.frame(matrix(unlist(gregexpr("_",Bbi.all@loc.names)), byrow=T))[,1])
blk.coords=c(blk.coords,which(temp%in%blk.list))

length(blk.coords)             #this will remove 33090 of 86210 loci
head(Bbi.all@loc.names[blk.coords],25)  #check to be sure loci identified match black list
tail(Bbi.all@loc.names[blk.coords],25)
Bbi.a=Bbi.all[,loc=names(Bbi.all@loc.names[-blk.coords])]   #this is the subset of the data without the blacklisted loci

###Test for LD among loci??
###Test for HWE??



######RE-RUN STACKS?? ==> can re-run stacks with population info and flag -rxhapstats so that it'll take
##########################population haplotype data and stats into account when filtering out SNPs (from Kelly)




*****************************************************************
*                                                               *
*     5.FINAL SNP MATRIX CLEAN-UP AND EXPORT IN VCF TOOLS       *
*                                                               *
*****************************************************************











