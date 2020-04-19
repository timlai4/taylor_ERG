# -*- coding: utf-8 -*-
"""
Created on Sat Apr 18 22:53:25 2020

@author: Tim
"""

import pandas as pd

df = pd.read_csv("ensembl_ids_names.tsv", sep = ' ', index_col = False)
genes = set(df['external_gene_name'])
with open("FlagERG_uniqueGenes.txt", 'r') as f:
    ERG = set(f.read().splitlines())

targets = ERG.intersection(genes)

with open('target.txt', 'w') as f:
    for target in targets:
        f.write("%s\n" % target)