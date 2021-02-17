# TItle: DAL4 ####

# Author: George R. DeCarvalho

# Date: 15 Feb 2021

# Part 1 ####

# Set Up####
# Libraries
library(tidyverse)

# Data 
# Load your Data and assign to gss_df ####
read_csv("gss_df.csv")
gss_df<- read_csv("gss_df.csv")

# Script ####

# Question A ####
# View the data and read the code book to answer the following question. What do the columns and rows represent. Assign you answer as a text vector the below object. 

#View(gss_df) in seperate window

AnswerA <- "Rows are respondents, Columns are questions they were asked"

# Question B ####
# What is the start and end year present in the data? Code as a NUMERIC vector and assign to AnswerB.  Plot how many observations per year there are. Assign your code to AnswerB_plot

#Run summary on gss_df($YEAR)
summary(gss_df$YEAR)

AnswerB <- c(1972, 2018)

AnswerB_plot <- gss_df %>%
  group_by(YEAR) %>%
  count() %>%
  rename(Obeservations = n, Year = YEAR) %>%
  ggplot(aes(x= Year, y= Obeservations)) +
  geom_bar(stat = "identity")

# Find missing observations in the count  
gss_df %>%
  group_by(YEAR) %>%
  count() %>%
  filter(is.na(YEAR))

# Print AnswerB_plot
AnswerB_plot

  # Question C ####
# Is every question asked each year? Use the code book or the GSS Data Explorer (link posted on Canvas) to answer this question. Code your answer as a LOGICAL vector and assign to AnswerC. 

AnswerC <- FALSE
  
# Question D ####
# What are the names of all the variables in the data frame? Assign your answer to col.names. 

col.names<- names(gss_df)
  
# Question 1 ####
# Our ultimate goal is to understand what causes people to support federal funding for science. Our starting point for this inquiry should be to explore the dataset by developing a baseline understanding of the respondents and the sample. The most basic disaggregator in our society is gender. Make a plot of how many men and women respondents there in the sample overall. 

# When you make a plot that graphs number of respondents by sex, what do you expect to see. What ratio do you expect to see between men and women? Write your answer as a text vector and assign to Answer1_expectation. 

# Create Answer1_expectation
Answer1_expectation <- "Bar graph of two variriables, with sex on X axis and number on the Y axis with approx. a 50/50 split"

# Create Answer1_plot
Answer1_plot<- gss_df %>% 
  group_by(SEX) %>% 
  count() %>% 
  rename(Number = n, Sex = SEX) %>% 
  ggplot(aes(x = Sex, y=Number)) +
  geom_bar(stat="identity")

# Call created plot
Answer1_plot

# Use a text vector to explain what is peculiar about the result that you see. 
Answer1 <- "The female bar is significantly higher than the male bar, indicating more females than the 50/50 split we expected"


# Question 2 ####
# Repeat the steps we used in Question 1 for SEX to explore RACE 

# Create Answer2 Expectation 

# Determine how many classes there are for the RACE variable
unique(gss_df$RACE)

Answer2_expectation <- "A bar graph with Race on X axis and the number on the Y axis. Three bars with White at the highest amount, then Black, Then Other"

# Create Answer2_plot
Answer2_plot<- gss_df %>% 
  group_by(RACE) %>% 
  count() %>% 
  rename(Number = n, Race = RACE) %>% 
  ggplot(aes(x = Race, y=Number)) +
  geom_bar(stat="identity")

# Call Answer2_plot
Answer2_plot

# Use a text vector to explain what is peculiar about the result that you see.
Peculiar <- "This is mostly what we expected to see, with a possible oversampling of White People"

# Question 3 ####
# When using GSS data, it is vital that we compare weighted percentages. In this question we will learn more about sampling weights. 

# View the structure of the WTSSALL variable. What is peculiar about the values of this variable. Describe your answer in a text vector and assign to Question3_part1. 

str(gss_df$WTSSALL)

Question3_part1 <- "The values are numerical and start at .445 going up, I am not sure what this could describe. Observations exist every other year from 1988 on"

# Find the description wtssall in the code book. What is this variable and why is it in the data? Describe your answer in a text vector and assign to Question3_part2.

