# Scatter plot of residualsodiumcarbonate against GDP
ggplot(merged_df, aes(x = GDP, y = residualsodiumcarbonate)) +
  geom_point() +
  labs(title = "Residualsodiumcarbonate vs. GDP",
       x = "GDP",
       y = "Residualsodiumcarbonate") +
  theme_minimal()

# Scatter plot of model residuals against GDP
# Assuming you have already performed the regression analysis and stored it in 'regression_results'


