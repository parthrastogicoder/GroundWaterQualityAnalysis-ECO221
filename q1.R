regression_results <- data.frame(Year = numeric(),
                                 GDP = numeric(),
                                 Coefficients = numeric(),
                                 Intercept = numeric(),
                                 R_squared = numeric(),
                                 Residuals = numeric(),
                                 stringsAsFactors = FALSE)
merged_df$residuals <- NA

# Iterate through each unique year in merged_df
for (year in unique(merged_df$year)) {
  # Subset the dataframe for the current year
  subset_df <- merged_df[merged_df$year == year, ]

  # Extract GDP values
  GDP_values <- subset_df$GDP

  # Perform linear regression
  regression_model <- lm(residualsodiumcarbonate ~ GDP, data = subset_df)

  # Extract coefficients and R-squared value
  coefficients <- coef(regression_model)
  r_squared <- summary(regression_model)$r.squared
  residuals <- residuals(regression_model)

  # Store the results in the regression_results dataframe
  regression_results <- rbind(regression_results,
                              data.frame(Year = year,
                                         GDP = GDP_values,
                                         Coefficients = coefficients['GDP'],
                                         Intercept = coefficients['(Intercept)'],
                                         R_squared = r_squared,
                                         Residuals = residuals))
}

# View regression results
print(regression_results)

ggplot(regression_results, aes(x = Year, y = R_squared)) +
  geom_point() +
  labs(title = "Regression of GDP on residualsodiumcarbonate",
       x = "GDP",
       y = "Coefficient of GDP") +
  theme_minimal()

reg <- lm(residualsodiumcarbonate ~ GDP, data = merged_df)
summary(reg)
# Assuming 'reg' is your linear regression model

