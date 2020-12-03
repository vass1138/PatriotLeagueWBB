rm(list=ls())

setwd("D:/Users/Emanuel/DataAnalysis/AUWBB")
getwd()

library(tidyverse)

# read in xlsx data
dt <- readxl::read_excel("au_vs_navy_200307.xlsx")

# change from 4 observations per row (quarters) to single observation per row
gf <- gather(dt,key=Quarter,value=Count,-Name)
gf

# sort names by total
gf %>% group_by(Name)


# remove "total" values
gq <- gf %>% filter(Quarter != "Total")

# plot names vs count
p <- ggplot(gq, aes(x = reorder(Name, Count), y = Count))+
  geom_col(aes(fill = Quarter), width = 0.7)+
  scale_fill_brewer("Quarter")+
  stat_summary(fun.y = sum,aes(label=..y..,group=Name),geom="text",hjust=-0.2)+
  ylim(0,70)+
  labs(title="American University vs Navy Commentary Review",
       subtitle="Patriot League, Women's Basketball\nBender Arena, March 7th, 2020",
       x="Player",
       y="Mentions",
       caption = "Commentators: Dan Laing, Jody Lavin-Patrick, Penny Kmitt")+
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        plot.caption = element_text(hjust = 0.5))

# horizontal bar plot
p + coord_flip()

