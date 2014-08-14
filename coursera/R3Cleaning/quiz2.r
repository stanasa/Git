#twitter
library(httr)
library(jsonlite)
library(httpuv)
library(sqldf)
library(XML)

#github Q1

oauth_endpoints("github")

myapp = oauth_app("github",
                  key="ca0c440f91bcb1685d89",
                  secret="665f05b7c8213b8ae9c7be4d901f551df1992e81")
github_token = oauth2.0_token(oauth_endpoints("github"), myapp)
gtoken <- config(token = github_token)

req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
json1 <- content(req)
json2 = jsonlite::fromJSON(toJSON(json1))
json2[json2$name=="datasharing","created_at"]

##Q2, Q3

acs <- read.csv(file="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv ")
acs.sub <- sqldf("select pwgtp1 from acs where AGEP < 50")
dim(acs.sub)
str(acs.sub)
age <- (sqldf("select distinct AGEP from acs"))
age$AGEP[order(age$AGEP)]


##Q4
fileURL <- "http://biostat.jhsph.edu/~jleek/contact.html"
html <- readLines(fileURL)
nchar(html[10])
nchar(html[20])
nchar(html[30])
nchar(html[100])
cat(html[100])

#install.packages("data.table")
library(data.table)

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(fileURL, destfile = "./Data/data.for", method = "curl")

library(stringr)

html <- readLines(fileURL)
head(html)
?strstr
html[5]
value <- as.numeric(substr(html, 29, 32 ))
sum(value, na.rm=T)

html <- gsub("          ","\t",html)
html <- gsub("     ","\t",html)
html <- gsub(" ","",html)
html <- html[-c(1:3)]
writeLines(html, con=file("Data/data.for","w"))
?writeLines

table3 <- read.delim(html, sep="\t")


table2 <- read.delim("./Data/data2.for", header=T,sep="~")
head(table2)
head(table3)
str(table2)
