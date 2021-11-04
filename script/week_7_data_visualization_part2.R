library(ggplot2)
library(tidyverse)
ggplot(diamonds, aes(x = clarity, fill = cut)) + 
  geom_bar()+
  theme(axis.text.x = element_text(angle = 70, vjust = 0.5)) +
  scale_fill_viridis_d(option = 'C') + 
  theme_classic()

colnames(diamonds)
diamonds_group = diamonds %>% 
  group_by(cut) %>% 
  summarize(avg_price = mean(price))

# Non-visual data interaction
# Publishing Plots: cowplot
#install.packages('cowplot')
library(cowplot)
plot.diamonds = barplot()
plot.cars
# Saving Figures and Plots
