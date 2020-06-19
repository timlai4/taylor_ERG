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

# We are interested in considering promoters (and their genes) vs. enhancers
# Here, we define promoter to be +/- 500 from TSS.
promoters <- annotated$annotation == "Promoter (<=1kb)" 
gene_bed_columns <- c(13, 14, 15, 18, 7, 17) # The columns in annotated that comprise the BED information.
promoter_genes <- annotated[promoters, gene_bed_columns]
enhancer_genes <- annotated[!promoters, gene_bed_columns]
promoter_genes <- mutate(promoter_genes, geneStrand = ifelse(geneStrand == 1, "+", "-"))
enhancer_genes <- mutate(enhancer_genes, geneStrand = ifelse(geneStrand == 1, "+", "-"))
write.table(promoter_genes, "promoter_genes.bed", sep = '\t', 
            col.names = FALSE, row.names = FALSE, quote = FALSE, na = "")
write.table(enhancer_genes, "enhancer_genes.bed", sep = '\t', 
            col.names = FALSE, row.names = FALSE, quote = FALSE, na = "")
# Now, save as BED files for downstream analyses.
bed_columns <- c(1, 2, 3, 6, 7)
write.table(annotated[promoters, bed_columns], "promoter_peaks.bed", sep = '\t', 
            col.names = FALSE, row.names = FALSE, quote = FALSE, na = "")
write.table(annotated[!promoters, bed_columns], "enhancer_peaks.bed", sep = '\t', 
            col.names = FALSE, row.names = FALSE, quote = FALSE, na = "")
