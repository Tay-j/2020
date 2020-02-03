setwd("/wehisan/home/allstaff/t/tay.j/2020/1000genomes")
library("vcfR")

#chr8 <- read.delim(file="vcf/chr8.vcf", sep="\t")
#pkg <- "chr8"
#chr8 <- system.file("extdata", "vcf/chr8.vcf", package = pkg)
vcfchr8 <- read.vcfR("/stornext/Bioinf/data/lab_bahlo/projects/methods_dev/Haplotype_Dee/simulation/1000GenomeHap/CHRandEUR/Done/vcf/chr8.vcf", verbose = FALSE) # read into vcfR format
gtchr8 <- extract.gt(vcfchr8) # extract genotype data
for (colx in colnames(gt8)) {
  assign(colx,gt8[,colx])
}
#vcfraw <- read.delim("/stornext/HPCScratch/lab_bahlo/MySQL_test/gatk/SL_IND_bisnps_maf.vcf", sep = "\t")
vcfFAME1up <- read.vcfR("/stornext/HPCScratch/lab_bahlo/MySQL_test/gatk/SL_IND_bisnps_maf.vcf", verbose = FALSE) 
gtFAME1up <- extract.gt(vcfFAME1up)
write.table(gtFAME1up, file = "FAME1-MAF-filtered.txt", sep = "\t")
#test <- read.delim(file = "FAME1-MAF-filtered.txt")
pedFAME1up <- read.table("/wehisan/bioinf/lab_bahlo/projects/methods_dev/Haplotype_Dee/Data/FAME1/Details/FAME1_SL_Indian.ped", sep = "\t", col.names = c("Family","Individual","Father","Mother","Sex","Phenotype"), stringsAsFactors = FALSE) # extract pedigree
#mutations <- read.table('/wehisan/bioinf/lab_bahlo/users/tay.j/2020/data/REs/repeat_expansion_disorders_hg38.txt', sep = "\t", header = TRUE, stringsAsFactors = FALSE)
vcfFAME1p <- read.vcfR("/stornext/HPCScratch/lab_bahlo/MySQL_test/gatk/FAME1_chr8_phased_eagle.vcf", verbose = FALSE)
gtFAME1p <- extract.gt(vcfFAME1p)


familysize <- length(pedFAME1up$Family) # count number of samples
uniquesize <- length(unique(pedFAME1up$Individual)) # count number of indiviuals

### generate dataframe/table for samples in MySQL schema format 
sampleID <- c(1:familysize) # unique
famID <- c(rep(1,sum(pedFAME1up$Family=="SL")),rep(2,sum(pedFAME1up$Family=="Ind")))
individualID <- c(1:uniquesize) # accounts for multiple samples
fatherID <- sampleID[match(pedFAME1up$Father, pedFAME1up$Individual)] # Null instead of NA?
motherID <- sampleID[match(pedFAME1up$Mother, pedFAME1up$Individual)]
gender <- pedFAME1up$Sex
affected <- pedFAME1up$Phenotype
haplotype <- c(rep("xyz",familysize))
ethnicity <- pedFAME1up$Family
mutation <- c(rep("FAME1",familysize))
validation <- c(rep("Pedigree",familysize))
labID <- pedFAME1up$Individual # external individual ID
datatype <- c(rep("WGS",familysize))
samples <- data.frame(sampleID,famID,individualID,fatherID,motherID,gender,affected,haplotype,ethnicity,mutation,validation,labID,datatype)
write.table(samples, file = "samples.txt", sep = "\t", col.names = FALSE, row.names = FALSE)
###

### generate dataframe/table for geneticmarkers in MySQL schema format
markerID <- 
markername <- 
markerchr <- "chr8"
positionBP <- 
REF <- 
ALT <- 
markertype <- "SNP"
geneticmarkers <- data.frame(markerID,markername,markerchr,markerpositionBP,REF,ALT,markertype)
write.table(geneticmarkers, file = "geneticmarkers.txt", sep = "\t", col.names = FALSE, row.names = FALSE)
###

# from https://github.com/bahlolab/exSTRa development Bennett branch

### generate dataframe/table for mutations in MySQL schema format
ID <- 1
gene <- "SAMD12"
motif <- "TTTCA"
disease <- "FAME1"
diseasemodel <- "AD"
startHG19 <- 119379052
endHG19 <- 119379155
startHG38 <- 118366813
endHG38 <- 118366815
region <- "intron"
OMIMID <- 601068
pathogenicmutations <- data.frame(ID,gene,motif,disease,diseasemodel,startHG19,endHG19,startHG38,endHG38,region,OMIMID)
write.table(pathogenicmutations, file = "pathogenicmutations.txt", sep = "\t", col.names = FALSE, row.names = FALSE)
###

### generate dataframe/table for genetic data in MySQL schema format
#marker <- rep(NA,0)
#for (markerx in rownames(gtFAME1p)[1:2]) {
#  marker <- append(marker,rep(markerx,familysize))
#}
marker <- rep(gtFAME1p[,1],familysize)
#individual <- rep(sampleID[match(substr(colnames(gtFAME1p),1,10), pedFAME1up$Individual)],length(gtFAME1p))
individual <- rep(NA,0)
for (sample in sampleID[match(substr(colnames(gtFAME1p),1,10), pedFAME1up$Individual)]) {
  individual <- append(individual,rep(sample,length(gtFAME1p[,1])))
}
gt_convert <- c("0|0" = 0, "0|1" = 1, "1|0" = 2, "1|1" = 3)
genotype <- gt_convert[gtFAME1p]
geneticdata <- data.frame(marker,individual,genotype)
###

write.table(geneticdata, file = "geneticdata.txt", sep = "\t", col.names = FALSE, row.names = FALSE) # export into txt for further import
