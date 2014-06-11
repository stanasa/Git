library(rJava)  #must have JAVA SDK installed first! 
library(xlsx)

Read.Xlsx <- function(filename, dir=getwd(), index=c(1), sheet=NULL)
{
wd0 <-  getwd()
setwd(dir)
aaa <- read.xlsx(file=filename,sheetIndex=index, sheetName=sheet)
setwd(wd0)
return(aaa)
}