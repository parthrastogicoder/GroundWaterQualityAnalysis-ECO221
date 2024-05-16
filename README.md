
## Project Overview
This project aims to analyze the relationship between groundwater quality (GWQ), economic growth (measured by state domestic product, SDP), and income inequality (measured by the Gini index) across Indian districts from 2000 to 2019. The analysis involves several steps, including data merging, regression analysis, and interpretation of results. Key objectives include:

1. Merging district-year level GWQ data with state-year wise SDP data.
2. Merging the resultant dataset with district-level Gini index data.
3. Estimating a regression model to understand the relationship between GWQ (specifically residual sodium carbonate, RSC), SDP, and the Gini index.
4. Exploring non-linear relationships between environmental quality and economic growth by incorporating polynomial terms.
5. Analyzing results by year and region within India.

## Data Sources
1. **Groundwater Quality Data**: Provided in the project files, including multiple indicators measured in milligrams per liter for all Indian districts from 2000 to 2019, with the specific indicator being residual sodium carbonate (RSC).
2. **State-wise Economic Output Data**: Net state domestic product (SDP) at constant prices, obtained from the Reserve Bank of India's Database for the Indian Economy (DBIE) portal.
3. **District-level Gini Index**: Data from Mohanty et al. (2016).

## Steps and Instructions

### 1. Data Preprocessing
- **Data Merging**: Merge district-year level GWQ data with state-year wise SDP data, and then merge the resultant dataset with district-level Gini index data.

### 2. Regression Analysis
Estimate the following regression model:
\[ GWQ_{i,t} = \beta_0 + \beta_1 SDP_{i,t} + \beta_2 SDP_{i,t}^2 + \beta_3 SDP_{i,t}^3 + \beta_4 Gini_{i,t} + u_{i,t} \]
- Summarize the regression results in a table.
- Interpret the coefficients and overall model fit.

### 3. Non-linear Relationship Analysis
Enhance the regression model to reflect the environmental Kuznets curve hypothesis.
- Include polynomial terms for SDP.
- Summarize the results in a table.
- Prepare a detailed summary statistics table for all variables.
- Identify and address any outliers or influential observations.

### 4. Year and Regional Analysis
- Examine whether the relationship between SDP and GWQ differs by year.
- Enhance the model to examine differences across regions within India, as defined by RBI.

## Output
- **Tables**: Regression results, summary statistics.
- **Plots**: Residual plots, histogram of residuals.
- **Interpretation**: Explanation of the regression coefficients, residual analysis, non-linear relationship findings, and regional differences.

## Tools and Software
- **Programming Language**: R
- **Libraries**: tidyverse, stats, dplyr, ggplot2
- **Data Sources**: Project-provided files, Reserve Bank of India DBIE portal, Mohanty et al. (2016) paper.

## Additional Notes
- Ensure all data merges are accurately performed based on district and year.
- All Interpretations are provided in presentation attached 

## References
- Reserve Bank of India DBIE portal: [DBIE](https://dbie.rbi.org.in)
- Mohanty et al. (2016): [Link to PDF](#)
