# phase_everyone_into_migrate
Takes the output from the phase_everyone pipeline, and assembles it into a file that can be inputted into migrate. First, it takes the phased alleles for each sample, and creates a consensus with ambiguity codes. Then it writes out these files into locus-specific fasta files using the sample names as sequence headers. Finally, it takes these files and creates the migrate file.

#Step 1 (ambgooifying the phased files): What it needs to work
-- A folder of *.fa files (two files for each sample containing the alternate alleles for all the samples) resulting from phase_everyone (https://github.com/laninsky/phase_everyone)
-- step1.sh, step1A.R and step1B.R
-- to run:
```
bash step1.sh
```

step1A.R is pulling out all of the loci from each sample file and dumping them into locus.fasta files. These are then run through MAFFT as the output of phase_everyone strips indels. The (re)-aligned fasta files are then pulled through step1B.R to create a single consensus sequence for each sample. 

#Step 2

You need a pop map of your samples e.g.
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
