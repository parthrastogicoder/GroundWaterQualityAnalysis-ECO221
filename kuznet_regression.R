# Read gini.csv into a dataframe
gini_df <- read.csv("gini.csv")

left_merged_df <- merge(merged_df, gini_df, by.x = "district", by.y = "DistrictName", all= FALSE)

head(left_merged_df)

reg2 <- lm(residualsodiumcarbonate ~ GDP + I(GDP^2) + I(GDP^3) + ginivalue, data = left_merged_df)
summary(left_merged_df)

reg2_summary <- summary(reg2)
summary(le)
# Print the summary
print(reg2_summary)

regression_results_reg2 <- data.frame(
  Coefficients = coef(reg2),
  `Std. Error` = coef(summary(reg2))[, "Std. Error"],
  `t value` = coef(summary(reg2))[, "t value"],
  `Pr(>|t|)` = coef(summary(reg2))[, "Pr(>|t|)"]
)
rownames(regression_results_reg2) <- c("Intercept", "GDP", "GDP^2", "GDP^3", "Gini Value")


print(regression_results_reg2)
# Compute DFBETA values
dfbeta_values <- dfbetas(reg2)

# Print DFBETA values
print(dfbeta_values)

left_merged_df <- subset(left_merged_df, select = -c(residuals))
left_merged_df <- subset(left_merged_df, select = -c(dyid))
head(left_merged_df)
result <- 2 / sqrt(4591)
print(result)
indices <- which(apply(abs(dfbeta_values), 1, function(x) all(x > result)))
out<-left_merged_df[indices, ]
out
summary(out)
# Extract corresponding entries from the original dataframe
cleaned_df <- left_merged_df[-indices, ]
summary(cleaned_df)

reg_cleaned <- lm(residualsodiumcarbonate ~ GDP + I(GDP^2) + I(GDP^3)+ginivalue, data = cleaned_df)

summary(reg_cleaned)

summary(left_merged_df["GDP"])
left_merged_df$GDP2=left_merged_df$GDP*left_merged_df$GDP
summary(left_merged_df["GDP2"])
left_merged_df$GDP3=left_merged_df$GDP*left_merged_df$GDP*left_merged_df$GDP
summary(left_merged_df["GDP3"])
summary(left_merged_df["ginivalue"])
summary(left_merged_df["year"])
quantile(left_merged_df["year"], probs = 0.95, na.rm = TRUE)

std_resid <- rstudent(reg2)

outliers <- abs(std_resid) > 3
summary(outliers)

cleaned_data <- left_merged_df[!outliers, ]

reg2_cleaned <- lm(residualsodiumcarbonate ~ GDP + I(GDP^2) + I(GDP^3) + ginivalue, data = cleaned_data)

summary(reg2_cleaned)
