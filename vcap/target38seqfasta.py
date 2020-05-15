# -*- coding: utf-8 -*-
"""
Created on Sun May 10 15:05:42 2020

@author: Tim
"""

from Bio.SeqIO import convert

convert("target38_seq_cleaned.tsv", "tab", "target38_seq.fa", "fasta")