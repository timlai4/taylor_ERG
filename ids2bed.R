library(biomaRt)
library(tidyverse)
df <- read.table("CLIP/motif_genes.txt", stringsAsFactors = FALSE)
ids <- df[-1,1] # Get rid of column name
mart <- useDataset("hsapiens_gene_ensembl", useMart("ensembl"))
bed <- getBM(filters= "ensembl_gene_id", 
             attributes=c("chromosome_name", "start_position", "end_position", "ensembl_gene_id", "strand"),
             values=ids, mart=mart)
bed <- add_column(bed, score = 0, .before = "strand")
bed$strand <- str_replace(str_replace(bed$strand, "-1", "-"), "1", "+")
write.table(bed, "s2p/fimo.bed", col.names=FALSE, row.names=FALSE, quote=FALSE, sep = "\t")

# Check non motifs
targets <- read.table("RWPE1/target38.txt", stringsAsFactors = FALSE)
ids <- setdiff(targets$V1, bed$ensembl_gene_id)
bed <- getBM(filters= "ensembl_gene_id", 
             attributes=c("chromosome_name", "start_position", "end_position", "ensembl_gene_id", "strand"),
             values=ids, mart=mart)
bed <- add_column(bed, score = 0, .before = "strand")
bed$strand <- str_replace(str_replace(bed$strand, "-1", "-"), "1", "+")
write.table(bed, "s2p/nonfimo.bed", col.names=FALSE, row.names=FALSE, quote=FALSE, sep = "\t")
