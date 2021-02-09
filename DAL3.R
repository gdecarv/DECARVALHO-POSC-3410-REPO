# TItle: DAL3 ####

# Author: George R. DeCarvalho

# Date: 27 Jan 2021

# Lesson 1 ####

# Load Tidyverse
library("tidyverse")

# Practice on your own ####
read_csv("gtd_raw.csv")

# Assign to gtd_raw
gtd_raw<- read_csv("gtd_raw.csv")

# Remove gtd_raw before using second method
rm(gtd_raw)

# Imported gtd_raw using second method

# Load tidyverse - Beginning of DAL Activity ####
library("tidyverse")

# Import the 'gtd_raw.csv' file as assign it to 'gtd_raw' ####
read_csv("gtd_raw.csv")
gtd_raw<- read_csv("gtd_raw.csv")

# Create Analysis data frame by assinging gtd_raw to gtd_df 
gtd_df <- gtd_raw

# View gtd_df in a new window
View(gtd_df)

# Check structure of gtd_df
str(gtd_df)

# Select the columns we will need to make our visualizations - List these in the prompt. 
gtd_df <- gtd_df %>% 
  select(eventid, iyear, imonth, iday, summary, country, country_txt, region, region_txt, provstate, city, crit1, crit2, crit3, doubtterr, success, suicide, attacktype1, attacktype1_txt, attacktype2, attacktype2_txt, attacktype3, attacktype3_txt, targtype1, targsubtype1_txt, targtype2, targtype2_txt, targtype3, targtype3_txt, gname, gname2, gname3, nperps, nperpcap, motive, nkill, nkillus, nkillter, nwound, nwoundus, nwoundte, property, propextent, propextent_txt, propvalue, nhostkid, nhostkidus, nhours, ndays, ransom, ransomamt, ransompaid, hostkidoutcome, hostkidoutcome_txt, nreleased)

# Check Structure
str(gtd_df)

# QuestionA: What do the rows (be careful and specific) and columns represent in this data set? Code a text string describing what you see to `Answer1` ####
AnswerA <- "Rows are incidents, columns represent characteristics of incidents or variables."

# QuestionB: What years does the data set span? Code the first year and last year in the numeric string ####
#HINT: Call summary(gtd_df$iyear)

# Get first and last year
summary(gtd_df$iyear)

AnswerB <- c(1970,2018)

# Create Visualization of Number of Terrorist Attacks per Year - Fill in the blanks on the Bar Chart #### 
gtd_df %>% 
  filter(crit1 == 1 & crit2 == 1 & crit3 == 1) %>% 
  group_by(iyear) %>% 
  count() %>% 
  rename(`Number of Attacks` = n, Year = iyear) %>% 
  ggplot(aes(x= Year, y=`Number of Attacks`))+ # Be sure to add the correct x and y variables. 
  geom_bar(stat="identity")

# Question 1: What trends do we see? Does anything look peculiar? Code a text string describing what you see to `Answer1`####
Answer1 <- "We do not see a constant increase, even though the line of best fit would show one. There is a bump around 1990 and then a dip in the early 2000's with a sharp increase after. At the very end (2015-), the values drop sharply"

# Use a table to identify how many terrorist attacks there were per year 
gtd_df %>% 
  filter(crit1 == 1 & crit2 == 1 & crit3 == 1) %>%
  group_by(iyear) %>%
  count() %>%
  View()

# Question 2: What year shows no terrorist attacks? Why are we missing it. (HINT: refer to the GTD Code Book). Code your answer as a text string called 'Answer2'.  ####
Answer2 <- "All years show attacks because we have filtered the data to equal !, which excludes years without attacks"

# Question 3: In how many incidents is there doubt as to whether the incident is terrorism? Code answer as numeric vector.####
# View the code book to find which variable tells us if there is doubt whether the indicident is terorism. We will need to group and count. 

# Code goes here
gtd_df %>%
  group_by(doubtterr) %>%
  count()
# Write your answer.
Answer3<-c(31060) # This is because it = 1. which indicates the variable is present, correct?

# Question 4: What percent of the total number of incidents in the data frame is there doubt about whether it is terrorism. Show both code and assign answer to a numeric vector? ####
3160/(13785+146619) # = 0.0.01970026
0.01970026*(100) # = 1.970026 %
Answer4<-c(1.970026)

# Question 5:  What were the top 3 years in terms of number of terrorist attacks.Show both code and answer. Assign a numeric vector to Answer5. ####

gtd_df %>% 
  filter(doubtterr==0)%>% # A filter command goes here.
  group_by(iyear)%>%
  count()%>% 
  arrange()

# Answer is 1970 with 489, 1971 with 324, and 1972 with 387
Answer5<-c(1970,1971,1972)

# Explore Relationship between Number of Incidents and Number of Casualties, Types of Casualties #### 
# Code a dataframe with year, number of incidents, variables for casualties: `gtd_casualties_df`
gtd_casualties_df <- gtd_df %>% 
  filter(iyear >= 1970, crit1 == 1 & crit2 == 1 & crit3 == 1) %>% 
  group_by(iyear) %>%
  #Fill in the below blank with the correct tidyverse command.
  summarise(incidents = n(), casualities = (sum(nkill, na.rm = TRUE) + sum(nwound, na.rm = TRUE)), victims_killed = sum(nkill, na.rm = TRUE), victims_wounded = sum(nwound, na.rm = TRUE))


# Question 6: How many incidents, per year, did we exclude because they did not have casualty data? What percentage have we been missing per year? Answer this question by creating a dataframe with year, number of incidents missing data in nkill or nwound,  number of incidents, and calculate the percent per year that are missing. #####
missing_casualties_data <- gtd_df %>%
  filter(iyear >= 1970, crit1 == 1 & crit2 == 1 & crit3 == 1, (is.na(nkill)|(nwound))) %>%
  group_by(iyear) %>%
  count() %>%
  rename(missing = n)

missing_casualties_data

# Create a dataframe with year and count of missing data. HINT: You will have to add conditions to filter. 
missing_casualties_df <- gtd_df %>% 
  filter(iyear >= 1970, crit1 == 1 & crit2 == 1 & crit3 == 1 & (is.na(nwound) | is.na(nkill))) %>% 
  group_by(iyear) %>% 
  count() %>%
  rename(missing = n)

# Add total incidents per year to missing_casualties_data
missing_casualties_df <- left_join(missing_casualties_data, gtd_casualties_df, by = "iyear" ) 
# We will talk about joins next week. You get to see an early example.

missing_casualties_df <- missing_casualties_df %>% 
  select(iyear:incidents) %>% 
  mutate(perc_missing = incidents*100) # Fill in this blank with the correct formula.

Answer6 <- missing_casualties_df

# Create Example data frame
year <-c(seq(1990,2020,1))
rent <-c(rnorm(31,1062,400))
rent<-sort(rent)
year_rent_df <- tibble(year,rent)