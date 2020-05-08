RNA-seq --> recommended QC with FastQC --> STAR --> feature counting (subread or htseq) --> DESeq2 or edgeR
# Differential Expression Analysis
Subreads has an important parameter to set the strand-specific information
-s
"Since your RNA-seq will likely be stranded, which means it knows which of the two DNA strands were used as a template for the RNA, it is criticial to put the correct strandedness when doing feature counting."
