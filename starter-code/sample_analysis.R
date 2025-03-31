# ====================================================================
# Sample Data Analysis Script - Iris Dataset
# ====================================================================
# This script demonstrates a complete data analysis workflow
# using the built-in iris dataset
# ====================================================================

# Load required libraries
library(tidyverse)  # For data manipulation and visualization
library(corrplot)   # For correlation visualization
library(knitr)      # For nice table formatting

# ====================================================================
# Part 1: Data Exploration
# ====================================================================

# Look at the structure of the dataset
str(iris)

# Display the first few rows
head(iris)

# Summary statistics for all variables
summary(iris)

# Check for missing values
sum(is.na(iris))

# Create a clean data frame with consistent naming
iris_df <- iris %>%
  rename_with(tolower) %>%  # Convert column names to lowercase
  rename(
    sepal_length = sepal.length,
    sepal_width = sepal.width,
    petal_length = petal.length,
    petal_width = petal.width
  )

# ====================================================================
# Part 2: Data Visualization
# ====================================================================

# Create a histogram for sepal length
ggplot(iris_df, aes(x = sepal_length)) +
  geom_histogram(bins = 20, fill = "steelblue", color = "white") +
  labs(
    title = "Distribution of Sepal Length",
    x = "Sepal Length (cm)",
    y = "Frequency"
  ) +
  theme_minimal()

# Create boxplots for each measurement by species
iris_df %>%
  pivot_longer(
    cols = -species,
    names_to = "measurement",
    values_to = "value"
  ) %>%
  ggplot(aes(x = species, y = value, fill = species)) +
  geom_boxplot() +
  facet_wrap(~measurement, scales = "free_y") +
  labs(
    title = "Iris Measurements by Species",
    x = "Species",
    y = "Measurement (cm)"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Create a scatter plot of sepal vs petal dimensions
ggplot(iris_df, aes(x = sepal_length, y = petal_length, color = species)) +
  geom_point(alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE, linetype = "dashed") +
  labs(
    title = "Relationship Between Sepal Length and Petal Length",
    x = "Sepal Length (cm)",
    y = "Petal Length (cm)",
    color = "Species"
  ) +
  theme_minimal()

# Create a correlation matrix
iris_numeric <- iris_df %>%
  select(-species) %>%
  cor()

corrplot(iris_numeric, method = "circle", type = "upper", 
         tl.col = "black", tl.srt = 45, addCoef.col = "black")

# ====================================================================
# Part 3: Statistical Analysis
# ====================================================================

# Calculate correlation between sepal length and petal length
sepal_petal_cor <- cor(iris_df$sepal_length, iris_df$petal_length)
cat("Correlation between sepal length and petal length:", round(sepal_petal_cor, 3), "\n")

# Perform linear regression (predicting petal length from sepal length)
model <- lm(petal_length ~ sepal_length, data = iris_df)
summary(model)

# Extract model coefficients and create a formatted table
coef_table <- data.frame(
  Coefficient = names(coef(model)),
  Estimate = coef(model),
  `Std. Error` = summary(model)$coefficients[, "Std. Error"],
  `t value` = summary(model)$coefficients[, "t value"],
  `p value` = summary(model)$coefficients[, "Pr(>|t|)"]
)

# Format p-values with asterisks for significance
coef_table$Significance <- ifelse(coef_table$p.value < 0.001, "***",
                           ifelse(coef_table$p.value < 0.01, "**",
                           ifelse(coef_table$p.value < 0.05, "*", "")))

# Calculate R-squared
r_squared <- summary(model)$r.squared
adj_r_squared <- summary(model)$adj.r.squared

# Print formatted model results
cat("\nModel Results:\n")
cat("----------------\n")
knitr::kable(coef_table, digits = 3)
cat("\n")
cat("R-squared:", round(r_squared, 3), "\n")
cat("Adjusted R-squared:", round(adj_r_squared, 3), "\n")

# ====================================================================
# Part 4: Analysis by Species
# ====================================================================

# Create separate models for each species
species_models <- iris_df %>%
  group_by(species) %>%
  group_map(~lm(petal_length ~ sepal_length, data = .x))

# Name the models
names(species_models) <- levels(iris_df$species)

# Create a function to extract model details
get_model_summary <- function(model, species_name) {
  summary_model <- summary(model)
  data.frame(
    Species = species_name,
    Intercept = coef(model)[1],
    Slope = coef(model)[2],
    R_squared = summary_model$r.squared,
    P_value = summary_model$coefficients[2, "Pr(>|t|)"]
  )
}

# Apply the function to all models
model_comparison <- map2_dfr(
  species_models,
  levels(iris_df$species),
  get_model_summary
)

# Print model comparison
cat("\nModel Comparison by Species:\n")
cat("----------------------------\n")
knitr::kable(model_comparison, digits = 3)

# Visualize the species-specific regression lines
ggplot(iris_df, aes(x = sepal_length, y = petal_length, color = species)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE) +
  facet_wrap(~species) +
  labs(
    title = "Species-Specific Regression Models",
    subtitle = "Predicting Petal Length from Sepal Length",
    x = "Sepal Length (cm)",
    y = "Petal Length (cm)"
  ) +
  theme_minimal()

# ====================================================================
# Part 5: Conclusion
# ====================================================================

cat("\nConclusion:\n")
cat("------------\n")
cat("1. There is a strong positive correlation (r =", round(sepal_petal_cor, 3), 
    ") between sepal length and petal length in the iris dataset.\n")

cat("2. The linear regression model shows that sepal length is a significant predictor of petal length,\n",
    "   explaining approximately", round(r_squared * 100, 1), "% of the variance in petal length.\n")

cat("3. When analyzing by species, we find that the relationship between sepal length and petal length\n",
    "   varies considerably across the three iris species, with the strongest relationship in\n",
    "   ", model_comparison$Species[which.max(model_comparison$R_squared)], 
    "(R² =", round(max(model_comparison$R_squared), 3), ").\n")

cat("4. Visualizations show clear differences between species across all measured dimensions,\n",
    "   suggesting that these measurements can be used to distinguish between iris species.\n")

# ====================================================================
# End of Analysis
# ====================================================================
