df <- read.delim("roar.tsv", stringsAsFactors = FALSE)
ids <- rownames(df)
entrez <- sapply(strsplit(ids, "_"), function(x) {x[1]})

# Perform the conversion with biomaRt
library(biomaRt)
mart <- useDataset("hsapiens_gene_ensembl", useMart("ensembl"))
genes <- getBM(filters = "entrezgene_id", attributes = c("entrezgene_id", "external_gene_name"), 
               values = entrez, mart = mart)

# Perform the conversion without biomaRt
library(org.Hs.eg.db)
library(annotate)
genes <- sapply(entrez, function(x) {lookUp(x,'org.Hs.eg', 'SYMBOL')})