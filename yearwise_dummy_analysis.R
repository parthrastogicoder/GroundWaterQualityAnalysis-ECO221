coefficients_list <- list()
r_squared_values <- numeric()
num_obs_list <- numeric()

for (year in sort(unique(left_merged_df$year))) {
  # Subset the dataframe for the current year
  subset_df <- left_merged_df[left_merged_df$year == year, ]

  # Get the number of observations for the current year
  num_obs <- nrow(subset_df)
  num_obs_list[[as.character(year)]] <- num_obs

  # Perform linear regression
  regression_model_yearwise <- lm(residualsodiumcarbonate ~ GDP + I(GDP^2) + I(GDP^3) + ginivalue, data = subset_df)

  # Store coefficients
  coefficients_list[[as.character(year)]] <- coef(regression_model_yearwise)

  # Store R-squared value
  r_squared_values <- c(r_squared_values, summary(regression_model_yearwise)$r.squared)
}

# Plot year versus R-squared
plot(sort(unique(left_merged_df$year)), r_squared_values, type = "b",
     xlab = "Year", ylab = "R-squared", main = "Year vs. R-squared")

# Plot year versus number of observations
plot(sort(unique(left_merged_df$year)), num_obs_list, type = "b",
     xlab = "Year", ylab = "Number of Observations", main = "Year vs. Number of Observations")
# Create a new column indicating if the year is less than or equal to the year of observation
left_merged_df$dummy_year <- as.numeric(left_merged_df$year <= left_merged_df$obs_year)

coefficients_list <- list()
r_squared_values <- numeric()
num_obs_list <- numeric()

# Perform linear regression using the dummy variable
regression_model <- lm(residualsodiumcarbonate ~ GDP + I(GDP^2) + I(GDP^3) + ginivalue + dummy_year, data = left_merged_df)

# Store coefficients
coefficients_list[["Overall"]] <- coef(regression_model)

# Store overall R-squared value
overall_r_squared <- summary(regression_model)$r.squared

# Print overall R-squared value
cat("Overall R-squared value:", overall_r_squared, "\n")
summary(regression_model)
# Plot year versus R-squared
plot(sort(unique(left_merged_df$year)), rep(overall_r_squared, length(unique(left_merged_df$year))), type = "b",
     xlab = "Year", ylab = "R-squared", main = "Year vs. R-squared")

# Plot year versus number of observations
plot(sort(unique(left_merged_df$year)), num_obs_list, type = "b",
     xlab = "Year", ylab = "Number of Observations", main = "Year vs. Number of Observations")
# Create dummy variables for each year
for (year in 2000:2019) {
  col_name <- paste0("dummy_", year)
  left_merged_df[[col_name]] <- as.numeric(left_merged_df$obs_year <= year)
}

coefficients_list <- list()
r_squared_values <- numeric()
num_obs_list <- numeric()

# Create formula for regression model
formula <- as.formula(paste("residualsodiumcarbonate ~ GDP + I(GDP^2) + I(GDP^3) + ginivalue +", paste0("dummy_", 2000:2018, collapse = " + ")))

# Perform linear regression using all dummy variables
regression_model <- lm(formula, data = left_merged_df)

# Store coefficients
coefficients_list[["Overall"]] <- coef(regression_model)

# Store overall R-squared value
overall_r_squared <- summary(regression_model)$r.squared

# Print overall R-squared value
cat("Overall R-squared value:", overall_r_squared, "\n")

# Plot year versus R-squared
plot(2000:2019, rep(overall_r_squared, 20), type = "b",
     xlab = "Year", ylab = "R-squared", main = "Year vs. R-squared")

# Plot year versus number of observations
plot(2000:2019, num_obs_list, type = "b",
     xlab = "Year", ylab = "Number of Observations", main = "Year vs. Number of Observations")
# Create dummy variables for each year
# Load the dplyr package
library(dplyr)

# Create dummy variables for each year
# Load the dplyr package
library(dplyr)

# Create dummy variables for each year
for (year in 2000:2019) {
  col_name <- paste0("dummy_", year)
  left_merged_df <- left_merged_df %>%
    mutate(!!col_name := as.numeric(year <= year))
}

# Print the first few rows of the dataframe to check dummy variables
summary(left_merged_df)
# Load the dplyr package
library(dplyr)

# Create dummy variables for each year
for (yr in 2000:2019) {
  col_name <- paste0("dummy_", yr)
  left_merged_df <- left_merged_df %>%
    mutate(!!col_name := as.numeric(year == yr))
}
left_merged_df <- subset(left_merged_df, select = -c(dummy_2019))
left_merged_df <- subset(left_merged_df, select = -c(dummy_2000))

head(left_merged_df)

formula <- as.formula(paste("residualsodiumcarbonate ~ GDP + I(GDP^2) + I(GDP^3) + ginivalue +", paste0("dummy_", 2001:2018, collapse = " + ")))

regyr <- lm(formula, data = left_merged_df)
summary( regyr)
library(ggplot2)
coefficients <- coef(regyr)

years <- 2001:2018

plot_data <- data.frame(year = years, coefficient = coefficients[7:length(coefficients)-1])

print(plot_data)

ggplot(plot_data, aes(x = year, y = coefficient)) +
  geom_point() +
  geom_line() +
  labs(x = "Year", y = "Coefficient Value",
       title = "Coefficient Values by Year") +
  geom_text(aes(label = names(coefficients)[6:length(coefficients)]), hjust = -0.2, vjust = -0.2, size = 3) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
  theme_minimal()
ggplot(plot_data, aes(x = year, y = coefficient)) +
  geom_point() +
  geom_line() +
  labs(x = "Year", y = "Coefficient Value",
       title = "Coefficient Values by Year") +
  geom_text(data = plot_data, aes(label = round(coefficient, 3)), hjust = -0.2, vjust = -0.2, size = 3) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
  theme_minimal()+geom_smooth(method = "lm", se = FALSE, color = "Green")


summary( left_merged_df)