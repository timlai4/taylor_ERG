library(biomaRt)

geneIds <- read.csv("target38.txt", stringsAsFactors = FALSE, header = FALSE)
mart <- useDataset("hsapiens_gene_ensembl", useMart("ensembl"))
sequences <- getBM(filters= "ensembl_gene_id", attributes=c("ensembl_gene_id", "5utr"),values=geneIds, mart=mart)
write.table(sequences, "target38_sequences.tsv", col.names=FALSE, row.names=FALSE, quote=FALSE, sep = "\t")

