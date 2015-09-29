temp1 <- read.table("temp",header=FALSE,stringsAsFactors=FALSE,sep="\t")
temp2 <- read.table("temp2",header=FALSE,stringsAsFactors=FALSE,sep="\t")
samplename <- read.table("tempnamefile",header=FALSE,stringsAsFactors=FALSE,sep="\t")

rows <- dim(temp1)[1]
sequencename1 <- paste(">",samplename[1,1],".1",sep="")
sequencename2 <- paste(">",samplename[1,1],".2",sep="")

for (i in 1:rows) {
if ((length(grep(">",temp1[i,1])))>0) {
if (nchar(temp1[i,1])>15) {
subname <- as.matrix(read.table("subfile",header=FALSE,stringsAsFactors=FALSE,sep="\t"))
lociname <-  as.numeric(subname[1,1])
locikey <- paste(temp1[i,1],as.numeric(subname[1,1]))
write.table(locikey, "locikey",quote=FALSE, col.names=FALSE,row.names=FALSE, append=TRUE)
subname <- as.numeric(subname[1,1]) + 1
write.table(subname, "subfile",quote=FALSE, col.names=FALSE,row.names=FALSE)
} else {
lociname <- temp1[i,1]
}
if (!((length(grep("fasta",temp1[i,1])))>0)) {
lociname <- paste(lociname,".fasta",sep="")
}

outputname <- gsub(">","",lociname)

output <- rbind(sequencename1, temp1[(i+1),1],sequencename2, temp2[(i+1),1])
write.table(output, outputname,quote=FALSE, col.names=FALSE,row.names=FALSE, append=TRUE)
}
}
