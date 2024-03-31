# Read gini.csv into a dataframe
gini_df <- read.csv("gini.csv")

# Perform left join on merged_df and gini_df based on "district" and "DistrictName" columns
left_merged_df <- merge(merged_df, gini_df, by.x = "district", by.y = "DistrictName", all.x = TRUE)

# Print the merged dataframe
print(left_merged_df)
