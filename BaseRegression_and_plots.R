# gregression of gdp of state on gwq
reg <- lm(residualsodiumcarbonate ~ GDP, data = merged_df)
summary(reg)

ggplot(merged_df, aes(x = GDP, y = residualsodiumcarbonate)) +
  geom_point(color = "black", size = 0.4, alpha = 0.7) +
  labs(title = "Residualsodiumcarbonate vs. SDP",
       x = "SDP",
       y = "Residualsodiumcarbonate") +
  theme_minimal() +geom_smooth(method = "lm", se = FALSE, color = "cyan")

plot(merged_df$GDP, merged_df$residualsodiumcarbonate-fitted(reg), xlab = "GDP", ylab = "Fitted values of Residual Sodium Carbonate", main = "Fitted values vs. GDP")+ theme_minimal()

residuals <- residuals(reg)

residual_sum <- sum(residuals)
print(residual_sum)
# plot the histogram of residual
hist(residuals,breaks = 180, xlab = "Residuals", ylab = "Frequency", main = "Histogram of Residuals",)