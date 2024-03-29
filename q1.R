# Assuming merged_df contains columns for 'GDP', 'residualsodiumcarbonate', and 'Year'

# Create an empty dataframe to store the regression results
regression_results <- data.frame(Year = numeric(),
                                 Coefficients = numeric(),
                                 Intercept = numeric(),
                                 R_squared = numeric(),
                                 stringsAsFactors = FALSE)

# Iterate through each unique year in merged_df
for (year in unique(merged_df$year)) {
  # Subset the dataframe for the current year
  subset_df <- merged_df[merged_df$year == year, ]

  # Perform linear regression
  regression_model <- lm(residualsodiumcarbonate ~ GDP, data = subset_df)

  # Extract coefficients and R-squared value
  coefficients <- coef(regression_model)
  r_squared <- summary(regression_model)$r.squared

  # Store the results in the regression_results dataframe
  regression_results <- rbind(regression_results,
                              data.frame(Year = year,
                                         Coefficients = coefficients['GDP'],
                                         Intercept = coefficients['(Intercept)'],
                                         R_squared = r_squared))
}

# View regression results
print(regression_results)

ggplot(regression_results, aes(x = Year, y = R_squared)) +
  geom_point() +
  labs(title = "Regression of GDP on residualsodiumcarbonate",
       x = "GDP",
       y = "Coefficient of GDP") +
  theme_minimal()