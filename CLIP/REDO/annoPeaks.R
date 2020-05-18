library("GenomicRanges")
library("ChIPseeker")
library("GenomicFeatures")
library("dplyr")
library("rtracklayer")

setwd("C:/Users/Tim/Documents/Git/taylor/CLIP")
txdb <- makeTxDbFromGFF("Homo_sapiens.GRCh38.99.chr.gtf")
peaks <- import("pred.bed", format="BED")
annotated  <-  annotatePeak(peaks, tssRegion = c(-2500, 2500), TxDb=txdb)

plotAnnoPie(annotated)
plotAnnoBar(annotated)
plotDistToTSS(annotated)

annotated  <- as.data.frame(annotated)
write.table(annotated, "annotated_peaks.tsv", sep = '\t', col.names = TRUE, 
            row.names = FALSE, quote = FALSE, na = "")

write.table(annotated$geneId, "geneID.txt", col.names = FALSE, 
            row.names = FALSE, quote = FALSE)
