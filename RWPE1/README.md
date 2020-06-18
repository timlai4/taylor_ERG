# RWPE1
In this subdirectory, we describe the scripts and analysis steps that are mostly contained within the RWPE1 cell line. Most of the analyses begin with either an RNA-seq or ChIP-seq. These are further separated into their 
respective subdirectories. At the beginning of the analysis, we were using hg19 from UCSC, which required its own set of tools and scripts. At this point, we have migrated to hg38. However, we keep the scripts for hg19 in its own 
subdirectory for both posterity and potential future use. 

## RNA and ChIP-seq
The documentation for the beginning stages of RNA and ChIP seq, such as alignment, are contained in the master README.md found in the root directory. For documentation on deviations and additions to the workflow, we refer to the 
README.md in the respective subdirectories. In this README.md, we will describe how we integrate the two workflows for downstream analysis. 

### RNA-seq Outputs
From the RNA-seq workflow, we obtain important statistics about our genes, especially related to their differential expression. Using these statistics, we can extract genes satisfying certain criteria, in our case, exceeding 
differentially expressed thresholds determined by the log-two fold change and FDR. We note that these are hyperparameters for which our selections are partially motivated by precedence. In any case, we have explored several 
iterations. In the end, we obtain a list of genes, contained in condition_ERG_results.csv to further investigate based on the hyperparameters chosen. At certain points, we desired to further subset these datasets, (e.g. 
considering 
repressed vs. activated genes), and several scripts support these auxiliary functions. 

### ChIP-seq Outputs
Similar to the RNA-seq, the ChIP-seq workflow outputs a list of target genes. In this case, these are the significant genes to which ERG is binding, in a text file flagERG_uniqueGenes.txt. Several informative statistics are also 
output in addition to the main list. 

### Integrating RNA and ChIP-seqs
The main purpose of this documentation was to describe how we integrate the RNA and ChIP-seq data. We document this now. First, the script ids2names.R takes the output of the RNA-seq DGE, which gives gene ID's, and appends the 
corresponding gene name. The output is saved in ensembl_ids_names.tsv. Next, a helper Python script genes_crosslist.py takes the RNA-seq information and intersects it with the ChIP-seq genes. The resulting genes represent the 
overall targets we wish to consider for further downstream analysis, which includes sequence-level statistics, such as motif search. To facilitate this, we extract the FASTA file, i.e. the underlying sequences, to various 
regions of interest corresponding to the gene names. 
The R script taret2sequences.R or target2TSS.R followed by a small cleanup step in the terminal
```{bash}
grep -v "Sequence unavailable" target38_sequences.tsv > target38_seq_cleaned.tsv
```
accomplishes this. In particular, the former extracts the 5' UTR regions while the latter targets the 100bp downstream of the TSS. Finally, we convert the tab-separated file into FASTA in BioPython using target38seqfasta.py. Note 
that in all of these steps, the scripts support additional subsetting alluded to in the RNA-seq outputs 
section. 
