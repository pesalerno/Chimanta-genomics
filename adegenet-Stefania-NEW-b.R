library("ape")
library("pegas")
library("seqinr")
library("ggplot2")
library("adegenet")
library("hierfstat")



myFile <- import2genind("Stef-neutral.stru") ##8019 SNPs and 46 inds 
myFile <- import2genind("Stef-adaptive.stru") ##675 SNPs and 46 inds 


##QUESTIONS:
### Which column contains the population factor ('0' if absent)? 
###answer:2
###Which other optional columns should be read (press 'return' when done)? 
###Which row contains the marker names ('0' if absent)? 
###Answer:1

myFile

summary(myFile)
pop(myFile)
names(myFile)



####convert file from genind to genpop object##
####myFile2<-genind2genpop(myFile)
####myFile2
####summary(myFile2)
####names(myFile2)
####convert file from genind to genpop object##


########################

X <- scaleGen(myFile, NA.method="mean")
X[1:5,1:5]

help('scaleGen')

pca1<-dudi.pca(X,cent=FALSE,scale=FALSE,scannf=FALSE,nf=3)


############################################
#####   to find names of outliers    #######
############################################
s.label(pca1$li)


#################################################
###  plotting PCAs with ggplot and ellipses   ###
#################################################

library(ggplot2)
plot_data<-as.data.frame(pca1$li)
plot_data$group<-pop(myFile)
ggplot(plot_data,aes(x=Axis1,y=Axis2,col=group))+geom_point()+
stat_ellipse()+theme_bw()+xlab("PC1")+scale_colour_manual(values=c("red", "darkgreen",  "royalblue4"))
histo<-data.frame(variation=pca1$eig[1:30],axes=1:30)
ggplot(histo,aes(x=axes,y=variation))+geom_bar(stat="identity")+theme_bw()


################################################
###  NEIGHBOR-JOINING TREE COMPARED TO PCA   ###
################################################
library(ape)
tre<-nj(dist(as.matrix(X)))
tre
plot(tre,typ="fan",cex=0.7)


myCol<-colorplot(pca1$li,pca1$li,transp=TRUE,cex=4)
abline(h=0,v=0,col="grey")


plot(tre,typ="fan",show.tip=FALSE)
tiplabels(pch=20,col=myCol,cex=2)




########################################################
###  DISCRIMINANT ANALYSIS OF PRINCIPAL COMPONENTS   ###
########################################################
grp<-find.clusters(X,max.n.clust=10)
###keep 20 PCs
###keep 3 clusters (original pops)
names(grp)
grp$size
table(pop(myFile),grp$grp)
dapc1<-dapc(X,grp$grp)
dapc1
scatter(dapc1)
summary(dapc1)
set.seed=(4)
contrib<-loadingplot(dapc1$var.contr,axis=2,thres=.07,lab.jitter=1)
####################################
#####   DAPC by original pops   ####
####################################


dapc2<-dapc(X,pop(myFile))
dapc2
scatter(dapc2)
summary(dapc2)
contrib<-loadingplot(dapc2$var.contr,axis=2,thres=.07,lab.jitter=1)

####################################################
###   plotting DAPCs with ggplot and ellipses    ###
####################################################
plot_dapc<-as.data.frame(dapc2$ind.coord)
plot_dapc$group=pop(myFile)

ggplot(plot_dapc,aes(x=LD1,y=LD2,col=group))+geom_point()+
stat_ellipse()+theme_bw()+xlab("LD2")+scale_colour_manual(values=c("red", "darkgreen",  "royalblue4"))
eig<-data.frame(eigs=dapc2$eig,LDs=1:2)
ggplot(eig,aes(x=LDs,y=eigs))+geom_bar(stat='identity')+
theme_bw()



####################
###  COMPOPLOT   ###
####################

compoplot(dapc2,posi="bottomright",lab="",
			ncol=1,xlab="individuals")


###################################################
###     DIVERSITY AND POPULATION MEASURES       ###
###################################################

library(hierfstat)


basicstat<-basic.stats(myFile, diploid=TRUE)
basicstat
Hobs<-basicstat$Ho
Hobs
write(Hobs, file="Stef-Hobs-04-04.txt", ncol=3)

Hexp<-basicstat$Hs
Hexp
write(Hexp, file="Stef-Hexp-04-04.txt", ncol=3)

Fis<-basicstat$Fis
Fis
write(Fis, file="Stef-Fis-04-04.txt", ncol=3)

bartlett.test(list(basicstat$Hs, basicstat $Ho)) ##this gives you a statistical
##measure of whether observed and expected heterozygosity are different


library(diveRsity)
divBasic(infile="Stef-NEW-c.gnp.txt", outfile="Stef-diversity", gp=2, bootstraps=NULL, HWEexact=FALSE)

##########################################
###  PAIRWISE Fst WITH BOOTSTRAPPING   ###
##########################################

pairwise.fst(myFile)
##replicate(10,pairwise.fst(myFile,pop=sample(pop(myFile))))
##nuc.div(myFile2)

##t.test(myFile$Hexp,myFile$Hobs,pair=T,var.equal=TRUE,alter="greater")




###################################################
###               STRATAG PACKAGE               ###
###################################################
library(strataG)
##transform file from genind to gtypes
myFile3<-genind2gtypes(myFile2)

myFile3 ##summaries of heterozygosity per population/strata

##snp.summary<-summary(myFile3)
##snp.summary
##str(snp.summary)

##summarizeLoci(myFile3)

###population structure###
##statFst(myFile3)
##statGst(myFile3, nrep=10, keep.null=TRUE)


##nucleotideDiversity(myFile3)


##strata.schemes
##myFile3




###################################################
###               popGENOME PACKAGE               ###
###################################################

##library(PopGenome)





