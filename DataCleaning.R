# This is a few data clean codes learned from online sources by Irma Wang.

# load package
library(tidyverse)
library(ggplot2)
library(readr)
# This is to follow a livecoding video with Kaggle https://www.youtube.com/watch?v=2HzsTwHL7H0


df <- read_csv("multipleChoiceResponses.csv")
head(df)
### I have to use data import function on drop down menu from File to import.

# making the first row the clumn name, tidy up the data with janitor function
names(df) <- as.character(df[1,])
## Rachel's code: names(df) <- as.vector(df[1,])

df <- janitor::clean_names(df) %>%
  slice(2:n())
View(df)
# It took me a while to test out the code, and I had different code than Rachel

# I want to prodict the job title, role and responsiblities, so age and gender are not included. Because I have lots (395) columns, I want to see what is relevant
names(df)
# drop all column with "other"
# I might approach this different, I may make a codebook for this survey, and change the names to each column
non_multi_choice <- c("what_is_the_highest_level_of_formal_education_that_you_have_attained_or_plan_to_attain_within_the_next_2_years",
"select_the_title_most_similar_to_your_current_role_or_most_recent_title_if_retired_selected_choice",
"in_what_industry_is_your_current_employer_contract_or_your_most_recent_employer_if_retired_selected_choice",
"how_many_years_of_experience_do_you_have_in_your_current_role",
"what_is_your_current_yearly_compensation_approximate_usd",
"does_your_current_employer_incorporate_machine_learning_methods_into_their_business",
"of_the_choices_that_you_selected_in_the_previous_question_which_ml_library_have_you_used_the_most_selected_choice",
"approximately_what_percent_of_your_time_at_work_or_school_is_spent_actively_coding")

df_non_multi_choice <- df %>% 
  select(non_multi_choice)
View(df_non_multi_choice)

multi_choice <- "select_any_activities.*|
  which_types_of_data_do_you.*|
select_any_activities.*|
what_is_the_primary_tool.*|
which_of_the_following_cloud_computing_services."

str_extract_all(names(df),multi_choice,simplify = TRUE)

df_multi_choice <- df %>% 
  select(contains(non_multi_choice)) %>% 
  -select(contains("other "))
View(df_non_multi_choice)
