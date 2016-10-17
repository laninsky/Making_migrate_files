#Option 1: converting from fasta (DNA sequence)
Takes the output from the phase_everyone pipeline, and assembles it into a file that can be inputted into migrate. First, it takes the phased alleles for each sample, and creates a consensus with ambiguity codes. Then it writes out these files into locus-specific fasta files using the sample names as sequence headers. Finally, it takes these files and creates the migrate file.

#Step 1 (ambgooifying the phased files): What it needs to work
-- A folder of *.fa files (two files for each sample containing the alternate alleles for all the samples e.g. sampleA.1.fa and sampleA.2.fa) resulting from phase_everyone (https://github.com/laninsky/phase_everyone). I'd suggest copying these into a backup folder just in case you ever want to go back to the phased data. The names of the loci should be the same for every sample.

-- step1.sh, step1A.R and step1B.R in the same folder as the *.fa files.

-- to run:
```
bash step1.sh
```

During step1A.R, if the loci names are >15 characters long and/or don't have the *.fasta suffix, they are renamed. The map of old loci names to new loci names is spat out to "locikey" (this step can take a while). step1B.R is pulling out all of the loci from each sample file and dumping them into locus.fasta files. These are then run through MAFFT as the output of phase_everyone strips indels. The (re)-aligned fasta files are then pulled through step1C.R to create a single consensus sequence for each sample.

#Step 2 (building the migrate file): What it needs to work
-- Your output *.fasta files and numtaxa file from step 1 (or if you are just using this step of the script, a folder of *.fasta files from some other pipeline). The numtaxa file (if you are manually constructing it because you didn't come from step 1) is a text file with the number of taxa on the first line e.g.
```
24
```

-- A pop_map file showing which samples are found in which population (see below). Because migrate has severe limits on sample name lengths, this file will also be used to rename your samples in the migrate file (a key.txt file will be spat out with which migrate file sample name corresponds to what actual sample name).

-- step2.sh and step2.R in the same folder as these aforementioned files.

-- to run:
```
bash step2.sh
```

# Pop map designations
You need a pop_map file of your samples, separated by white space, with the population designations in the first column, and the sample names in the second column e.g.
```
Pop_1 kaloula_baleata_jam3573
Pop_1 kaloula_baleata_lsuhc5712
Pop_1 kaloula_baleata_rmb2401
Pop_1 kaloula_cfbaleata_acd1303
Pop_2 kaloula_cfconjuncta_rmb2920
Pop_2 kaloula_cfkalingensis_mgs2
Pop_2 kaloula_conjuncta_cds5679
Pop_2 kaloula_conjuncta_rmb4849
Pop_1 kaloula_indochinensis_rom32932
Pop_2 kaloula_kocakii_rmb9813
Pop_1 kaloula_mediolineata_dsm1236m
Pop_2 kaloula_meridionalis_acd4178
Pop_2 kaloula_meridionalis_rmb656
Pop_2 kaloula_negrosensis_gvag253
Pop_2 kaloula_negrosensis_rmb2251
Pop_2 kaloula_picta_rmb11744
Pop_2 kaloula_pictameridionalishybrid_rmb586
Pop_1 kaloula_pulchra_dsm1235l
Pop_2 kaloula_realkalingensis_rmb1887
Pop_2 kaloula_rigida_acd1570
Pop_2 kaloula_rigida_rmb14880
Pop_2 kaloula_spnoveluzoncfkalingensis_rmb11959
Pop_2 kaloula_walteri_rmb5662
Pop_2 kaloula_waray_rmb4321
```
