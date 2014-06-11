wd <- "C:\\Users\\Serban\\Downloads"
library(data.table)
log <- fread("grep 'Thu, 17 Apr 14' error_log.txt", sep="|", header=FALSE)
write.csv(log, "log.csv")

 
# library(stringr)
# readLines("error_log.txt", n=30)
# list <- system("grep -n 'Thu, 17 Apr 14' error_log.txt", intern=T)
# startline <- as.numeric(substr(list[1],1,str_locate(list[1],":")-1))
# log <- fread("error_log.txt", sep="|", header=FALSE, skip=startline-1)

##Added information