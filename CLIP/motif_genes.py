# -*- coding: utf-8 -*-
"""
Created on Mon May 18 17:26:58 2020

@author: Tim
"""
import pandas as pd
import matplotlib.pyplot as plt

rna = pd.read_csv("../RWPE1/rna/condition_ERG_results.csv")
# For analyzing multiple motif
fimo = pd.read_csv("motifs2.tsv", sep = "\t")

motif1 = fimo[fimo['motif_alt_id'] == "MEME-1"]
motif2 = fimo[fimo['motif_alt_id'] == "MEME-2"]

names1 = list(motif1['sequence_name'])
names2 = list(motif2['sequence_name'])
names1 = [name.split('_')[0] for name in names1] # All the names including duplicates from FIMO
names2 = [name.split('_')[0] for name in names2] # All the names including duplicates from FIMO
dups1 = [name for name, count in collections.Counter(names1).items() if count > 1]
dups2 = [name for name, count in collections.Counter(names2).items() if count > 1]

rna_targets = rna[rna['Unnamed: 0'].isin(names2)]
rna_targets.sort_values(by = ['log2FoldChange'], ascending = False, inplace = True, ignore_index = True)

plot = plt.scatter(rna_targets.index, rna_targets.log2FoldChange)

# For analyzing combined motif
with open("tss_motif_genes.txt", 'r') as f:
    names = f.read().splitlines()

names = names[1:] # Removes header
rna_targets = rna[rna['Unnamed: 0'].isin(names)]
rna_targets.sort_values(by = ['log2FoldChange'], ascending = False, inplace = True, ignore_index = True)

plot = plt.scatter(rna_targets.index, rna_targets.log2FoldChange)
