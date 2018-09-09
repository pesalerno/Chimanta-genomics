
*****************************************************************************************
*																						*
*								1. PROCESS RADTAGS										*
*																						*
*****************************************************************************************

#1. make directory for data output that matches script before running
#2. run process_radtags
##this was done for each of the TWO libraries separately, since they have overlapping barcodes

##first library:
> process_radtags -p ./raw_data_A/ -b adapters_Tep_A.txt -o ./process_rads_A/  \
		-c -q -r -D --inline_index --renz_1 sphI --renz_2 mspI -i gzfastq 
##second library:
> process_radtags -p ./raw_data_B/ -b adapters_Tep-B.txt -o ./process_rads_B/  \
		-c -q -r -D --inline_index --renz_1 sphI --renz_2 mspI -i gzfastq 


##Adaptors file for first library "adapters_Tep_A.txt" is as follows:
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
CTGTC	ATCACG
CTTGG	ATCACG
GACAC	ATCACG
GAGAT	ATCACG
GAGTC	ATCACG
GCCGT	ATCACG
GCTGA	ATCACG
GGATA	ATCACG
GGCCA	ATCACG
GGCTC	ATCACG
GTAGT	ATCACG
GTCCG	ATCACG
GTCGA	ATCACG
TACCG	ATCACG
TACGT	ATCACG
TAGTA	ATCACG
TATAC	ATCACG
TCACG	ATCACG
TCAGT	ATCACG
TCCGG	ATCACG
TCTGC	ATCACG
TGGAA	ATCACG
TTACC	ATCACG

##Adaptors file for second library ("adapters_Tep-B.txt") is as follows:
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
CTGTC	CGATGT
CTTGG	CGATGT
GACAC	CGATGT
GAGAT	CGATGT
GAGTC	CGATGT
GCCGT	CGATGT
GCTGA	CGATGT
GGATA	CGATGT
GGCCA	CGATGT
GGCTC	CGATGT
GTAGT	CGATGT
GTCCG	CGATGT
GTCGA	CGATGT
TACCG	CGATGT
TACGT	CGATGT
TAGTA	CGATGT
TATAC	CGATGT
TCACG	CGATGT
TCAGT	CGATGT
TCCGG	CGATGT
TCTGC	CGATGT
TGGAA	CGATGT
TTACC	CGATGT


##List of sequences/samples in first library
Er_411_GCTGA-ATCACG.fq
Ab_369_CGTAC-ATCACG.fq
Ab_394_CTGTC-ATCACG.fq
Er_463_TCACG-ATCACG.fq
Ch_338_ACTTC-ATCACG.fq
Er_R-01_GCATG-ATCACG.fq
Ch_335_AATTA-ATCACG.fq
Ab_367_CGGTA-ATCACG.fq
Er_465_TCCGG-ATCACG.fq
Er_461_TATAC-ATCACG.fq
Ab_404_GCCGT-ATCACG.fq
Ch_359_ATGAG-ATCACG.fq
Ch_333_AGCTA-ATCACG.fq
Er_451_GTAGT-ATCACG.fq
Ab_395_CTTGG-ATCACG.fq
Ch_332_AAGGA-ATCACG.fq
Ch_334_ACACA-ATCACG.fq
Er_R-03_AACCA-ATCACG.fq
Er_455_TACCG-ATCACG.fq
Er_R-12_CAACC-ATCACG.fq
Ch_345_ATACG-ATCACG.fq
Au_05836_TTACC-ATCACG.fq
Ab_390_CTGAT-ATCACG.fq
Er_448_GGCTC-ATCACG.fq
Ch_337_ACTGG-ATCACG.fq
Ab_397_GACAC-ATCACG.fq
Er_R-04_CGATC-ATCACG.fq
Er_447_GGCCA-ATCACG.fq
Er_R-07_TGCAT-ATCACG.fq
Au_05827_TGGAA-ATCACG.fq
Er_458_TACGT-ATCACG.fq
Ab_366_CGGCT-ATCACG.fq
Er_R-05_TCGAT-ATCACG.fq
Er_452_GTCCG-ATCACG.fq
Ch_336_ACGGT-ATCACG.fq
Ab_403_GAGTC-ATCACG.fq
Er_464_TCAGT-ATCACG.fq
Er_446_GGATA-ATCACG.fq
Er_460_TAGTA-ATCACG.fq
Er_466_TCTGC-ATCACG.fq
Er_453_GTCGA-ATCACG.fq
Er_R-13_GGTTG-ATCACG.fq
Ab_393_CTGCG-ATCACG.fq
Ch_364_CGAAT-ATCACG.fq
Ch_363_CATAT-ATCACG.fq
Ab_389_CGTCG-ATCACG.fq
Ch_361_ATTAC-ATCACG.fq
Ab_400_GAGAT-ATCACG.fq


