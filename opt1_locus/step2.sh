touch temp

for i in `ls *.fa`;
do echo "NEW_LOCUS" >> temp;
echo $i >> temp;
cat $i >> temp;
done

Rscript step2.R
