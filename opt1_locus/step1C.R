temp <- read.table("temp",header=FALSE,stringsAsFactors=FALSE,sep="\t")
samplename <- read.table("tempnamefile",header=FALSE,stringsAsFactors=FALSE,sep="\t")

rows <- dim(temp)[1]
tablelength <- length(grep(">",temp[,1]))*2

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
rm(temp)
rm(to_write_seq)
rm(to_write_title)

output <- matrix(NA,ncol=1,nrow=(tablelength/2))
ambig <- c("N","R","Y","S","W","K","M","B","D","H","V", "n","r","y","s","w","k","m","b","d","h","v","?")
k <- 1

for (i in 1:tablelength) {
if ((length(grep("\\.1",to_write[i,1])))>0) {
output[k,1] <- gsub("\\.1","",to_write[i,1])
if (to_write[(i+1),1]==to_write[(i+3),1]) {
seqoutput <- to_write[(i+1),1]
} else {
temp1seq <- unlist(strsplit(to_write[(i+1),1],""))
temp2seq <- unlist(strsplit(to_write[(i+3),1],""))
seqlength <- length(temp1seq)
seqoutput <- NULL

for (j in 1:seqlength) {
if(toupper(temp1seq[j])==toupper(temp2seq[j])) {
seqoutput <- paste(seqoutput,temp1seq[j],sep="")
} else {

if(temp1seq[j]=="A" || temp1seq[j]=="a") {
if(temp2seq[j] %in% ambig) {
seqoutput <- paste(seqoutput,temp1seq[j],sep="")
}
if(temp2seq[j]=="C" || temp2seq[j]=="c") {
seqoutput <- paste(seqoutput,"M",sep="")
}
if(temp2seq[j]=="G" || temp2seq[j]=="g") {
seqoutput <- paste(seqoutput,"R",sep="")
}
if(temp2seq[j]=="T" || temp2seq[j]=="t") {
seqoutput <- paste(seqoutput,"W",sep="")
}
}

if(temp1seq[j]=="C" || temp1seq[j]=="c") {
if(temp2seq[j] %in% ambig) {
seqoutput <- paste(seqoutput,temp1seq[j],sep="")
}
if(temp2seq[j]=="A" || temp2seq[j]=="a") {
seqoutput <- paste(seqoutput,"M",sep="")
}
if(temp2seq[j]=="G" || temp2seq[j]=="g") {
seqoutput <- paste(seqoutput,"S",sep="")
}
if(temp2seq[j]=="T" || temp2seq[j]=="t") {
seqoutput <- paste(seqoutput,"Y",sep="")
}
}

if(temp1seq[j]=="G" || temp1seq[j]=="g") {
if(temp2seq[j] %in% ambig) {
seqoutput <- paste(seqoutput,temp1seq[j],sep="")
}
if(temp2seq[j]=="A" || temp2seq[j]=="a") {
seqoutput <- paste(seqoutput,"R",sep="")
}
if(temp2seq[j]=="C" || temp2seq[j]=="c") {
seqoutput <- paste(seqoutput,"S",sep="")
}
if(temp2seq[j]=="T" || temp2seq[j]=="t") {
seqoutput <- paste(seqoutput,"K",sep="")
}
}

if(temp1seq[j]=="T" || temp1seq[j]=="t") {
if(temp2seq[j] %in% ambig) {
seqoutput <- paste(seqoutput,temp1seq[j],sep="")
}
if(temp2seq[j]=="A" || temp2seq[j]=="a") {
seqoutput <- paste(seqoutput,"W",sep="")
}
if(temp2seq[j]=="C" || temp2seq[j]=="c") {
seqoutput <- paste(seqoutput,"Y",sep="")
}
if(temp2seq[j]=="G" || temp2seq[j]=="g") {
seqoutput <- paste(seqoutput,"K",sep="")
}
}

if(temp1seq[j]=="-") {
if(temp2seq[j] %in% ambig) {
seqoutput <- paste(seqoutput,temp1seq[j],sep="")
} else {
seqoutput <- paste(seqoutput,temp2seq[j],sep="")
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
}

output[(k+1),1] <- toupper(seqoutput)
k <- k+2
}
}

outputname <- paste(samplename[1,1],".fa",sep="")
write.table(output, outputname,quote=FALSE, col.names=FALSE,row.names=FALSE)
