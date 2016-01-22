step1_SNP <- function(working_dir,structure_file_name) {
}

working_dir <- "C:/Users/a499a400/Dropbox/ceyx/lamarc"
structure_file_name <- "cerit_mod_structure.txt"

#Reading in our files
setwd(working_dir)
temp <- read.table(structure_file_name,header=FALSE,stringsAsFactors=FALSE)
samplename <- read.table("pop_map",header=FALSE,stringsAsFactors=FALSE)

#Getting the number of taxa (actually alleles, as our structure file has two rows per sample)
notaxa <- dim(temp)[1]

#Giving each of the alleles a unique name
odds <- seq(1,notaxa,2)
evens <- seq(2,notaxa,2)
temp[odds,1] <- paste(temp[odds,1],"_A",sep="")
temp[evens,1] <- paste(temp[evens,1],"_B",sep="")

#Matching our new 'unique' allele names up to the pop_map file
samplename <- rbind(samplename,samplename)
samplename[1:(notaxa/2),2] <- paste(samplename[1:(notaxa/2),2],"_A",sep="")
samplename[((notaxa/2)+1):notaxa,2] <- paste(samplename[((notaxa/2)+1):notaxa,2],"_B",sep="")
samplename <- samplename[order(samplename[,2]),] 
samplename <- samplename[order(samplename[,1]),] 

# Creating a key with shortened names that migrate-n can deal with
key <- matrix(NA,nrow=notaxa,ncol=3)

key[1:notaxa,1] <- samplename[1:notaxa,1]
key[1:notaxa,2] <- samplename[1:notaxa,2]

k <- 1

for (i in 1:(notaxa)) {
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

#Printing out the key so that you can match up your original sample names to the new ones used in the migrate file
write.table(key, "key.txt",quote=FALSE, col.names=FALSE,row.names=FALSE)

# Getting some information on the number of populations and loci in our file
popnames <- unique(key[,1])
numpops <- length(popnames)

numloci <- dim(temp)[2] - 1

firstline <- paste(numpops,numloci,"name",sep=" ")
secondline <- NULL

#Making a separate matrix for each population, because the migrate-n files have each population sequentially in the file
for (i in 1:numpops) {
assign(paste("recmatrix",i,sep=""),matrix(""))
}

for (i in 1:numpops) {
assign(paste("locusmatrix",i,sep=""),matrix(""))
}

for (k in 1:numpops) {
assign(paste("tempmatrix",k,sep=""),matrix(NA))
}

#Converting our structure file back to DNA codes
temp[temp == 1] <- "A"
temp[temp == 2] <- "C"
temp[temp == 3] <- "G"
temp[temp == 4] <- "T"

for (i in 2:numloci) {

misstemp <- cbind(temp[,1],temp[,i])
misstemp <- misstemp[(misstemp[,2]!=0),]
secondline <- paste(secondline,1," ",sep="")
misstemplen <- dim(misstemp)[1]

# Turning the per locus information into per population information
for (j in 1:misstemplen) {
for (k in 1:notaxa) {
if ((length(grep(key[k,2],misstemp[j,1])))>0) {
toadd <- paste(key[k,3]," ",misstemp[j,2],sep="")
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
#Writing out the number of samples for each matrix into nosamples. Tempmatrix holds the locus information. The N-1 is needed because of the NA at the top of this matrix
nosamples <- dim(get(paste("tempmatrix",m,sep="")))[1] - 1
# Locusmatrix holds the number of samples for each locus for each population
assign(paste("locusmatrix",m,sep=""),paste(get(paste("locusmatrix",m,sep="")),nosamples," ",sep=""))
#Resetting tempmatrix for next loop through
assign(paste("tempmatrix",m,sep=""),matrix(NA))
}
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
