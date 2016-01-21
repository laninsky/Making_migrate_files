temp1 <- read.table("temp",header=FALSE,stringsAsFactors=FALSE,sep="\t")
rows <- dim(temp1)[1]

newname <- matrix(c("old_name","new_name"),ncol=2,nrow=1)
sedcommands <- NULL
numname <- 0

for (i in 1:rows) {
if ((length(grep(">",temp1[i,1])))>0) {
if (nchar(temp1[i,1])>15) {
lociname <- paste(">",numname,sep="")
numname <- numname + 1
} else {
lociname <- temp1[i,1]
}
if (!((length(grep("fasta",temp1[i,1])))>0)) {
lociname <- paste(lociname,".fasta",sep="")
}

newnametemp <- cbind(temp1[i,1],lociname)
newname <- rbind(newname,newnametemp)

sedcommandstemp <- paste("sed -i 's/",temp1[i,1],"/",lociname,"/' $f;",sep="")
sedcommands <- rbind(sedcommands,sedcommandstemp)
}
}

script1 <- as.matrix(sedcommands)
script1 <- rbind("for f in `ls *.fa`; do",script1,"done")

write.table(script1,"rename.sh",quote=FALSE, row.names=FALSE,col.names=FALSE)
write.table(newname,"locikey",quote=FALSE, row.names=FALSE,col.names=FALSE)

q()
