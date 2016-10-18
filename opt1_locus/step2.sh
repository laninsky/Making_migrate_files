touch temp

for i in `ls --color=never *.fa`;
do echo "NEW_LOCUS" >> temp;
echo $i >> temp;
cat $i >> temp;
done

Rscript step2.R
