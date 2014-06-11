#install.packages("RPostgreSQL")
library(RPostgreSQL)

drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, dbname="Veo", user="postgres", password="password")

?dbConnect
dbListTables(con)

dbGetQuery(con, "select count(*) from users_profile")
dbGetQuery(con, "select count(*) from facebook_facebooklike")
dbGetQuery(con, "select count(*) from users_profile_facebook_likes")
dbGetQuery(con, "select count(*) from marketing_trialcampaign_confirmed_users")
dbGetQuery(con, "select count(*) from users_profile_demo_question_answers")



