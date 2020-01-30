setwd("/wehisan/home/allstaff/t/tay.j/2020/1000genomes")
library("vcfR")

#chr8 <- read.delim(file="vcf/chr8.vcf", sep="\t")
#pkg <- "chr8"
#chr8 <- system.file("extdata", "vcf/chr8.vcf", package = pkg)
vcfchr8 <- read.vcfR("/stornext/Bioinf/data/lab_bahlo/projects/methods_dev/Haplotype_Dee/simulation/1000GenomeHap/CHRandEUR/Done/vcf/chr8.vcf", verbose = FALSE)
gtchr8 <- extract.gt(vcfchr8)
for (colx in colnames(gt8)) {
  assign(colx,gt8[,colx])
}
vcfraw <- read.delim("/stornext/HPCScratch/lab_bahlo/MySQL_test/gatk/SL_IND_bisnps_maf.vcf", sep = "\t")
vcfFAME1up <- read.vcfR("/stornext/HPCScratch/lab_bahlo/MySQL_test/gatk/SL_IND_bisnps_maf.vcf", verbose = FALSE)
gtFAME1up <- extract.gt(vcfFAME1up)
write.table(gtFAME1up, file = "FAME1-MAF-filtered.txt", sep = "\t")
#test <- read.delim(file = "FAME1-MAF-filtered.txt")
pedFAME1up <- read.table("/wehisan/bioinf/lab_bahlo/projects/methods_dev/Haplotype_Dee/Data/FAME1/Details/FAME1_SL_Indian.ped", sep = "\t", col.names = c("Family","Individual","Father","Mother","Sex","Phenotype"), stringsAsFactors = FALSE)

familysize <- length(pedFAME1up$Family)
uniquesize <- length(unique(pedFAME1up$Individual))

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

markerID <- 
markername <- 
markerchr <- 
markerpositionBP <- 
REF <- 
ALT <- 
markertype <- 
geneticmarkers <- data.frame(markerID,markername,markerchr,markerpositionBP,REF,ALT,markertype)
write.table(samples, file = "geneticmarkers.txt", sep = "\t", col.names = FALSE, row.names = FALSE)

ID <- 
gene <- 
motif <- 
disease <- 
diseasemodel <-
positionBP <- 
region <- 
OMIMID <- 
pathogenicmutations <- data.frame(ID,gene,motif,disease,diseasemodel,positionBP,region,OMIMID)
write.table(samples, file = "pathogenicmutations.txt", sep = "\t", col.names = FALSE, row.names = FALSE)

marker <- 
genotype <- 
chr <- 
geneticdata <- data.frame(marker,genotype,chr)
write.table(samples, file = "geneticdata.txt", sep = "\t", col.names = FALSE, row.names = FALSE)