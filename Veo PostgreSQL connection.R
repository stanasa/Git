

required.packages = c("RPostgreSQL","data.table","")

if(a=("RPostgreSQL" %in% installed.packages())) install.packages("RPostgreSQL")
library(RPostgreSQL)
library(data.table)

#Initiate Driver object and the create and open database connection:
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, dbname="Veo", user="postgres", password="password")

#Check that the connection is established
dbGetInfo(drv)
summary(con)

#Aquire a list of constituent tables
Tables <- dbListTables(con)

##########################################

#Get the user profile information
system.time(user.profile <- as.data.table(dbGetQuery(con, "select * from users_profile")))
dbGetQuery(con, "select count(*) from facebook_facebooklike")
dbGetQuery(con, "select count(*) from users_profile_facebook_likes")
dbGetQuery(con, "select count(*) from marketing_trialcampaign_confirmed_users")
dbGetQuery(con, "select count(*) from users_profile_demo_question_answers")
 

is(con, "dbObjectId")

str(user.profile)

head(user.profile)
Mayactives <- user.profile[last_active>as.POSIXct("2014-03-01 00:00:00")&!(first_name!="")8,]
dim(Mayactives)
head(Mayactives, 40)

POSIXct

now()
a <- as.POSIXlt('2014-01-07 12:01:02')
b <- as.POSIXlt("2013-01-07 12:01:02")
c <- as.POSIXlt("2014-07-01 12:01:02")
a > b
a > c
max(a,b,c)

names(a)
str(a)
a

install.packages("rjson")
library(rjson)
library(RCurl)

Json.Iphone.addr<- "http://api.flurry.com/rawData/Sessions?apiAccessCode=RNYQNQKZ5X5TFG3N679M&apiKey=WVXB43YF3WMKW3HKKBY3&startDate=2014-06-10&endDate=2014-06-11"
Json.Iphone.waiting.data <- fromJSON(paste(readLines(Json.Iphone.addr), collapse=""))
Json.stor.Iphone.addr <- Json.Iphone.waiting.data$report$`@reportUri`
con <- gzcon(url(paste(Json.stor.Iphone.addr, sep="")))
Json.Iphone.data <- fromJSON(paste(readLines(con), collapse=""))
#str(Json.Iphone.data)
names(Json.Iphone.data)
names(Json.Iphone.data$meta)
names(Json.Iphone.data$query)
(Json.Iphone.data$sessionEvents)




5RFZHF5MQS2VQQHD5CPF

parser <- newJSONParser()
parser$addData(paste(readLines(con), collapse=""))
