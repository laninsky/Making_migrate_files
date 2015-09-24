temp <- read.table("temp",header=FALSE,stringsAsFactors=FALSE,sep="\t")
samplename <- read.table("tempnamefile",header=FALSE,stringsAsFactors=FALSE,sep="\t")
numtaxa <- read.table("numtaxa",header=FALSE,stringsAsFactors=FALSE,sep="\t")

rows <- dim(temp)[1]
tablelength <- as.numeric(numtaxa[1,1])*4

to_write <- matrix(NA,ncol=1,nrow=tablelength)
to_write[1,1] <- temp[1,1]

to_write_title <- 2
sequencepaste <- NULL

for (j in 2:rows) {
if ((length(grep(">",temp[j,1])))>0) {
to_write_seq <- to_write_title
to_write_title <- to_write_title + 1
to_write[to_write_seq,1] <- sequencepaste
to_write[to_write_title,1] <- temp[j,1]
to_write_title <- to_write_title + 1
sequencepaste <- NULL
} else {
sequencepaste <- paste(sequencepaste,temp[j,1],sep="")
}
}

to_write[tablelength,1] <- sequencepaste

rm(j)
rm(rows)
rm(sequencepaste)
rm(tablelength)
rm(temp)
rm(to_write_seq)
rm(to_write_title)






### Need to oneline first


output <- matrix(NA,ncol=1,nrow=(rows))
sequencename <- paste(">",samplename[1,1],sep="")
ambig <- c("-","N","R","Y","S","W","K","M","B","D","H","V")

for (i in 1:rows) {
if ((length(grep(">",temp1[i,1])))>0) {
outputname <- gsub(">","",temp1[i,1])
if (temp1[(i+1),1]==temp2[(i+1),1]) {
output <- rbind(sequencename,temp1[(i+1),1])
} else {
temp1seq <- unlist(strsplit(temp1[(i+1),1],""))
temp2seq <- unlist(strsplit(temp2[(i+1),1],""))
seqlength <- length(temp1seq)
seqoutput <- NULL
for (j in 1:seqlength) {
if(temp1seq[j]==temp2seq[j]) {
seqoutput <- paste(seqoutput,temp1seq[j],sep="")
} else {

if(temp1seq[j]=="A") {
if(temp2seq[j] %in% ambig) {
seqoutput <- paste(seqoutput,temp1seq[j],sep="")
}
if(temp2seq[j]=="C") {
seqoutput <- paste(seqoutput,"M",sep="")
}
if(temp2seq[j]=="G") {
seqoutput <- paste(seqoutput,"R",sep="")
}
if(temp2seq[j]=="T") {
seqoutput <- paste(seqoutput,"W",sep="")
}
}

if(temp1seq[j]=="C") {
if(temp2seq[j] %in% ambig) {
seqoutput <- paste(seqoutput,temp1seq[j],sep="")
}
if(temp2seq[j]=="A") {
seqoutput <- paste(seqoutput,"M",sep="")
}
if(temp2seq[j]=="G") {
seqoutput <- paste(seqoutput,"S",sep="")
}
if(temp2seq[j]=="T") {
seqoutput <- paste(seqoutput,"Y",sep="")
}
}

if(temp1seq[j]=="G") {
if(temp2seq[j] %in% ambig) {
seqoutput <- paste(seqoutput,temp1seq[j],sep="")
}
if(temp2seq[j]=="A") {
seqoutput <- paste(seqoutput,"R",sep="")
}
if(temp2seq[j]=="C") {
seqoutput <- paste(seqoutput,"S",sep="")
}
if(temp2seq[j]=="T") {
seqoutput <- paste(seqoutput,"K",sep="")
}
}

if(temp1seq[j]=="T") {
if(temp2seq[j] %in% ambig) {
seqoutput <- paste(seqoutput,temp1seq[j],sep="")
}
if(temp2seq[j]=="A") {
seqoutput <- paste(seqoutput,"W",sep="")
}
if(temp2seq[j]=="C") {
seqoutput <- paste(seqoutput,"Y",sep="")
}
if(temp2seq[j]=="G") {
seqoutput <- paste(seqoutput,"K",sep="")
}
}

if(temp1seq[j] %in% ambig) {
if(temp2seq[j] %in% ambig) {
seqoutput <- paste(seqoutput,"N",sep="")
} else {
seqoutput <- paste(seqoutput,temp2seq[j],sep="")
}
}

}
}
output <- rbind(sequencename,seqoutput)
}
write.table(output, outputname,quote=FALSE, col.names=FALSE,row.names=FALSE, append=TRUE)
}
}


### Up to here...


write.table(output, outputname,quote=FALSE, col.names=FALSE,row.names=FALSE, append=TRUE)
