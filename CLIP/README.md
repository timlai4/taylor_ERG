# CLIP-seq
Here, we describe our motif analysis. In particular, we searched for EWS RNA binding motif at the 5' sites of our gene target list. 

## Finding motifs
We search for motifs in CLIP-seq data published here (https://www.sciencedirect.com/science/article/pii/S2211124714002885). The data is available: http://regulatorygenomics.upf.edu/Data/EWS/
Note that the original analysis seems to have been done with hg18. The hg19 was done with a liftOver using UCSC's table browser. We took this lifted hg19 file, and lifted it to hg38. 

To make the UCSC version compatible with our Ensembl version, we reformat the data file dropping the "chr" in the chromosome names and renaming M to MT. 

```{bash}
sed 's/chr//g' hglft_genome_4e2dd_995080.bed | sed 's/^M/MT/g' > EWS_5fold_hg38.bed
```
The result is a BED file, for which we can retrieve the FASTA sequences.
```{bash}
bedtools getfasta -fo peaks.fa -fi hg38.fa -bed EWS_5fold_hg38.bed
```
The sequence file is now ready to pass into MEME-ChIP. 
```{bash}
meme-chip -meme-minw 6 -meme-maxw 15 -meme-nmotifs 5 -meme-p 4 peaks.fa
```

## Processing MEME-ChIP outputs
We consider the top three motifs from MEME-ChIP. For our EWS RNA binding motif, we decided to add the PSSM of the top three hits into one motif. The three motifs are contained in motif[1-3].txt and addmotifs.py will add them. 
Then, we use a MEME script to convert the PSSM from addmotifs.py into a formatted input for FIMO.
```{bash}
transfac2meme pwm.csv > motif.txt
```

## FIMO 
The file motif.txt contains the EWS RNA binding motif that we will use to search the 5' sites. Recall that the target list comes from the RWPE1 cell line. After running through that entire workflow, we have the target38_seqin.fa 
file, containing the underlying sequences of the genes we wish to search with FIMO.
```{bash}
fimo --oc . --verbosity 1 --thresh 1.0E-4 motif.txt target38_seqin.fa
cut -f3 fimo.tsv > motif_gene_names.txt
```
From the FIMO output, we extract the list of gene names containing hits for the EWS motif. 

### Redo
In the beginning, we considered to replicate the CLIP-seq experiment from the beginning but aligning to the hg38 assembly. We found significant issues in the FASTQ files that proved difficult to surpass. Our failed attempts are 
loosely compiled in the REDO subdirectory for reference. 
