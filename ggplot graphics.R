library(ggplot2)
str(msleep)

sleepplot = ggplot(data = msleep, aes(x = log(bodywt), y = sleep_total)) + geom_point(aes(color = vore))
sleepplot
slp = lm(sleep_total ~ log(bodywt), data = msleep)
summary(slp)
## 
sleepplot = sleepplot + geom_abline(intercept = coef(slp)[1], slope = coef(slp)[2])
sleepplot

# Axes
sleepplot = sleepplot + labs(x = "Log body weight (Kg)", y = "Time asleep (hrs/day)")
sleepplot

#Labels
sleepplot + scale_color_discrete(name = "Functional\n feeding group", labels = c("carnivore", 
    "herbivore", "insectivore", "omnivore"))

#

## Figures
sleepplot2 = ggplot(data = msleep, aes(x = log(bodywt), y = sleep_total)) + 
  geom_point(aes(shape=vore), size=3) + #' This time we will vary the feeding groups by shapes instead of colors
  geom_abline(intercept=coef(slp)[1], slope=coef(slp)[2]) +
  scale_shape_discrete(name = "Functional\n feeding group", labels = c("carnivore", 
    "herbivore", "insectivore", "omnivore"))    +
   labs(x = "Log body weight (Kg)", y = "Time asleep (hrs/day)")    
  sleepplot2

#Theme
sleepplot2 + theme_bw(base_size = 12, base_family = "Helvetica")

#install.packages("ggthemes")
library(ggthemes)

sleepplot2 + theme_bw() + theme(text = element_text(size=18))
sleepplot2 + theme_minimal()
sleepplot2 + theme_classic()
sleepplot2 + theme_calc()
sleepplot2 + theme_economist()
sleepplot2 + theme_excel()
sleepplot2 + theme_few()
sleepplot2 + theme_foundation()
sleepplot2 + theme_gdocs()
sleepplot2 + theme_igray()
sleepplot2 + theme_solarized()
sleepplot2 + theme_stata()
sleepplot2 + theme_tufte() + theme(text = element_text(size=14))
sleepplot2 + theme_wsj()

sleepplot2  + theme_tufte() + 
  #increase size of gridlines
  theme(panel.grid.major = element_line(size = .5, color = "grey"),
  #increase size of axis lines
  axis.line = element_line(size=.7, color = "black"),
  #Adjust legend position to maximize space, use a vector of proportion
  #across the plot and up the plot where you want the legend. 
  #You can also use "left", "right", "top", "bottom", for legends on t
  #he side of the plot
  legend.position = c(.85,.7),
  #increase the font size
  text = element_text(size=14))

science_theme = theme(panel.grid.major = element_line(size = 0.5, color = "gray"), 
    axis.line = element_line(size = 0.7, color = "black"), legend.position = c(0.85, 
        0.7), text = element_text(size = 14))
sleepplot2 = sleepplot2 + science_theme
sleepplot2


###########
sleepcat = ggplot(msleep, aes(x = vore, y = sleep_total, color = conservation))
sleepcat + geom_point()
##Add jitter
sleepcat + geom_point(position = position_jitter(w = 0.1))


sleepmean + geom_point(position = position_dodge(width = 0.5, height = 0), size = 2) + 
    geom_errorbar(aes(ymax = meansleep + sdsleep, ymin = meansleep - sdsleep), 
        position = position_dodge(width = 0.5, height = 0), width = 0.5)
## ymax not defined: adjusting position using y instead



##Annotate
sleepplot2 + annotate("text", label = "R2 = 0.999", x = -4, y = 17)
sleepplot2 + annotate("text", label = "R2 = 0.999", x = -4, y = 17, fontface = 3)
