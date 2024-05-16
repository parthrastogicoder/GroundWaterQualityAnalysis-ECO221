unique(left_merged_df$state)
# left_merged_df$north <- NA_integer_
north <- c("CHANDIGARH", "DELHI", "HARYANA", "HIMACHAL PRADESH", "JAMMU AND KASHMIR", "PUNJAB", "RAJASTHAN")


left_merged_df$northern <- ifelse(left_merged_df$state %in% north, 1,0)

north_east <- c("ARUNACHAL PRADESH", "ASSAM", "MANIPUR", "MEGHALAYA", "MIZORAM", "NAGALAND", "TRIPURA")

left_merged_df$north_eastern<- ifelse(left_merged_df$state %in% north_east, 1,0)

east <- c("ANDAMAN AND NICOBAR ISLANDS", "BIHAR", "JHARKHAND", "ORISSA", "SIKKIM", "WEST BENGAL")

left_merged_df$eastern<- ifelse(left_merged_df$state %in% east, 1,0)

 central<- c("CHHATTISGARH", "MADHYA PRADESH", "UTTAR PRADESH", "UTTARAKHAND")


left_merged_df$centre<- ifelse(left_merged_df$state %in% central, 1,0)
west <- c("GOA", "GUJARAT", "MAHARASHTRA")


left_merged_df$western <- ifelse(left_merged_df$state %in% west, 1,0)
south <- c("ANDHRA PRADESH","KARNATAKA","KERALA","LAKSHADWEEP","PONDICHERRY","TAMIL NADU")


left_merged_df$southern <- ifelse(left_merged_df$state %in% south, 1,0)


# View the updated dataframe
summary(left_merged_df)

coeff <- list()
r_sq <- numeric()
num_obs_list <- numeric()
rmdl <- lm(residualsodiumcarbonate ~ GDP + I(GDP^2) + I(GDP^3) + ginivalue + north_eastern + eastern + southern+ centre + western +northern, data = left_merged_df)
summary(rmdl)
for (region in sort(unique(left_merged_df$region))) {
 # Subset the dataframe for the current region
 subset_df <- left_merged_df[left_merged_df$region == region, ]

 # Get the number of observations for the current region
 num_obs <- nrow(subset_df)
 num_obs_list[[as.character(region)]] <- num_obs

 # Perform linear regression
 regression_model <- lm(residualsodiumcarbonate ~ GDP + I(GDP^2) + I(GDP^3) + ginivalue, data = subset_df)

 # Store coefficients
 coeff[[as.character(region)]] <- coef(regression_model)

 # Store R-squared value
 r_sq <- c(r_sq, summary(regression_model)$r.squared)
 print(region)
 print(summary(regression_model))
}

for (region in sort(unique(left_merged_df$region))) {
 print(paste("Region:", region))
 print("Coefficients:")
 print(coeff[[as.character(region)]])
 print("R-squared:")
 print(r_sq[region])
 print("Number of Observations:")
 print(num_obs_list[[as.character(region)]])
 cat("\n")
}
