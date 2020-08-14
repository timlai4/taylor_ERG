#!/bin/bash
set -e
set -u
set -o pipefail

files=($(ls *.fastq))
for file in ${files[@]}
do
    STAR --runThreadN 6 --genomeDir indices --readFilesIn $file --outFileNamePrefix STAR/${file}_
done
