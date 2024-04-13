
coefficients_list <- list()
r_squared_values <- numeric()

for (year in sort(unique(left_merged_df$year))) {
  # Subset the dataframe for the current year
  subset_df <- left_merged_df[left_merged_df$year == year, ]

  # Perform linear regression
  regression_model_yearwise <- lm(residualsodiumcarbonate ~ GDP + I(GDP^2) + I(GDP^3) + ginivalue, data = subset_df)

  # Store coefficients
  coefficients_list[[as.character(year)]] <- coef(regression_model_yearwise)

  # Store R-squared value
  r_squared_values <- c(r_squared_values, summary(regression_model_yearwise)$r.squared)
}
# r_squared_values
# Print coefficients and R-squared values for each year
for (year in sort(unique(left_merged_df$year))) {
  print(paste("Year:", year))
  print("Coefficients:")
  print(coefficients_list[[as.character(year)]])
   print("R-squared:")
  print(r_squared_values[year - 2000+1 ])
  cat("\n")
}

