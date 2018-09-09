*****************************************************************
*                                                               *
*                   1. PROCESS RADTAGS                          *
*                                                               *
*****************************************************************

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

##NOTE: There is a single Tepuihyla sample (TNHC05833)in this library that will of course be 
#####transferred from this point on to the "Tepuihyla" workflow.

#####RENAMING FILES#####
##Must rename files before continuing to denovo_map, since names are identical according to
#####barcode overlap. Can use simple find/replace or move type commands in unix, just to separate
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
 
###this will print to screen sample ID (tab) number of reads.



*******************************************************
*******************************************************
####RUN FASTQC TO PERFORM BASIC DATA QUALITY CHECKS####
*******************************************************
*******************************************************



*****************************************************************
*                                                               *
*                   3.RUN STACKS DENOVO_MAP                     *
*                                                               *
*****************************************************************



denovo_map.pl -T 8 -m 2 -M 3 -n 2 -S -b 2 -o ./priors_test_single/ -s ./Ch_319_AACCA-ATCACG.fq \


#####had to drop the five sequences that did not have any data associated to them after process_rads



*****************************************************************
*                                                               *
*                   4.EXPORT AND FILTER IN PLINK                *
*                                                               *
*****************************************************************

Exported in populations using minimal filters: 

	populations -b 1 -P ./denovo-03-2017 -M ./popmap-Tep.txt  -t 36 -p 1 -r 0.5 -W Tep-whitelist --write_random_snp --structure --plink
	

The used plink to filter sequentially first for loci with too much missing data, then individuals with too much missing data, then by minor allele frequency < 0.02.


@----------------------------------------------------------@
|        PLINK!       |     v1.07      |   10/Aug/2009     |
|----------------------------------------------------------|
|  (C) 2009 Shaun Purcell, GNU General Public License, v2  |
|----------------------------------------------------------|
|  For documentation, citation & bug-report instructions:  |
|        http://pngu.mgh.harvard.edu/purcell/plink/        |
@----------------------------------------------------------@

Skipping web check... [ --noweb ] 
Writing this text to log file [ Stef-NEW-a.log ]
Analysis started: Tue Apr  4 11:09:54 2017

Options in effect:
	--file Stef-04-04
	--geno 0.4
	--recode
	--out Stef-NEW-a
	--noweb

51504 (of 51504) markers to be included from [ Stef-04-04.map ]
Warning, found 60 individuals with ambiguous sex codes
Writing list of these individuals to [ Stef-NEW-a.nosex ]
60 individuals read from [ Stef-04-04.ped ] 
0 individuals with nonmissing phenotypes
Assuming a disease phenotype (1=unaff, 2=aff, 0=miss)
Missing phenotype value is also -9
0 cases, 0 controls and 60 missing
0 males, 0 females, and 60 of unspecified sex
Before frequency and genotyping pruning, there are 51504 SNPs
60 founders and 0 non-founders found
Total genotyping rate in remaining individuals is 0.390462
40366 SNPs failed missingness test ( GENO > 0.4 )
0 SNPs failed frequency test ( MAF < 0 )
After frequency and genotyping pruning, there are 11138 SNPs
After filtering, 0 cases, 0 controls and 60 missing
After filtering, 0 males, 0 females, and 60 of unspecified sex
Writing recoded ped file to [ Stef-NEW-a.ped ] 
Writing new map file to [ Stef-NEW-a.map ] 

Analysis finished: Tue Apr  4 11:09:58 2017


@----------------------------------------------------------@
|        PLINK!       |     v1.07      |   10/Aug/2009     |
|----------------------------------------------------------|
|  (C) 2009 Shaun Purcell, GNU General Public License, v2  |
|----------------------------------------------------------|
|  For documentation, citation & bug-report instructions:  |
|        http://pngu.mgh.harvard.edu/purcell/plink/        |
@----------------------------------------------------------@

Skipping web check... [ --noweb ] 
Writing this text to log file [ Stef-NEW-b.log ]
Analysis started: Tue Apr  4 11:10:48 2017

Options in effect:
	--file Stef-NEW-a
	--mind 0.5
	--recode
	--out Stef-NEW-b
	--noweb

11138 (of 11138) markers to be included from [ Stef-NEW-a.map ]
Warning, found 60 individuals with ambiguous sex codes
Writing list of these individuals to [ Stef-NEW-b.nosex ]
60 individuals read from [ Stef-NEW-a.ped ] 
0 individuals with nonmissing phenotypes
Assuming a disease phenotype (1=unaff, 2=aff, 0=miss)
Missing phenotype value is also -9
0 cases, 0 controls and 60 missing
0 males, 0 females, and 60 of unspecified sex
Before frequency and genotyping pruning, there are 11138 SNPs
60 founders and 0 non-founders found
Writing list of removed individuals to [ Stef-NEW-b.irem ]
14 of 60 individuals removed for low genotyping ( MIND > 0.5 )
Total genotyping rate in remaining individuals is 0.883727
0 SNPs failed missingness test ( GENO > 1 )
0 SNPs failed frequency test ( MAF < 0 )
After frequency and genotyping pruning, there are 11138 SNPs
After filtering, 0 cases, 0 controls and 46 missing
After filtering, 0 males, 0 females, and 46 of unspecified sex
Writing recoded ped file to [ Stef-NEW-b.ped ] 
Writing new map file to [ Stef-NEW-b.map ] 

Analysis finished: Tue Apr  4 11:10:49 2017

@----------------------------------------------------------@
|        PLINK!       |     v1.07      |   10/Aug/2009     |
|----------------------------------------------------------|
|  (C) 2009 Shaun Purcell, GNU General Public License, v2  |
|----------------------------------------------------------|
|  For documentation, citation & bug-report instructions:  |
|        http://pngu.mgh.harvard.edu/purcell/plink/        |
@----------------------------------------------------------@

Skipping web check... [ --noweb ] 
Writing this text to log file [ Stef-NEW-c.log ]
Analysis started: Tue Apr  4 11:11:16 2017

Options in effect:
	--file Stef-NEW-b
	--maf 0.02
	--recode
	--out Stef-NEW-c
	--noweb

11138 (of 11138) markers to be included from [ Stef-NEW-b.map ]
Warning, found 46 individuals with ambiguous sex codes
Writing list of these individuals to [ Stef-NEW-c.nosex ]
46 individuals read from [ Stef-NEW-b.ped ] 
0 individuals with nonmissing phenotypes
Assuming a disease phenotype (1=unaff, 2=aff, 0=miss)
Missing phenotype value is also -9
0 cases, 0 controls and 46 missing
0 males, 0 females, and 46 of unspecified sex
Before frequency and genotyping pruning, there are 11138 SNPs
46 founders and 0 non-founders found
Total genotyping rate in remaining individuals is 0.883727
0 SNPs failed missingness test ( GENO > 1 )
2404 SNPs failed frequency test ( MAF < 0.02 )
After frequency and genotyping pruning, there are 8734 SNPs
After filtering, 0 cases, 0 controls and 46 missing
After filtering, 0 males, 0 females, and 46 of unspecified sex
Writing recoded ped file to [ Stef-NEW-c.ped ] 
Writing new map file to [ Stef-NEW-c.map ] 

Analysis finished: Tue Apr  4 11:11:17 2017




*****************************************************************
*                                                               *
*  					   5.DOWNSTREAM ANALYSES                    *
*                                                               *
*****************************************************************











