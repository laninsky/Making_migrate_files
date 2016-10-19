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

for (k in 1:numpops) {
assign(paste("tempmatrix",k,sep=""),matrix(NA))
}

templength <- dim(temp)[1]

i <- 1
while (i <= templength) {
e <- i+1
  if (temp[i,1]=="NEW_LOCUS") {
while (e < templength) {
  if(temp[e,1]=="NEW_LOCUS") {
    break
    }
  e <- e + 1
  }
if(e==(dim(temp)[1])){
e <- e + 1
  }
newtemp <- temp[(i+2):(e-1),1]
newtemplen <- length(newtemp)
secondline <- paste(secondline,nchar(newtemp[2])," ",sep="")

for (j in 1:newtemplen) {
if ((length(grep(">",newtemp[j])))>0) {
for (k in 1:notaxa) {
if ((length(grep(key[k,2],newtemp[j])))>0) {
toadd <- paste(key[k,3]," ",newtemp[j+1],sep="")
for (m in 1:numpops) {
if (key[k,1]==popnames[m]) {
assign(paste("tempmatrix",m,sep=""),(rbind(get(paste("tempmatrix",m,sep="")),toadd)))
assign(paste("recmatrix",m,sep=""),(rbind(get(paste("recmatrix",m,sep="")),toadd)))
}
}
}
}
}
}

for (m in 1:numpops) {
nosamples <- dim(get(paste("tempmatrix",m,sep="")))[1] - 1
assign(paste("locusmatrix",m,sep=""),paste(get(paste("locusmatrix",m,sep="")),nosamples," ",sep=""))
assign(paste("tempmatrix",m,sep=""),matrix(NA))
}
}
i <- e
}

secondline <- paste(secondline,"removespace",sep="")
secondline <- gsub(" removespace","",secondline)
firstline <- rbind(firstline,secondline)

for (m in 1:numpops) {
loci_to_bind <- assign(paste("locusmatrix",m,sep=""),paste(get(paste("locusmatrix",m,sep="")),popnames[m],sep=""))
firstline <- rbind(firstline,loci_to_bind)
tempdata_to_bind <- get(paste("recmatrix",m,sep=""))
maxdata <- dim(tempdata_to_bind)[1]
data_to_bind <- as.matrix(tempdata_to_bind[2:maxdata,1])
firstline <- rbind(firstline,data_to_bind)
}

write.table(firstline, "migrate.txt",quote=FALSE, col.names=FALSE,row.names=FALSE)

q()
