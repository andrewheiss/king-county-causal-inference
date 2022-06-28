library(tidycensus)
library(tidyverse)

age10 <- get_decennial(geography = "state", 
                       variables = "P013001", 
                       year = 2010)

head(age10)

# 
# dec_raw <- get_decennial(geography = "block", 
#                          variables = c(total_race = "P1_001N"),
#                          summary_var = "P001001",
#                          state = 53, year = 2020)
# 
# decennial_possible_vars <- load_variables(2020, "pl")

date1 <- ymd_hms("2009-03-08 01:59:59")
date2 <- ymd_hms("2000-02-29 12:00:00")
interval(date2, date1)

as.period(date2 - date1, unit = "days")

as.duration(interval(date2, date1)) %/% as.duration(days(1))

class(as.duration(interval(date2, date1)))
