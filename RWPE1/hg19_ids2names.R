library(biomaRt)
grch37 <- useMart(biomart="ENSEMBL_MART_ENSEMBL", host="grch37.ensembl.org", path="/biomart/martservice", dataset="hsapiens_gene_ensembl")
mart <- useDataset("hsapiens_gene_ensembl", grch37)
filters = listFilters(grch37)
filters[grepl(filters[,1], pattern = "ucsc"), ]

df <- read.csv("condition_ERG_results.csv", stringsAsFactors = FALSE)
ids <- df[,1]
genes <- getBM(filters="ucsc", attributes=c("ucsc", "external_gene_name", "ensembl_gene_id"),values=ids, mart=mart)
write.table(genes, "ids_and_genenames.tsv", col.names=TRUE, row.names=FALSE, quote=FALSE)