Question3_part2 <- "WTSSALL is the weight variable, which I assume is used to even out the data from different years in % form so it can be compared"

# Important Takeaway #### 
# Our takeaway should be that we will need to compare the proportions. The GSS Team has surveyed a representative sample of Americans, which required oversampling some demographic groups to make sure there was enough data. The goal of this survey is NOT to take a Census of how many Americans in each demographic there are; rather, its goal is to understand the views and opinions Americans of each demographic group. 

# Therefore, analyzing data in the GSS will require us to find what percentage of a demographic group hold a certain opinion.

# Question 4 - Pointing out Ballot Difference ####
# Further, each respondent is also given a different ballot, which includes a different set of questions. You can read more about this in the Codebook or online. But we need to be aware that for each question in each year, we may have to filter to keep only the results for specific ballots. 

# How many different values are there for `BALLOT`?
Question4A <- unique(gss_df$BALLOT)
# 4, including the Not applicable and NA

# Let's say we want to understand which Ballots asked a specific question `ADVFRONT` (look up what it means in the codebook) in a specific year (2018), now let's use tidyverse to find this answer. 
gss_df %>% 
  filter(YEAR == 2018) %>% 
  group_by(BALLOT, ADVFRONT) %>% 
  count() %>% 
  View()

# Code a list of text vectors with the Ballots that asked this question. 
Question4B <- c("Ballot a", "Ballot b")

# As you can see, the GSS lends itself to cross-sectional study but makes time-series study difficult because we have to develop a data frame for each question and variable we want to study and then combine these data frames together. We will learn how to do this next week. 

# Question 4 ####
# Here IS how we want to compare data in the GSS within 1 year. We will use the 2018 data. 

# 1) How many respondents were male and female (fill in the blanks)
gss_df %>% 
  filter(YEAR == 2018 & (BALLOT == "Ballot a" | BALLOT == "Ballot b")) %>% 
  group_by(SEX) %>% 
  count() %>%
  view()   # 868 females and 691 Males


# 2A) Now create a dataframe of Male respondents who answered specific Ballots. 
Male_ab_df <-gss_df %>% 
  filter(YEAR == 2018 & SEX == "Male" & (BALLOT == "Ballot a" | BALLOT == "Ballot b"))


Male_ab_df

# 2B) Now create a dataframe of Female respondents who answered specific Ballots. 
Female_ab_df <-gss_df %>% 
  filter(YEAR == 2018 & SEX == "Female" & (BALLOT == "Ballot a" | BALLOT == "Ballot b"))

Female_ab_df

# 3A) Group_by SEX and ADVFRONT, summarize data to calculate proportion of men who responded each value
Male_ADVFRONT_df<- Male_ab_df %>%
  group_by(SEX, ADVFRONT) %>%
  summarize(prop = n() / 691 * 100)


# 3B) Group_by SEX and ADVFRONT, summarize data to calculate proportion of women who responded each value
Female_ADVFRONT_df <- Female_ab_df %>% 
  group_by(SEX, ADVFRONT) %>%
  summarize(prop = n()/ 868 * 100)

# 4) Combine these dataframes using the bind_rows function 
ADVFRONT_by_SEX_df <-bind_rows(Male_ADVFRONT_df, Female_ADVFRONT_df)

# 5A) Create ggplot bar graph  
ADVFRONT_by_SEX_df %>%
  ggplot(aes(x= SEX, y = prop, fill= ADVFRONT)) +
  geom_bar(stat="identity")

# 5B) Filter out "Not Applicable" & "No answer" and make a ggplot. 
ADVFRONT_by_SEX_df %>% 
  filter(ADVFRONT != "Not applicable" & ADVFRONT != "No answer") %>%ggplot(aes(x=SEX, y= prop, fill= ADVFRONT)) +
  geom_bar(stat="identity")

# 5C) What are some aspects of this visualization that are wonky? Describe in detail what you want to change about this graph in the future. Assigning your answer to Answer5C 
Answer5C <- "This is what I personally would expect to see"

# Copyright (c) Grant Allard, 2021


# Title: DAL4 Part 2
# Author: George R. DeCarvalho

