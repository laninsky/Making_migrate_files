temp1 <- as.matrix(read.table("temp",header=FALSE,stringsAsFactors=FALSE,sep="\t"))
rows <- dim(temp1)[1]

numname <- 1

temp1 <- cbind(temp1,"")

for (i in 1:rows) {
if (nchar(temp1[i,1])>15) {
temp1[i,2] <- paste(">",numname,sep="")
numname <- numname + 1
} else {
temp1[i,2] <- temp1[i,1]
}
}

rename <- temp1[which(temp1[,1]!=temp1[,2]),]

listfiles <- list.files(pattern=".fa")

for (i in 1:length(listfiles)) {
temp <- as.matrix(read.table(listfiles[i],header=FALSE,stringsAsFactors=FALSE,sep="\t"))
for (j in 1:dim(rename)[1]) {
temp[which(temp[,1]==rename[j,1]),] <- rename[j,2]
}
write.table(temp,listfiles[i],quote=FALSE, row.names=FALSE,col.names=FALSE)
}

temp1 <- rbind(c("old_name","new_name"),temp1)
write.table(temp1,"locikey",quote=FALSE, row.names=FALSE,col.names=FALSE)

q()
