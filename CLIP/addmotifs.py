# -*- coding: utf-8 -*-
"""
Created on Sun May 17 20:11:55 2020

@author: Tim
"""

import pandas as pd
import numpy as np

motif1 = pd.read_csv("motif1.txt", header = None, delim_whitespace = True).values
motif2 = pd.read_csv("motif2.txt", header = None, delim_whitespace = True).values
motif3 = pd.read_csv("motif3.txt", header = None, delim_whitespace = True).values

motif1 *= 916
motif2 *= 215
motif3 *= 279

motif1 = motif1.astype(int)
motif2 = motif2.astype(int)
motif3 = motif3.astype(int)
'''
new_motif = np.transpose(motif1 + motif2+motif3)

new_motif = pd.DataFrame(new_motif)
new_motif.to_csv('pwm.csv',sep = ',', index = False, header = False)
'''