# Purpose:
# We will learn how to work with the weights in the GSS survey to analyze questions using data visualizations. 

# Set Up####
# Libraries
library(tidyverse)

# Data
# Load data 
load('DALs/DAL4/data/gss_df.Rdata')

# Let's Look Only at the 2018 Data 
gss_2018_df <- gss_df %>% 
  filter(YEAR == 2018)

# Question 1 ####
# Let's look at the relationship between sex and approval of federal support for science. We are testing a theory that says sex causes people to form their opinion about whether the federal government should support science. 

# We have translated this theory into a set of hypotheses that we are testing. 

H0 <- "The percent of men and women who approve of federal support for science the same." 

Ha <- "The percent of men and women who approve of federal support for science is not the same." 

# First let's check the unique value of Advfront_df
unique(gss_2018_df$ADVFRONT)

# We need to filter out observations where the value of ADVFRONT is "Not applicable". We also need to summize the data by SEX and ADVFRONT. 
sex_Advfront_df <- gss_2018_df %>%
  filter("Fill in the blank") %>% 
  "Fill in the blank"(SEX, ADVFRONT) %>% 
  summarize(n = sum("Fill in the blank"))

# Calculate percent of men who feel a certain way
male_Advfront_df <- "Fill in the blank" %>% 
  "Fill in the blank"("Fill in the blank" == "Fill in the blank")

# Total Number of men 
male_Advfront_df %>% 
  group_by(SEX) %>% 
  "Fill in the blank"()

# Calculate men's responses as percentages. 
male_Advfront_df <- male_Advfront_df %>% 
  mutate("Fill in the blank" = "Fill in the blank"/"Fill in the blank" * 100) %>% 
  "Fill in the blank"(SEX, ADVFRONT,  Advfront_perc)

# Calculate percent of women who feel a certain way


# Total Number of men 


# Calculate women's responses as percentages. 

# Create unified data frame of men and women by using bind_rows. 
sex_Advfront_per_df <- bind_rows(female_Advfront_df, male_Advfront_df)

# Text vector for Reordering ADVFRONT when we code it as a vector
levels <- c("Strongly agree", "Agree", "Disagree", "Strongly disagree", "Dont know", "No answer")

# ggplot bar graph of sex_Advfront_per_df
sex_Advfront_per_df %>% 
  mutate(ADVFRONT = factor(ADVFRONT, levels=levels)) %>% 
  ggplot(aes(x= SEX, y=Advfront_perc, fill=ADVFRONT)) +
  geom_bar(stat="identity")


# Question 1: Which hypothesis does the visualization provide evidence against? Why?

Answer1 <- "" 

# Question 2 #### 
# Now we are going to test a second theory related to Sex. We are testing the theory that Sex causes differences in how people view space exploration. 

# Hypotheses
H0 <- "The percent of men and women who approve of federal support for science the same." 

Ha <- "The percent of men and women who approve of federal support for science is not the same." 

# We will use repeat the process from question 1. 
sex_Natspac_df <- "Fill in the blank"

# Calculate percent of men who feel a certain way


# Total Number of men 

# Calculate men's responses as percentages. 


# Calculate percent of women who feel a certain way


# Total Number of men 


# Calculate men's responses as percentages. 


# Combine into single df using bind_rows()
sex_Natspac_perc_df <- "Fill in the blank"

# Create text vector for reordering 
levels <- c("Too much", "About right", "Too little", "Don't know", "No answer")

# Create ggplot 
"Fill in the blank" %>% 
  "Fill in the blank"(NATSPAC = factor(NATSPAC, levels = levels)) %>% 
  "Fill in the blank"("Fill in the blank"("Fill in the blank"="Fill in the blank", "Fill in the blank"="Fill in the blank", "Fill in the blank"="Fill in the blank")) +
  "Fill in the blank"("Fill in the blank") +
  scale_fill_manual(breaks = levels, values = c("#FFCC00", "#33FF00", "#0033FF", "#999999", "#FFFFFF"))

# Question 2: Which hypothesis does this visualization provide evidence against? 
Answer2 <- ""

# Copyright (c) Grant Allard, 2021

