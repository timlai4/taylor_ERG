library(biomaRt)
df <- read.csv("rna/condition_ERG_results.csv", stringsAsFactors = FALSE)
ids <- df[,1]
mart <- useDataset("hsapiens_gene_ensembl", useMart("ensembl"))
genes <- getBM(filters= "ensembl_gene_id", attributes=c("ensembl_gene_id", "external_gene_name"),values=ids, mart=mart)
write.table(genes, "ensembl_ids_names.tsv", col.names=TRUE, row.names=FALSE, quote=FALSE, sep = "\t")

