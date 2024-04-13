# Read gini.csv into a dataframe
gini_df <- read.csv("gini.csv")

# Perform left join on merged_df and gini_df based on "district" and "DistrictName" columns
left_merged_df <- merge(merged_df, gini_df, by.x = "district", by.y = "DistrictName", all.x = TRUE)

# Print the merged dataframe
head(left_merged_df)

# Step 1: Enhance the Regression Model
reg2 <- lm(residualsodiumcarbonate ~ GDP + I(GDP^2) + I(GDP^3) + ginivalue, data = left_merged_df)

# Step 2: Estimate the Regression and Summarize Results
reg2_summary <- summary(reg2)

# Print the summary
print(reg2_summary)

# Create a table to summarize the regression results
regression_results_reg2 <- data.frame(
  Coefficients = coef(reg2),
  `Std. Error` = coef(summary(reg2))[, "Std. Error"],
  `t value` = coef(summary(reg2))[, "t value"],
  `Pr(>|t|)` = coef(summary(reg2))[, "Pr(>|t|)"]
)
rownames(regression_results_reg2) <- c("Intercept", "GDP", "GDP^2", "GDP^3", "Gini Value")

# Print the table
print(regression_results_reg2)
# Compute DFBETA values
dfbeta_values <- dfbetas(reg2)

# Print DFBETA values
print(dfbeta_values)
# Assuming 'df' is your dataframe and 'column_name' is the name of the column you want to remove
merged_df <- subset(left_merged_df, select = -c(residuals))
merged_df <- subset(left_merged_df, select = -c(dyid))
head(merged_df)
result <- 2 / sqrt(5315)
print(result)
indices <- which(apply(abs(dfbeta_values), 1, function(x) all(x > result)))

# Extract corresponding entries from the original dataframe
entries <- merged_df[indices, ]

print(entries)
install.packages("Hmisc")
library(Hmisc)

# Compute Cook's distance to identify influential observations
cooksd <- cooks.distance(reg2)

# Identify influential observations with Cook's distance greater than a threshold
threshold <- 4 / nrow(left_merged_df)  # Adjust the threshold as needed
outliers <- which(cooksd > threshold)

# Remove outliers
cleaned_df <- left_merged_df[-outliers, ]

# Step 3: Fit Regression Model
# Fit a regression model to the cleaned dataset
reg_cleaned <- lm(residualsodiumcarbonate ~ GDP + I(GDP^2) + I(GDP^3)+ginivalue, data = cleaned_df)

# Summary of the regression model
summary(reg_cleaned)

