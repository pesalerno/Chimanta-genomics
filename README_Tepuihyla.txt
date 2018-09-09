
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


