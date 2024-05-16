current_directory <- getwd()
setwd(current_directory)

gwq_df <- read.csv("gwq.csv")
selected_columns <- gwq_df[, c("country", "state", "district", "year", "dyid", "residualsodiumcarbonate")]
new_df <- data.frame(selected_columns)
new_df$state <- gsub("Tamilnadu", "TAMIL NADU", new_df$state)
head(new_df)
new_df <- new_df[complete.cases(new_df$residualsodiumcarbonate), ]
print(names(new_df))
new_df
gdp_df <- read.csv("gdp.csv")
gdp_df$YEAR <- substring(gdp_df$YEAR, 1, nchar(gdp_df$YEAR) - 3)
gdp_df <- as.data.frame(lapply(gdp_df, as.integer))
gdp_df$ANDHRA.PRADESH[is.na(gdp_df$ANDHRA.PRADESH)] <- 0
gdp_df$TELANGANA[is.na(gdp_df$TELANGANA)] <- 0
gdp_df$ANDHRA.PRADESH <- gdp_df$ANDHRA.PRADESH + gdp_df$TELANGANA
gdp_df$TELANGANA <- NULL
index_2011 <- which(gdp_df$YEAR == 2011)[1]
if (!is.na(index_2011)) {
  row_2011 <- gdp_df[index_2011, ]
  row_20112 <- gdp_df[index_2011+1, ]
  for (i in (index_2011 + 1):nrow(gdp_df)) {
    gdp_df[i, -1] <- (gdp_df[i, -1] / row_20112[-1])*row_2011[-1]
  }
  gdp_df <- gdp_df[-index_2011, ]
}
gdp_df
index_2004 <- which(gdp_df$YEAR == 2004)[1]
if (!is.na(index_2004)) {
  row_2004 <- gdp_df[index_2004, ]
  row_20042 <- gdp_df[index_2004+1, ]
  for (i in (index_2004 + 1):nrow(gdp_df)) {
    gdp_df[i, -1] <- (gdp_df[i, -1] / row_20042[-1])*row_2004[-1]
  }
  gdp_df <- gdp_df[-index_2004, ]
}
gdp_df

library(ggplot2)
library(reshape2)
gdp_df_long <- melt(gdp_df, id.vars = "YEAR")
ggplot(gdp_df_long, aes(x = YEAR, y = value, color = variable)) +
  geom_line() +
  labs(title = "Yearwise GDP Graph for Every State", x = "Year", y = "GDP") +
  theme_minimal()
# Load required library
library(tidyr)

gdp_df$GDP <- paste(gdp_df$YEAR, colnames(gdp_df)[2:length(gdp_df)], sep = "_")


gdp_df_long <- reshape(gdp_df, varying = list(colnames(gdp_df)[2:length(gdp_df)]),
                       v.names = "GDP", timevar = "STATE", times = colnames(gdp_df)[2:length(gdp_df)],
                       new.row.names = 1:10000, direction = "long")
gdp_df_long
head(gdp_df)
gdp_df_long$STATE <- gsub("\\.", " ", gdp_df_long$STATE)
gdp_df_long <- gdp_df_long[, !names(gdp_df_long) %in% c("id")]
str(gdp_df_long)
gdp_df_long$STATE <- gsub("ANDAMAN   NICOBAR ISLANDS", "ANDAMAN AND NICOBAR ISLANDS", gdp_df_long$STATE)
gdp_df_long$STATE <- gsub("JAMMU   KASHMIR", "JAMMU AND KASHMIR", gdp_df_long$STATE)
gdp_df_long$STATE <- gsub("PUDUCHERRY", "PONDICHERRY", gdp_df_long$STATE)
new_df$state <- toupper(new_df$state)
print(new_df)
str(new_df)
merged_df <- merge(new_df, gdp_df_long, by.x = c("year", "state"), by.y = c("YEAR", "STATE"), all = FALSE)
merged_df
merged_df$district <- toupper(merged_df$district)
str(merged_df)

write.csv(merged_df, file = "merged_csv.csv", row.names = FALSE)
