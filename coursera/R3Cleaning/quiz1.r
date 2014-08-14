library(xlsx)
library(XML)

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
x <- read.csv(file=fileURL)
dim(x)
table(x$VAL)
y <- x[x$VAL==24,]
head(y)

library(xlsx)
if(!file.exists("Data")) {dir.create("Data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileURL, destfile = "./Data/Nagaz.xlsx", method = "curl")
dat <- read.xlsx("./Data/Nagaz.xlsx", sheetIndex=1, header=T, 
                     rowIndex=18:23, colIndex=7:15)
sum(dat$Zip*dat$Ext,na.rm=T) 

fileURL <-"http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(fileURL,useInternal=TRUE, )
rootNode <- xmlRoot(doc)
xmlName(rootNode)
rowNodes <- rootNode[[1]]
names(rowNodes)
rowNodes[[1]]

nodes <- xpathSApply(doc, "//zipcode",xmlValue)# Node with attribute name attr-name='bob'
sum(nodes==21231)

