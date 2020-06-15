library(biomaRt)
df <- read.table("target38.txt", stringsAsFactors = FALSE)
ids <- df[,1]
mart <- useDataset("hsapiens_gene_ensembl", useMart("ensembl"))
genes <- getBM(filters= "ensembl_gene_id", attributes=c("ensembl_gene_id", "external_gene_name"), values=ids, mart=mart)
write.table(genes, "target38_ids_names.tsv", col.names=TRUE, row.names=FALSE, quote=FALSE, sep = "\t")

df <- read.table("activated_target38.txt", stringsAsFactors = FALSE)
ids <- df[,1]
genes <- getBM(filters= "ensembl_gene_id", attributes=c("ensembl_gene_id", "external_gene_name"), values=ids, mart=mart)
write.table(genes, "activated_target38_ids_names.tsv", col.names=TRUE, row.names=FALSE, quote=FALSE, sep = "\t")

df <- read.table("repressed_target38.txt", stringsAsFactors = FALSE)
ids <- df[,1]
genes <- getBM(filters= "ensembl_gene_id", attributes=c("ensembl_gene_id", "external_gene_name"), values=ids, mart=mart)
write.table(genes, "repressed_target38_ids_names.tsv", col.names=TRUE, row.names=FALSE, quote=FALSE, sep = "\t")