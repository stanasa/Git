p <- ggplot(mtcars, aes(factor(cyl), mpg))
## with only a point
p + geom_tufteboxplot()
## with a middle box
p + geom_tufteboxplot(usebox=TRUE, fatten=1)


(ggplot(mtcars, aes(wt, mpg))
+ geom_point() + geom_rangeframe()
+ theme_tufte())


(ggplot(mtcars, aes(x = wt + runif(1), y = mpg))
+ geom_point()
+ geom_rangeframe()
+ theme_tufte()
+ scale_x_tufte()
+ scale_y_tufte()
)

#install.packages("extrafont")
library(extrafont)

(ggplot(mtcars, aes(wt, mpg))
+ geom_point() + geom_rangeframe()
+ theme_tufte(base_size= 16, base_family="BemboStd"))
## Using the Gill Sans sans serif family
(ggplot(mtcars, aes(wt, mpg)) + geom_point() +
     geom_rangeframe() + theme_tufte(base_size= 14, base_family="GillSans"))

library(gcookbook)
library(RColorBrewer)
display.brewer.all()

p <- ggplot(uspopage, aes(x=Year, y=Thousands, fill=AgeGroup)) +
    geom_area()
p
#ugh
#Let's use color brewer:
p + scale_fill_brewer()
p + scale_fill_brewer(palette="Oranges") + theme_tufte(base_size=14)
?scale_fill_brewer

dsamp <- diamonds[sample(nrow(diamonds), 1000), ]
(d <- qplot(carat, price, data = dsamp, colour = clarity))
d + scale_colour_brewer()
d + scale_colour_brewer("clarity")
d + scale_colour_brewer(expression(clarity[beta]))

d + scale_colour_brewer(type = "seq")
d + scale_colour_brewer(type = "seq", palette = 3)

d + scale_colour_brewer(palette = "Blues")
d + scale_colour_brewer(palette = "Set1")

# scale_fill_brewer works just the same as
# scale_colour_brewer but for fill colours
ggplot(diamonds, aes(x = price, fill = cut)) +
  geom_histogram(position = "dodge", binwidth = 1000) +
  scale_fill_brewer()

library(reshape2) # for melt
volcano3d <- melt(volcano)
names(volcano3d) <- c("x", "y", "z")

# Basic plot
v <- ggplot() + geom_tile(aes(x = x, y = y, fill = z), data = volcano3d)
v
v + scale_fill_distiller()
v + scale_fill_distiller(palette = 2)
v + scale_fill_distiller(type = "div")
v + scale_fill_distiller(palette = "Spectral")
v + scale_fill_distiller(palette = "Spectral", trans = "reverse")
#v + scale_fill_distiller(type = "qual")
# Not appropriate for continuous data, issues a warning




