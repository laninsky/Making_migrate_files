# Getting the number of samples
ls --color=never *.1.fa | wc -l > numtaxa

# Getting a list of locus names
for i in `ls --color=never *1.fa`;
do grep ">" $i >> temptemp;
done;
sort temptemp | uniq > temp
rm -rf temptemp

# Creating a script to rename loci to "more manageable names"
Rscript step1A.R;
rm temp

# Writing out individual fasta files for each locus, containing both alleles for each sample
for i in `ls --color=never *1.fa`;
do name=`echo $i | sed 's/.1.fa//'`;
echo $name > tempnamefile;
mv $i temp;
mv $name.2.fa temp2;
Rscript step1B.R;
rm -rf temp*;
done

# Realigning all of the samples using MAFFT
for i in *.fasta; 
do mv $i temp;
mafft temp > $i;
done

rm temp

# Collapsing alleles for each individual into a single consensus sequence with ambiguity codes
for i in *.fasta; 
do name=`echo $i | sed 's/.fasta//'`;
echo $name > tempnamefile;
mv $i temp;
Rscript step1C.R;
rm -rf temp*;
done
