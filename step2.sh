touch temp

for i in `ls *1.fa`;
do echo "NEW_LOCUS" >> temp;
echo $i >> temp;
cat $i >> temp;
done

