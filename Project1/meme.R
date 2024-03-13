library(magick)

#make a vector with a string 
text <- c("SALAD")

#read image in 
new_meme <- image_read('https://i.imgflip.com/51x3pf.jpg?a474384') %>%
  image_annotate( 
    text, size = 100, location = "+700+200") %>%  #add text to the image 
  image_annotate( 
    "PROTEIN", size = 100, location = "+700+700") 
  

frame1 <- new_meme %>%
  image_scale(200) %>%
  image_blur(10,5) %>%
  image_extent("500x500")

frame2 <- new_meme %>%
  image_scale(300) %>%
  image_noise() %>%
  image_extent("500x500") 

frame3 <- new_meme %>%
  image_scale(400) %>%
  image_charcoal() %>%
  image_extent("500x500")

frame4 <- new_meme %>%
  image_noise() %>%
  image_scale(500)

# putting the frames in order using a vector
frames <- c(frame1, frame2, frame3, frame4)

# creating an animation
my_gif <- image_animate(frames, fps = 1)




image_write(new_meme, path = "my_meme.jpeg", format = "jpeg")  #save image to disk 
image_write(my_gif,"my_gif.gif")
print(new_meme)



