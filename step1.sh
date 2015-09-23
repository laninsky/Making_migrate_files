for i in `ls *1.fa`;
do name=`echo $i | sed 's/.1.fa//'`;
echo $name > tempnamefile;
mv $i temp;
mv $name.2.fa temp2;
Rscript step1.R;
rm -rf temp*;
done
