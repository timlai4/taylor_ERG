library(biomaRt)
grch37 <- useMart(biomart="ENSEMBL_MART_ENSEMBL", host="grch37.ensembl.org", path="/biomart/martservice", dataset="hsapiens_gene_ensembl")
mart <- useDataset("hsapiens_gene_ensembl", grch37)
geneIds <- read.csv("target.txt", stringsAsFactors = FALSE, header = FALSE)

sequences <- getBM(filters="external_gene_name", attributes=c("external_gene_name", "5utr"),values=geneIds, mart=mart)
write.table(sequences, "target_sequences.tsv", col.names=FALSE, row.names=FALSE, quote=FALSE, sep = "\t")
