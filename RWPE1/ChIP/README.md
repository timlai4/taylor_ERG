# RWPE1 ChIP-seq
We detail the ChIP-seq workflow described in the main README.md contained in the root directory applied to the RWPE1 cell line. 
## Data 
We analyzed one treated ChIP-seq with a control sample, both retrieved from SRA. 
```{bash}
wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos1/sra-pub-run-1/SRR314997/SRR314997.3 # Control
wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos1/sra-pub-run-1/SRR315000/SRR315000.3 # Target
```
## Analysis
A quick inspection of the FASTQC report does not reveal any major flaws. We proceed with the main ChIP-seq protocol. Our annoPeaks.R annotates the resulting peaks. We discard peaks annotated as distal
```{bash}
awk '$12 !~ /Distal/' annotated_peaks.tsv | cut -f 18 | sort | uniq > flagERG_uniqueGenes.txt
```
