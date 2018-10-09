#!/bin/bash
#Raw fastq report
fastqc *L001_R1_001.fastq.gz *L001_R2_001.fastq.gz

#Trim reads
java -jar /home/benji/Research_Programs/Trimmomatic-0.35/trimmomatic-0.35.jar PE -threads 6 -phred33 -basein *L001_R1_001.fastq.gz -baseout trim.fastq ILLUMINACLIP:/home/benji/Research_Programs/Trimmomatic-0.35/adapters/NexteraPE-PE.fa:2:30:10 LEADING:5 TRAILING:5 SLIDINGWINDOW:3:15 HEADCROP:10 CROP:275

#Trim fastq report
fastqc *1P.fq *2P.fq

#Genome assembly with SPAdes
spades.py --careful -t 6 -m 25 -k 77,99,127 -1 *1P.fastq -2 *2P.fastq -o Sample_SPAdes_Trim

#Assembly report
quast.py -f -o Sample_SPAdes_Trim/Sample_SPAdes_Trim_Quast Sample_SPAdes_Trim/contigs.fasta
