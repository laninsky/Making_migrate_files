temp <- read.table("temp",header=FALSE,stringsAsFactors=FALSE,sep="\t")
samplename <- read.table("pop_map",header=FALSE,stringsAsFactors=FALSE)
samplename <- samplename[order(samplename[,1]),] 

notaxa <- dim(samplename)[1]

key <- matrix(NA,nrow=notaxa,ncol=3)
key[1:notaxa,1] <- samplename[1:notaxa,1]
key[1:notaxa,2] <- samplename[1:notaxa,2]

k <- 1

for (i in 1:notaxa) {
if (i!=1) {
if (key[i,1]==key[(i-1),1]) {
k <- k + 1
} else {
k <- 1
}
}

newname <- paste(key[i,1],"_",k,sep="")
morhyph <- 10 - nchar(newname)
hyph <- paste(replicate(morhyph, "_"), collapse = "")
newname <- paste(newname,hyph,sep="")
key[i,3] <- newname
}

rm(hyph)
rm(i)
rm(k)
rm(morhyph)
rm(newname)
rm(samplename)

write.table(key, "key.txt",quote=FALSE, col.names=FALSE,row.names=FALSE)

popnames <- unique(key[,1])
numpops <- length(popnames)
numloci <- sum(temp[,1]=="NEW_LOCUS")

firstline <- paste(numpops,numloci,"name",sep=" ")
secondline <- NULL

for (i in 1:numpops) {
assign(paste("recmatrix",i,sep=""),matrix(""))
}

for (i in 1:numpops) {
assign(paste("locusmatrix",i,sep=""),matrix(""))
}


templength <- dim(temp)[1]

i <- 1
while (i <= templength) {
if (temp[i,1]=="NEW_LOCUS") {
for (k in 1:numpops) {
assign(paste("tempmatrix",k,sep=""),matrix(NA))
}
newtemp <- temp[i+2:(i+(2*notaxa)),1]
newtemplen <- length(newtemp)
misstemp <- NULL
for (j in 1:newtemplen) {
if ((length(grep(">",newtemp[j])))<=0) {
if (!(nchar(gsub("-","",(gsub("N","",newtemp[j]))))==0)) {
misstemp <- append(misstemp, newtemp[j-1])
misstemp <- append(misstemp, newtemp[j])
}
}
}
secondline <- paste(secondline,nchar(misstemp[2])," ",sep="")
misstemplen <- length(misstemp)

for (j in 1:misstemplen) {
if ((length(grep(">",misstemp[j])))>0) {
for (k in 1:notaxa) {
if ((length(grep(key[k,2],misstemp[j])))>0) {
toadd <- paste(key[k,3]," ",misstemp[j+1],sep="")
for (m in 1:numpops) {
if (key[k,1]==popnames[m]) {
assign(paste("tempmatrix",m,sep=""),(rbind(get(paste("tempmatrix",m,sep="")),toadd)))
assign(paste("recmatrix",m,sep=""),(rbind(get(paste("recmatrix",m,sep="")),toadd)))
break
}
}
break
}
}
}
}

for (m in 1:numpops) {
nosamples <- dim(get(paste("tempmatrix",m,sep="")))[1] - 1
assign(paste("locusmatrix",m,sep=""),paste(get(paste("locusmatrix",m,sep="")),nosamples," ",sep=""))
}
}
i <- i+1
}

#If this loop has worked, need to bind the various matrices together - don't forget to paste "population 1", "population 2" on the end of the locusmatrix lines.
