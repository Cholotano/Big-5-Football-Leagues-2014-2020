# Loading packages
library(dplyr)

# Reading dataset
football <- read.csv("understat.com.csv", strip.white=TRUE)

# Showing first 6 rows
head(football)

# Checking there is no null values
sapply(football, function(x) sum(is.na(x)))

# Keeping data of the big 5 leagues (dropping Russian League rows)
football <- filter(football, X != "RFPL")

# Rename some columns
football <- rename(football, league = X, season_start = X.1, received = missed)

# Removing diff statistics
football <- select(football, -c("xG_diff", "xGA_diff", "npxGD", "xpts_diff"))

# Normalizing data: statistics per match (except coeff ones: ppda_coef, oppda_coef)
statistics_to_normalize <- c("wins","draws","loses","scored","received","pts",
                             "xG", "npxG","xGA","npxGA", "deep",
                             "deep_allowed","xpts")
football <- mutate_at(football, all_of(statistics_to_normalize), 
                      list(permatch = ~ ./matches))
football <- select(football, -all_of(append(statistics_to_normalize, "matches")))

# Conjunto final
football_final <- football

# Escribimos el csv preparado
write.csv2(football_final, "C:\\Users\\User\\Desktop\\MASTER DATA SCIENCE\\2 SEMESTRE\\VISUALIZACIÓN\\PRAC2\\Preparado Datos\\football_final.csv")

