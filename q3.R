residuals <- residuals(reg)

# Print the sum of residuals
residual_sum <- sum(residuals)
print(residual_sum)
# plot the histogram
hist(residuals,breaks = 150, xlab = "Residuals", ylab = "Frequency", main = "Histogram of Residuals")

