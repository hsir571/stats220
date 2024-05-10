library(tidyverse)



youtube_data <- read.csv('https://docs.google.com/spreadsheets/d/e/2PACX-1vQKPXO2ualEZnThidWU7Lvz8xE2xHjO_fsc45OpvO5w0bFEn3paR-h6LsJ2IQnYdwaRvpd5Lfltiqm0/pub?gid=0&single=true&output=csv')


iwd <- youtube_data %>%
  filter(channelName == ('@IWDominatelol'))

mid <- youtube_data %>%
  filter(channelName == ('@midbeast9495'))

faker_data <- youtube_data %>%
  mutate(Faker = ifelse(str_detect(tolower(title), 'faker'),'Is in the Title', 'Is not in the Title'))
  
  
faker_data %>% 
  ggplot() +
  geom_bar(aes(x = title, y = viewCount, fill = Faker), stat = "identity") +
  labs(title = "View Count for Videos with 'Faker' in Title", x = "Videos", y = "View Count") +
theme(axis.text.x = element_blank(), axis.ticks.x = element_blank())

mean_comments <- youtube_data$commentCount %>%
  mean() 
  
youtube_data %>%
  ggplot() +
  geom_point(aes(y = commentCount, x = videoId), colour = "red") +
  labs(title = "Number of comments per video", x = "Videos", y = "Comment Count") +
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
  
  geom_hline(yintercept = mean_comments, size = 1, colour = "blue") +
  annotate("text", x = Inf, y = 0, label = "Average Number of Comments", hjust = 1, vjust = 1, color = "blue")




new_data <- youtube_data %>%
  mutate

