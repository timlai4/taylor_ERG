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

# Separate targets into ERG activated vs. repressed
activated_targets <- read.table("RWPE1/activated_target38.txt", stringsAsFactors = FALSE)
activated_ids <- intersect(activated_targets$V1, bed$ensembl_gene_id)
activated_bed <- getBM(filters= "ensembl_gene_id", 
                       attributes=c("chromosome_name", "start_position", "end_position", "ensembl_gene_id", "strand"),
                       values=activated_ids, mart=mart)
activated_bed <- add_column(activated_bed, score = 0, .before = "strand")
activated_bed$strand <- str_replace(str_replace(activated_bed$strand, "-1", "-"), "1", "+")
write.table(activated_bed, "s2p/activated_fimo.bed", col.names=FALSE, row.names=FALSE, quote=FALSE, sep = "\t")

repressed_targets <- read.table("RWPE1/repressed_target38.txt", stringsAsFactors = FALSE)
repressed_ids <- intersect(repressed_targets$V1, bed$ensembl_gene_id)
repressed_bed <- getBM(filters= "ensembl_gene_id", 
                       attributes=c("chromosome_name", "start_position", "end_position", "ensembl_gene_id", "strand"),
                       values=repressed_ids, mart=mart)
repressed_bed <- add_column(repressed_bed, score = 0, .before = "strand")
repressed_bed$strand <- str_replace(str_replace(repressed_bed$strand, "-1", "-"), "1", "+")
write.table(repressed_bed, "s2p/repressed_fimo.bed", col.names=FALSE, row.names=FALSE, quote=FALSE, sep = "\t")

# Check non motifs
targets <- read.table("RWPE1/target38.txt", stringsAsFactors = FALSE)
ids <- setdiff(targets$V1, bed$ensembl_gene_id)
bed <- getBM(filters= "ensembl_gene_id", 
             attributes=c("chromosome_name", "start_position", "end_position", "ensembl_gene_id", "strand"),
             values=ids, mart=mart)
bed <- add_column(bed, score = 0, .before = "strand")
bed$strand <- str_replace(str_replace(bed$strand, "-1", "-"), "1", "+")
write.table(bed, "s2p/nonfimo.bed", col.names=FALSE, row.names=FALSE, quote=FALSE, sep = "\t")

activated_ids <- setdiff(activated_targets$V1, activated_bed$ensembl_gene_id)
activated_bed <- getBM(filters= "ensembl_gene_id", 
                       attributes=c("chromosome_name", "start_position", "end_position", "ensembl_gene_id", "strand"),
                       values=activated_ids, mart=mart)
activated_bed <- add_column(activated_bed, score = 0, .before = "strand")
activated_bed$strand <- str_replace(str_replace(activated_bed$strand, "-1", "-"), "1", "+")
write.table(activated_bed, "s2p/activated_nonfimo.bed", col.names=FALSE, row.names=FALSE, quote=FALSE, sep = "\t")

repressed_ids <- setdiff(repressed_targets$V1, repressed_bed$ensembl_gene_id)
repressed_bed <- getBM(filters= "ensembl_gene_id", 
                       attributes=c("chromosome_name", "start_position", "end_position", "ensembl_gene_id", "strand"),
                       values=repressed_ids, mart=mart)
repressed_bed <- add_column(repressed_bed, score = 0, .before = "strand")
repressed_bed$strand <- str_replace(str_replace(repressed_bed$strand, "-1", "-"), "1", "+")
write.table(repressed_bed, "s2p/repressed_nonfimo.bed", col.names=FALSE, row.names=FALSE, quote=FALSE, sep = "\t")

