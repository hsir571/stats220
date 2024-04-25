library(tidyverse)
library(magick)
library(jsonlite)
json_data <- fromJSON("pixabay_data.json")
pixabay_photo_data <- json_data$hits


selected_photos <- pixabay_photo_data %>% 
  separate_rows(tags, sep = ", ") %>%
  filter(tags == 'rodent' & views > 10000 & downloads > 15000)%>%
  mutate(popular = ifelse(views > 100000, 'very popular', 'not that popular'))%>%
  mutate(viewsvsdownloads = (downloads / views)) %>%
  mutate(viewsvscomments = comments / views)
write_csv(selected_photos, "selected_photos.csv")

mean_likes <- selected_photos$likes %>% mean(na.rm = TRUE)
mean_views <- selected_photos$views %>% mean(na.rm = TRUE)
mean_comments <- selected_photos$comments %>% mean(na.rm = TRUE)

selected_photos %>%
  group_by(popular) %>%
  summarise(mean_likes = mean(likes))

selected_photos %>%
  group_by(popular) %>%
  summarise(mean_views = mean(views))

selected_photos %>%
  group_by(popular) %>%
  summarise(mean_comments = mean(comments))

plot <- ggplot(selected_photos, aes(x = views, y = downloads)) +
  geom_point(color = "blue", alpha = 0.5) +
  labs(title = "Views vs. Downloads for Selected Photos",
       x = "Views", y = "Downloads") 
  print(plot)
  
  
  # Initialize an empty list to store resized images
  images <- list()
  
  # Loop through each URL in selected_photos$previewURL
  for (url in selected_photos$previewURL) {
    # Read and resize each image
    img <- image_read(url)
    img_resized <- image_resize(img, "300x300")
    # Add the resized image to the list
    images <- c(images, list(img_resized))
  }
  
  # Combine images into an animated GIF
  animated_gif <- image_animate(image_join(images), fps = 5)
  
  # Save the animated GIF
  image_write(animated_gif, "my_photos.gif")
  