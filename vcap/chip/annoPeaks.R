library("GenomicRanges")
library("ChIPseeker")
library("GenomicFeatures")
library("dplyr")
library("rtracklayer")

# ensure the extra columns in the macs2 narrowpeaks are carried over
extraCols_narrowPeak  <-  c(signal.value = "numeric", p.value.negLog10 = "numeric", 
                            q.value.negLog10 = "numeric", peak = "integer")
txdb <- makeTxDbFromGFF("Homo_sapiens.GRCh38.99.chr.gtf")
peaks <- import("aERG_peaks.narrowPeak", format="BED", extraCols=extraCols_narrowPeak)
annotated  <-  annotatePeak(peaks, tssRegion = c(-2500, 2500), TxDb=txdb)

plotAnnoPie(annotated)
plotAnnoBar(annotated)
plotDistToTSS(annotated)

annotated  <- as.data.frame(annotated)
write.table(annotated, "annotated_peaks.tsv", sep = '\t', col.names = TRUE, 
            row.names = FALSE, quote = FALSE, na = "")
            