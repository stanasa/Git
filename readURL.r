#install.packages("xlsx")
#install.packages("XLConnect")
#install.packages("XML")
#install.packages("httr")
#install.packages("jsonlite")
library(xlsx)
library(XML)
library(jsonlite)

if(!file.exists("Data")) {dir.create("Data")}

#Excel!
fileURL <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
download.file(fileURL, destfile = "./Data/cameras.xlsx", method = "curl")
list.files("./Data")
dateDownloaded <- date()

x <- read.table("./Data/cameras.csv", sep=",", header=T)
head(x)
dim(x)

fileURL <- "http://t2.gstatic.com/images?q=tbn:ANd9GcTTWtiE1dbM2Y0loygqHQKIvNpJWwTS7GJ8mFxfjPFoGHMuJsz-"
download.file(fileURL, destfile = "./Data/flower2.jpeg", method = "curl") #pretty
download.file(fileURL, destfile = "./Data/flower2.jpeg")  #mangled
download.file(fileURL, destfile = "./Data/flower2.jpeg", mode="wb")  #pretty


cameraData <- read.xlsx("./Data/cameras.xlsx", sheetIndex=1, header=T)
head(cameraData)
cameraData[1, "Location.1"]

#XML!
## Markup  - labels and metadata
## Content - actual content

fileURL <-"http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(fileURL,useInternal=TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
names(rootNode)
rootNode[[1]]
names(rootNode[[1]])
rootNode[[1]][["price"]]
objects <- xmlSApply(rootNode, xmlValue)

xpathSApply(rootNode, "//name", xmlValue)
xpathSApply(rootNode, "//price", xmlValue)

# 
# /node
# //node
# node[]
#node[@attr-name] Node with an attribute name
#node[@attr-name='bob'] Node with attribute name attr-name='bob'

fileUrl <- "http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens"
doc <- htmlTreeParse(fileUrl,useInternal=TRUE)
scores <- xpathSApply(doc,"//li[@class='Score']",xmlValue)
teams <- xpathSApply(doc,"//li[@class='team-name']",xmlValue)
scores
teams


#JSON !!!
#Javascript object notation!
# nr, str, bool, array, obj


jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
names(jsonData$owner)
(jsonData$owner$login)
