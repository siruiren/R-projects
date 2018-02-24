library(readr)
library(ggplot2)
library(dplyr)

str(h1b_kaggle) # find the structure of the data

table(is.na(h1b_kaggle))  # count the number of missing values
# becuase there only 17942 missing values out of 270022122 total values, which is 0.006645%, I would like to omit those rows contain missing values 

h1b_df <- h1b_kaggle[complete.cases(h1b_kaggle),] 
str(h1b_df) # see the structure of the new data frame

# now we start to analyse after cleaning the data
# Firstly I would like to see the top 10 companies with most application recieved 
df_company<- h1b_df %>%
  group_by(EMPLOYER_NAME) %>%  #group by function to gather company together
  summarise(totalapp=n()) %>%  #summrize the number of companies
  arrange(desc(totalapp)) %>%  # get the descending order
  top_n(10,wt=totalapp)        # get the top 10 of the list

ggplot(data = df_company, aes(x = reorder(EMPLOYER_NAME, totalapp), 
                              y = totalapp, fill = EMPLOYER_NAME)) +
  geom_bar(stat = "identity") +
  labs(title= "Top 10 companies with most applications", x = "Employer name", y = "Applications")+
  coord_flip() 
# becuase the employer names are too long, I decided to do the verticle graph. which means I add coord_flip()

# then I would like to see the top 10 job positions with most petitions are made

df_position <- h1b_df %>%
  group_by(JOB_TITLE) %>%
  summarise(count=n()) %>%
  arrange(desc(count)) %>%
  top_n(10,wt=count)

ggplot(data=df_position,aes(x = reorder(JOB_TITLE, count),
                            y = count, fill = JOB_TITLE)) +
  geom_bar(stat = "identity") +
  labs(title= "Top 10 job positions", x = "Job Title", y = "Applications") + 
  coord_flip()

# The next step is to find the avarage salary

ggplot(data = subset(h1b_df, h1b_df$PREVAILING_WAGE < quantile(h1b_df$PREVAILING_WAGE, 0.99, na.rm = T)),
       aes(x = PREVAILING_WAGE/1000)) +
  geom_histogram(color = "black", fill = "green", binwidth = 2) +
  labs(title= "Average salary",x = "Average salary (in thousand USD)", y = "Applications")



# The next part I would like to explore data scientist becuase this is my major

ds_pattern <- "^DATA SCIENTIST*"   # the regex patterns means start with data and end with scientist
ds <- subset(h1b_df, grepl(data_job_pattern, toupper(h1b_df$JOB_TITLE)) == T)
ds_jobs <- as.data.frame(ds %>% group_by(YEAR) %>% 
                           summarise(median_salary = median(PREVAILING_WAGE), count = n()))

#I am interested in the data scientist salary
ggplot(data = subset(ds, ds$PREVAILING_WAGE < 
                       quantile(ds$PREVAILING_WAGE,0.999)),
       aes(PREVAILING_WAGE/1000)) + 
  geom_histogram(color = "black", fill = "blue", binwidth = 2) + 
  labs(x = "Salary (in thousand USD)", y = "Number of Data Scientist",
       title = "Data Scientist Salary")

#compare the data scientist and non-data scientist salary

non_ds_jobs <- subset(h1b_df, grepl(ds_pattern, toupper(h1b_df$JOB_TITLE)) == F)
non_ds_jobs <- as.data.frame(non_ds_jobs %>%
                               group_by(YEAR) %>% 
                               summarise(median_salary = median(PREVAILING_WAGE), count = n()))
summary(ds_jobs$median_salary)
summary(non_ds_jobs$median_salary)

#we can see that data scientist has a higher salary

#which company attract most data scientist?
ds$EMPLOYER_NAME <- factor(ds$EMPLOYER_NAME)
ds_company<- ds %>%
  group_by(EMPLOYER_NAME) %>%
  summarise(count=n()) %>%
  arrange(desc(count)) %>%
  top_n(10,wt=count)

ggplot(data = ds_company, aes(x = reorder(EMPLOYER_NAME, count), 
                              y = count, fill = EMPLOYER_NAME)) +
  geom_bar(stat = "identity") +
  labs(title= "Top 10 companies for data scientist", x = "Employer name", y = "Applications")+
  coord_flip() 

# where is the most popular workcite for data scientist
ds$WORKSITE <- factor(ds$WORKSITE)
ds_workcite <- ds %>%
  group_by(WORKSITE) %>%
  summarise(citecount=n()) %>%
  arrange(desc(citecount)) %>%
  top_n(10,wt=citecount)

ggplot(data = ds_workcite, aes(x = reorder(WORKSITE, citecount),
                               y = citecount, fill = WORKSITE)) +
  geom_bar(stat = "identity") +
  labs(title="Most popular worksite for data scientist",x = "WORKSITE", y = "Applications") + 
  coord_flip()
