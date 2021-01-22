# Title: POSC 3410 Lab 1 ####
# Author: George R. DeCarvalho
# Date : 20 Jan 2021

# Lesson 1 ####

# Lesson 2 ####

# Load tidyverse package  
library(tidyverse)

# Load data  
data(mpg)

# Check the structure of mpg using str()
str(mpg)

# Answer below (using a comment) what type of data structure mpg is?
# Vector

# Create analysis data frame: We do this so we preserve a raw version of the dataframe to which we can refer as we make
mpg_df<-mpg

# Check the structure of mpg_df using str()
str(mpg_df)

# Scatter plot of displ x hwy
ggplot(mpg_df, aes(x=displ , y=hwy ))+
  geom_point()

# Scatter plot of displ x hwy by fuel type (fl)
ggplot(mpg_df, aes(x=displ , y=hwy, color=fl ) )+
  geom_point()

# On Your Own, Scatter plot of displ x hwy by class
ggplot(mpg_df, aes(x=displ , y=hwy, color=class ) )+
  geom_point()


# Lesson 3 ####

# Call help for filter
?filter()

# Call help for geom_bar()
?geom_bar()

# Call help for facet_wrap()
?facet_wrap()

# ggplot - data layer, assign it to mpg_data
mpg_data<-ggplot(data= mpg)

# Call mpg_data
mpg_data

# Describe the output you see in the console.
# I only see the command I entered, the input is not describing mpg_data 

# Now, let's add an aesthetic layer to the plot.

# Put engine size on the x-axis, highway mileage on y-axis, and color by class. 
mpg_plot<-mpg_data +
  geom_point(mapping = aes(x=displ , y=hwy, color=class))

# What do you see?
# I did not see a change from the plot I had up

# Now, let's add an aesthetic layer to change the axis labels
mpg_axis <- mpg_plot +
  xlab("Engine Size in Liters")+
  ylab("Highway Mileage")+
  ggtitle("Engine Size and Mileage by Vehicle Class")

# Call mpg_axis
mpg_axis

# What do you see?
# Basically the same screen that came up when I used the call command before in the bottom right panel
# It says 'Parentheses and Braces..."

# Create different graphs for each class
mpg_wrap<-mpg_axis + 
  facet_wrap(~class, nrow=2)

# Call mpg_wrap
mpg_wrap

# What do you see?
# The same thing I have seen every time I use this function (will insert a scree capture now)

# Re-assign mpg_wrap by adding facet wrapping, change nrow to 3.
#I am now considerably lost
mpg_wrap<- facet_wrap(~class, nrow=3)

git config --global user.email "gdecarv@clemson.edu"
git config --global user.name "George DeCarvalho"