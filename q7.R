unique(left_merged_df$state)
left_merged_df$region <- NA_integer_
north <- c("CHANDIGARH", "DELHI", "HARYANA", "HIMACHAL PRADESH", "JAMMU AND KASHMIR", "PUNJAB", "RAJASTHAN")


left_merged_df$region <- ifelse(left_merged_df$state %in% north, 1,left_merged_df$region)

north_east <- c("ARUNACHAL PRADESH", "ASSAM", "MANIPUR", "MEGHALAYA", "MIZORAM", "NAGALAND", "TRIPURA")

left_merged_df$region <- ifelse(left_merged_df$state %in% north_east, 2,left_merged_df$region)

east <- c("ANDAMAN AND NICOBAR ISLANDS", "BIHAR", "JHARKHAND", "ORISSA", "SIKKIM", "WEST BENGAL")

left_merged_df$region <- ifelse(left_merged_df$state %in% east, 3,left_merged_df$region)

 central<- c("CHHATTISGARH", "MADHYA PRADESH", "UTTAR PRADESH", "UTTARAKHAND")


left_merged_df$region <- ifelse(left_merged_df$state %in% central, 4,left_merged_df$region)
west <- c("GOA", "GUJARAT", "MAHARASHTRA")


left_merged_df$region <- ifelse(left_merged_df$state %in% west, 5,left_merged_df$region)
south <- c("ANDHRA PRADESH","KARNATAKA","KERALA","LAKSHADWEEP","PONDICHERRY","TAMIL NADU")


left_merged_df$region <- ifelse(left_merged_df$state %in% south, 6,left_merged_df$region)


# View the updated dataframe
print(left_merged_df)

coeff<- list()
r_sq <- numeric()

for (regions in sort(unique(left_merged_df$region))) {
 # Subset the dataframe for the current year
 subset_df <- left_merged_df[left_merged_df$region == regions, ]

 # Perform linear regression
 regml <- lm(residualsodiumcarbonate ~ GDP + I(GDP^2) + I(GDP^3) + ginivalue, data = subset_df)

 # Store coefficients
 coeff[[as.character(regions)]] <- coef(regml)

 # Store R-squared value
 r_sq<- c(r_squared_values, summary(regression_model_yearwise)$r.squared)
}
for (regions in sort(unique(left_merged_df$region))) {
 print(paste("Region", regions))
 print("Coefficients:")
 print(coeff[[as.character(regions)]])
 print("R-squared:")
 print(r_sq[regions ])
 cat("\n")
}
