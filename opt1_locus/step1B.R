temp1 <- read.table("temp",header=FALSE,stringsAsFactors=FALSE,sep="\t")
temp2 <- read.table("temp2",header=FALSE,stringsAsFactors=FALSE,sep="\t")
samplename <- read.table("tempnamefile",header=FALSE,stringsAsFactors=FALSE,sep="\t")

rows <- dim(temp1)[1]
sequencename1 <- paste(">",samplename[1,1],".1",sep="")
sequencename2 <- paste(">",samplename[1,1],".2",sep="")

for (i in 1:rows) {
if ((length(grep(">",temp1[i,1])))>0) {
outputname <- paste((gsub(">","",temp1[i,1])),".fasta",sep="")
output <- rbind(sequencename1, temp1[(i+1),1],sequencename2, temp2[(i+1),1])
write.table(output, outputname,quote=FALSE, col.names=FALSE,row.names=FALSE, append=TRUE)
}
}
