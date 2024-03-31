residual_sum_yearwise <- aggregate(Residuals ~ Year, regression_results, sum)

# Print the result
print(residual_sum_yearwise)