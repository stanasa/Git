#twitter
library(httr)
library(jsonlite)
library(httpuv)

myapp = oauth_app("twitter",
                  key="sbaJpClj5NLOMDTKeYW5FZPDa",
                  secret="zEU2qXA3H5VMtitK2J2fPv8D3lCBG2TCVdWIbpYFP6FENSreef")
sig = sign_oauth1.0(myapp,
                    token = "2548352311-LGhvqDI9UHQE2t4YskyoofapAwxAgZujM1u0I0U",
                    token_secret = "FLNTS9o2GxLODjGxUsu66qk2TLony4YIIw8ProFc12J1l")

homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)
json1 = content(homeTL)
json2 = jsonlite::fromJSON(toJSON(json1))
json2[1,1:4]

#github

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
