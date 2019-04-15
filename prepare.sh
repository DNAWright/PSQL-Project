#!/bin/bash
# prepare script for 6211 hw3


wget ftp://ftp.ncbi.nih.gov/pub/biosystems/CURRENT/bsid2info.gz

wget ftp://ftp.ncbi.nih.gov/pub/biosystems/CURRENT/biosystems_gene.gz

gunzip bsid2info.gz

gunzip biosystems_gene.gz

#with knowledge that all kegg pathways for every organism have a unique biosystem id and that the organism of interest is human, I want a file that only contains all of the information for kegg human pathways

grep "KEGG    hsa" bsid2info > bsid2info_kegg.txt

#from this file, I only want the biosystem id, kegg assession, and name of pathway columns

cut -f 1,3,4 bsid2info_kegg.txt > hsaKegg.txt

#the biosystems_gene file contains biosystems ids and their associated entrez gene ids. I want to match the biosystem ids in the hsaKegg file to the ids in the biosystems gene file

awk -F '\t' 'NR==FNR{c[$1]++;next};c[$1]' hsaKegg.txt biosystems_gene > bioSyskeggGenes.txt

#I want to remove the last column in the file and output to a new file

cut -f 1,2 bioSyskeggGenes.txt > bioSys_hsaGenes.txt