##List of sequences/samples in second library 
Au_05835_TTACC-CGATGT.fq
Er_R-16_AGCTA-CGATGT.fq
Er_R-15_AAGGA-CGATGT.fq
Ab_387_CGTCG-CGATGT.fq
Ab_391_CTGCG-CGATGT.fq
Er_R-17_ACACA-CGATGT.fq
Ab_371_CGTAC-CGATGT.fq
Er_462_GTCGA-CGATGT.fq
Er_456_GGCTC-CGATGT.fq
Er_449_GGATA-CGATGT.fq
Ch_346_ACTTC-CGATGT.fq
Er_R-08_CGATC-CGATGT.fq
Ab_398_GACAC-CGATGT.fq
Ab_388_CTGAT-CGATGT.fq
Ch_357_ATACG-CGATGT.fq
Ab_401_GAGTC-CGATGT.fq
Er_R-10_TGCAT-CGATGT.fq
Ab_399_GAGAT-CGATGT.fq
Au_05829_TCACG-CGATGT.fq
Au_05826_TAGTA-CGATGT.fq
Er_450_GGCCA-CGATGT.fq
Ch_360_ATTAC-CGATGT.fq
Er_410_GCTGA-CGATGT.fq
Au_05831_TCCGG-CGATGT.fq
Au_05832_TCTGC-CGATGT.fq
Er_459_GTCCG-CGATGT.fq
Au_05828_TATAC-CGATGT.fq
Er_R-09_TCGAT-CGATGT.fq
Ab_396_CTTGG-CGATGT.fq
Ab_370_CGGTA-CGATGT.fq
Au_05830_TCAGT-CGATGT.fq
Ab_365_CGAAT-CGATGT.fq
Ab_402_GCCGT-CGATGT.fq
Au_05825_TACGT-CGATGT.fq
Ch_339_ACTGG-CGATGT.fq
Er_R-14_GGTTG-CGATGT.fq
Ch_330_AATTA-CGATGT.fq
Ch_362_CATAT-CGATGT.fq
Er_R-02_GCATG-CGATGT.fq
Ch_358_ATGAG-CGATGT.fq
Ch_331_ACGGT-CGATGT.fq
Er_457_GTAGT-CGATGT.fq
Au_05834_TGGAA-CGATGT.fq
Au_05824_TACCG-CGATGT.fq
Er_R-06_AACCA-CGATGT.fq
Ab_368_CGGCT-CGATGT.fq
Ab_392_CTGTC-CGATGT.fq
Er_R-11_CAACC-CGATGT.fq


##NOTE: There is a single Tepuihyla sample (TNHC05833_CTGCG-CGATGT.fq) that was processed in the 
#####Stefania 2 library that will of course be transferred from this point on to the "Tepuihyla" workflow.

#####RENAMING FILES#####
##Must rename files before continuing to denovo_map, since names are identical according to
#####barcode overlap. Can use simple find/replace type commands in unix, just to separate
#####by library, but won't be informative down the road when analyzing data

##for renaming files, I'm using Becca's "rename_barcodes_fixed.py" python script:
> module load python
> module load pylauncher
> python rename_barcodes_final.py './' '*.fq' 'barcodes.txt'
###barcodes.txt file is a unique list (tab delimited) of barcode/name combinations. they script
#####replaces the string "sample" in the name, with the unique identifier from the barcodes/txt
#####file. it copies files instead of rewriting the names, so it runs slowly

*****************************************************************************************
*																						*
*						2. READ COUNTS AND QUALITY CHECKS								*
*																						*
*****************************************************************************************


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
Writing this text to log file [ Tep-04-02.log ]
Analysis started: Sun Apr  2 19:17:42 2017

Options in effect:
	--file batch_1.plink
	--geno 0.4
	--recode
	--out Tep-04-02
	--noweb

