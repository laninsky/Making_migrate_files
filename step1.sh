for i in `ls *1.fa`;
do name=`echo $i | sed 's/.fa//'`;
mv $i temp;
mv $name.2.fa temp2;
Rscript step1.R;
rm -rf temp*;
done
