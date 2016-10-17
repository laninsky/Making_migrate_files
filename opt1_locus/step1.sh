ls --no-color *.1.fa | wc -l > numtaxa

ls --no-color *.1.fa > filenames
checknames=`tail -n+1 filenames | head -n1`
cat $checknames > temp
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
