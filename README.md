# Making_migrate_files
You can make two different migrate file types you can using the code in this repository. 

-- Option 1 makes a locus-level migrate file. It is designed to take the output from https://github.com/laninsky/phase_everyone (fasta files by allele by sample, not by locus). However, if you have separate fasta files per locus, with diploid genotypes for individual samples collapsed to ambiguity codes, you can probably puzzle your way starting from Step 2.

-- Option 2 makes a SNP-level migrate file from a structure file (where 0=missing data, 1=A, 2=C, 3=G, 4=T). This structure file should have no locus-header row or pop_ID column (i.e. just the sample names and data).

# Suggested citation
This code was first published in: TBD

If you could cite the pub, and the progam as below, that would be lovely:

Alexander, A. 2015. making_migrate_files v0.0.0. Available from https://github.com/laninsky/Making_migrate_files

This pipeline also wouldn't be possible without:

R: R Core Team. 2015. R: A language and environment for statistical computing. URL http://www.R-project.org/. R Foundation for Statistical Computing, Vienna, Austria. https://www.r-project.org/

# Version history
v0.0.1: updated the SNP code so that it didn't break for missing populations at a locus, but just skips over and does not write that locus out.

v0.0.0: still a work in progress
