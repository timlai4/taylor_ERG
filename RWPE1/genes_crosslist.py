# -*- coding: utf-8 -*-
"""
Created on Sat Apr 18 22:53:25 2020

@author: Tim
"""

import pandas as pd

df = pd.read_csv("rna/condition_ERG_results.csv", index_col = False)
genes = set(df.iloc[:,0])
with open("chip/flagERG_uniqueGenes.txt", 'r') as f:
    ERG = set(f.read().splitlines())

targets = ERG.intersection(genes)

with open('target38.txt', 'w') as f:
    for target in targets:
        f.write("%s\n" % target)

df = pd.read_csv("rna/ERG_activated.csv", index_col = False)
genes = set(df.iloc[:,0])
targets = ERG.intersection(genes)

with open('activated_target38.txt', 'w') as f:
    for target in targets:
        f.write("%s\n" % target)
        
df = pd.read_csv("rna/ERG_repressed.csv", index_col = False)
genes = set(df.iloc[:,0])
targets = ERG.intersection(genes)

with open('repressed_target38.txt', 'w') as f:
    for target in targets:
        f.write("%s\n" % target)
        