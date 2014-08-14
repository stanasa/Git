Dullboy<-data.frame(Treatment=c(rep("AllWork",9), rep("AndNoPlay",9),rep("MakesJack", 14)),
                  Result=c(rep("Redrum",3),rep("Caretaker",4),rep("LikeWendy",6),rep("Redrum",7),
                         rep("Caretaker",3),rep("LikeWendy",5),rep("Caretaker",4)))
p <- ggplot(Dullboy, aes(factor(Treatment), fill=Result))
p + geom_bar() + stat_bin(aes(label=paste("n = ",..count..)), vjust=1, geom="text")