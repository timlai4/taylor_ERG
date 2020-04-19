library("DESeq2")
df <- read.delim("counts.tsv", comment.char = "#")
cts <- df[(ncol(df)-5):ncol(df)]
rownames(cts) <- df$Geneid
rows <- colnames(cts)
condition <- c("Empty", "Empty", "Empty", "ERG", "ERG", "ERG")
coldata <- data.frame(condition, row.names = rows)
dds <- DESeqDataSetFromMatrix(countData = cts,
                              colData = coldata,
                              design = ~ condition)
dds <- DESeq(dds)
res <- results(dds)
res