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



#UP TO HERE - ALSO NEED TO WORK OUT THE NUMBER OF POPS USING UNIQUE, AND THEN SPAWN SINGLE COLUMN MATRICES FOR EACH OF THE POPS
