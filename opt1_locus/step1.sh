# Getting the number of samples
ls --color=never *.1.fa | wc -l > numtaxa

# Getting a list of file names
ls --color=never *.1.fa > filenames

# Getting a list of locus names
for i in `ls --color=never *1.fa`;
do grep ">" $i >> temptemp;
done;
sort temptemp | uniq > temp
rm -rf temptemp

# Creating a script to rename loci to "more manageable names"
Rscript step1A.R;


bash rename.sh
rm temp
rm rename.sh
rm filenames

for i in `ls *1.fa`;
do name=`echo $i | sed 's/.1.fa//'`;
echo $name > tempnamefile;
mv $i temp;
mv $name.2.fa temp2;
Rscript step1B.R;
rm -rf temp*;
done

for i in *.fasta; 
do mv $i temp;
mafft temp > $i;
done

rm temp

for i in *.fasta; 
do name=`echo $i | sed 's/.fasta//'`;
echo $name > tempnamefile;
mv $i temp;
Rscript step1C.R;
rm -rf temp*;
done
