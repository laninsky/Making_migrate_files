temp1 <- as.matrix(read.table("temp",header=FALSE,stringsAsFactors=FALSE,sep="\t"))
rows <- dim(temp1)[1]

sedcommands <- NULL
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

for (i in 1:dim(rename)[1]) {
sedcommandstemp <- paste("sed -i 's/",rename[i,1],"/",rename[i,2],"/' $f;",sep="")
sedcommands <- rbind(sedcommands,sedcommandstemp)
}


script1 <- as.matrix(sedcommands)
script1 <- rbind("for f in `ls *.fa`; do",script1,"done")

temp1 <- rbind(c("old_name","new_name"),temp1)

write.table(script1,"rename.sh",quote=FALSE, row.names=FALSE,col.names=FALSE)
write.table(temp1,"locikey",quote=FALSE, row.names=FALSE,col.names=FALSE)

q()
