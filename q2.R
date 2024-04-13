
ggplot(merged_df, aes(x = GDP, y = residualsodiumcarbonate)) +
  geom_point() +
  labs(title = "Residualsodiumcarbonate vs. GDP",
       x = "GDP",
       y = "Residualsodiumcarbonate") +
  theme_minimal()
ggplot(regression_results, aes(x = GDP, y = Residuals)) +
  geom_point() +
  labs(title = "Residuals vs GDP",
       x = "GDP",
       y = "Residuals") +
  theme_minimal()

# Assuming 'reg' is your linear regression model
plot(merged_df$GDP, merged_df$residualsodiumcarbonate-fitted(reg), xlab = "GDP", ylab = "Fitted values of Residual Sodium Carbonate", main = "Fitted values vs. GDP")+ theme_minimal()
