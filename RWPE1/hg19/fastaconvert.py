# -*- coding: utf-8 -*-
"""
Created on Sun May 10 23:48:51 2020

@author: Tim
"""

from Bio.SeqIO import convert

convert("target_seq_cleaned.tsv", "tab", "target_seq.fa", "fasta")
