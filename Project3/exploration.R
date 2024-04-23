library(tidyverse)
library(jsonlite)
json_data <- fromJSON("pixabay_data.json")
pixabay_photo_data <- json_data$hits


selected_photos <- pixabay_photo_data %>% 
  separate_rows(tags, sep = ", ") %>%
  sel
