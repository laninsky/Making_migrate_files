temp1 <- read.table("temp",header=FALSE,stringsAsFactors=FALSE,sep="\t")
temp2 <- read.table("temp2",header=FALSE,stringsAsFactors=FALSE,sep="\t")
samplename <- read.table("tempnamefile",header=FALSE,stringsAsFactors=FALSE,sep="\t")

rows <- dim(temp1)[1]
output <- matrix(NA,ncol=2,nrow=(rows/2))
sequencename <- paste(">",samplename[1,1],sep="")

for (i in 1:rows) {
if ((length(grep(">",temp1[j,1])))>0) {
outputname <- gsub(">","",temp1[j,1])
if (temp1[(j+1),1]==temp2[(j+1),1]) {
output <- rbind(sequencename,temp1[(j+1),1])
write.table(output, outputname,quote=FALSE, col.names=FALSE,row.names=FALSE, append=TRUE)
} else {
temp1seq <- unlist(strsplit(temp1[(j+1),1],""))
temp2seq <- unlist(strsplit(temp2[(j+1),1],""))
seqlength <- length(temp1seq)
seqoutput <- NULL
for (j in 1:seqlength) {
if(temp1seq[j]==temp2seq[j]) {
seqoutput <- paste(seqoutput,temp1seq[j],sep="")
} else {

### Up to here...


write.table(output, outputname,quote=FALSE, col.names=FALSE,row.names=FALSE, append=TRUE)
