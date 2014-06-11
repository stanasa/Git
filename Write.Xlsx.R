library(rJava)  #must have JAVA SDK installed first! 
library(xlsx)

Write.Xlsx <- function(df, filename, sheet="Sheet1", dir=getwd(), col.names=T, row.names=T, append=F)
{
  wd0 <-  getwd()
  setwd(dir)
  write.xlsx(x=df, file=filename, sheetName=sheet, col.names=col.names, row.names=row.names, append=append)
  setwd(wd0)
}