23051 (of 23051) markers to be included from [ batch_1.plink.map ]
Warning, found 97 individuals with ambiguous sex codes
Writing list of these individuals to [ Tep-04-02.nosex ]
97 individuals read from [ batch_1.plink.ped ] 
0 individuals with nonmissing phenotypes
Assuming a disease phenotype (1=unaff, 2=aff, 0=miss)
Missing phenotype value is also -9
0 cases, 0 controls and 97 missing
0 males, 0 females, and 97 of unspecified sex
Before frequency and genotyping pruning, there are 23051 SNPs
97 founders and 0 non-founders found
Total genotyping rate in remaining individuals is 0.569417
15570 SNPs failed missingness test ( GENO > 0.4 )
0 SNPs failed frequency test ( MAF < 0 )
After frequency and genotyping pruning, there are 7481 SNPs
After filtering, 0 cases, 0 controls and 97 missing
After filtering, 0 males, 0 females, and 97 of unspecified sex
Writing recoded ped file to [ Tep-04-02.ped ] 
Writing new map file to [ Tep-04-02.map ] 

Analysis finished: Sun Apr  2 19:17:45 2017

@----------------------------------------------------------@
|        PLINK!       |     v1.07      |   10/Aug/2009     |
|----------------------------------------------------------|
|  (C) 2009 Shaun Purcell, GNU General Public License, v2  |
|----------------------------------------------------------|
|  For documentation, citation & bug-report instructions:  |
|        http://pngu.mgh.harvard.edu/purcell/plink/        |
@----------------------------------------------------------@

Skipping web check... [ --noweb ] 
Writing this text to log file [ Tep-04-02-b.log ]
Analysis started: Sun Apr  2 19:18:43 2017

Options in effect:
	--file Tep-04-02
	--mind 0.5
	--recode
	--out Tep-04-02-b
	--noweb

7481 (of 7481) markers to be included from [ Tep-04-02.map ]
Warning, found 97 individuals with ambiguous sex codes
Writing list of these individuals to [ Tep-04-02-b.nosex ]
97 individuals read from [ Tep-04-02.ped ] 
0 individuals with nonmissing phenotypes
Assuming a disease phenotype (1=unaff, 2=aff, 0=miss)
Missing phenotype value is also -9
0 cases, 0 controls and 97 missing
0 males, 0 females, and 97 of unspecified sex
Before frequency and genotyping pruning, there are 7481 SNPs
97 founders and 0 non-founders found
Writing list of removed individuals to [ Tep-04-02-b.irem ]
26 of 97 individuals removed for low genotyping ( MIND > 0.5 )
Total genotyping rate in remaining individuals is 0.885012
0 SNPs failed missingness test ( GENO > 1 )
0 SNPs failed frequency test ( MAF < 0 )
After frequency and genotyping pruning, there are 7481 SNPs
After filtering, 0 cases, 0 controls and 71 missing
After filtering, 0 males, 0 females, and 71 of unspecified sex
Writing recoded ped file to [ Tep-04-02-b.ped ] 
Writing new map file to [ Tep-04-02-b.map ] 

Analysis finished: Sun Apr  2 19:18:44 2017

@----------------------------------------------------------@
|        PLINK!       |     v1.07      |   10/Aug/2009     |
|----------------------------------------------------------|
|  (C) 2009 Shaun Purcell, GNU General Public License, v2  |
|----------------------------------------------------------|
|  For documentation, citation & bug-report instructions:  |
|        http://pngu.mgh.harvard.edu/purcell/plink/        |
@----------------------------------------------------------@

Skipping web check... [ --noweb ] 
Writing this text to log file [ Tep_04_02_2_c.log ]
Analysis started: Sat Sep  8 21:04:34 2018

Options in effect:
	--file Tep-04-02-b
	--maf 0.02
	--out Tep_04_02_2_c
	--noweb

7481 (of 7481) markers to be included from [ Tep-04-02-b.map ]
Warning, found 71 individuals with ambiguous sex codes
These individuals will be set to missing ( or use --allow-no-sex )
Writing list of these individuals to [ Tep_04_02_2_c.nosex ]
71 individuals read from [ Tep-04-02-b.ped ] 
0 individuals with nonmissing phenotypes
Assuming a disease phenotype (1=unaff, 2=aff, 0=miss)
Missing phenotype value is also -9
0 cases, 0 controls and 71 missing
0 males, 0 females, and 71 of unspecified sex
Before frequency and genotyping pruning, there are 7481 SNPs
71 founders and 0 non-founders found
Total genotyping rate in remaining individuals is 0.885012
0 SNPs failed missingness test ( GENO > 1 )
2705 SNPs failed frequency test ( MAF < 0.02 )
After frequency and genotyping pruning, there are 4776 SNPs
After filtering, 0 cases, 0 controls and 71 missing
After filtering, 0 males, 0 females, and 71 of unspecified sex

Analysis finished: Sat Sep  8 21:04:36 2018

*****************************************************************
*                                                               *
*  					   5.DOWNSTREAM ANALYSES                    *
*                                                               *
*****************************************************************

