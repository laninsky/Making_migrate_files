# phase_everyone_into_migrate
Takes the output from the phase_everyone pipeline, and assembles it into a file that can be inputted into migrate. First, it takes the phased alleles for each sample, and creates a consensus with ambiguity codes. Then it writes out these files into locus-specific fasta files using the sample names as sequence headers. Finally, it takes these files and creates the migrate file.

#Step 1 (ambgooifying the phased files): What it needs to work
-- A folder of *.fa files resulting from phase_everyone (https://github.com/laninsky/phase_everyone)
-- step1.sh and step1.R
-- to run:
```
bash step1.sh
```
