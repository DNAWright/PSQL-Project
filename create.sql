CREATE DATABASE project_6211;

\c project_6211

CREATE TABLE hsaKegg (
	bio_sys_id INTEGER PRIMARY KEY,
	kegg_accession VARCHAR UNIQUE,
	pathway VARCHAR
);

/* kegg_accession is set to UNIQUE constraint so that every accession number in the column is unique to a human pathway identifier in KEGG; I want to be able to create an index for the accession column using the UNIQUE constraint so that pulling information for a specific pathway is done more efficiently */



CREATE TABLE hsaGenes (
	bio_sys_id INTEGER REFERENCES hsaKegg(bio_sys_id),
	entrez_gene_id INTEGER,
	PRIMARY KEY (bio_sys_id, entrez_gene_id)
);

/* bio_sys_id is set to FOREIGN KEY constraint because I want all of the key ids in the hsaGenes table to match with the ids in the hsaKegg table. Since I have duplicate values, I have to set the PRIMARY KEY to bio_sys_id and entrez_gene_id */


/* now I want to insert all of the data values from both output files I created into the tables in my database */


COPY hsaKegg (bio_sys_id, kegg_accession, pathway) FROM '/home/cigba/hsaKegg.txt' WITH (FORMAT CSV, DELIMITER '	');

COPY hsaGenes (bio_sys_id, entrez_gene_id) FROM '/home/cigba/bioSys_hsaGenes.txt' WITH (FORMAT CSV, DELIMITER '	');


/* appending gene name data to hsaGenes table */

CREATE TABLE entrezID_geneName (
	entrez_gene_id INTEGER PRIMARY KEY,
	gene_name VARCHAR
);

COPY entrezID_geneName (entrez_gene_id, gene_name) FROM '/home/cigba/geneNames.txt' WITH (FORMAT CSV, DELIMITER '	');
