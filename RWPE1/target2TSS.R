library(biomaRt)
library(tidyverse)

geneIds <- read.csv("target38.txt", stringsAsFactors = FALSE, header = FALSE)
mart <- useDataset("hsapiens_gene_ensembl", useMart("ensembl"))
# Retrieve the TSS and save as BED file.
bed <- getBM(filters= "ensembl_gene_id", 
             attributes=c("chromosome_name", "transcription_start_site", "ensembl_gene_id", "strand"),
             values=geneIds, mart=mart)
bed <- add_column(bed, score = 0, .before = "strand")
bed <- add_column(bed, end = bed$transcription_start_site + 100, .after = "transcription_start_site")
bed$strand <- str_replace(str_replace(bed$strand, "-1", "-"), "1", "+")
write.table(bed, "target_100tss.bed", col.names=FALSE, row.names=FALSE, quote=FALSE, sep = "\t")
