# =================================================================
# Basic Data Analysis in R - Starter Code
# =================================================================
# Instructions:
# 1. Complete all sections marked with "TODO"
# 2. Add comments to explain your code
# 3. Make sure to run your code to verify it works correctly
# =================================================================

# Load necessary libraries
# TODO: Load the required libraries for data analysis and visualization
# Hint: You might need ggplot2, dplyr, etc.


# =================================================================
# Part 1: Data Import and Exploration
# =================================================================

# TODO: Load the student_scores.csv file
# Hint: Use read.csv() or read_csv() function


# TODO: Display the first 6 rows of the dataset
# Hint: Use the head() function


# TODO: Check the structure of the dataset
# Hint: Use str() or glimpse() to understand data types


# TODO: Get a summary of the dataset
# Hint: Use summary() to see statistical summaries of each column


# TODO: Check for missing values in the dataset
# Hint: Use is.na() or complete.cases()


# =================================================================
# Part 2: Data Visualization
# =================================================================

# TODO: Create a histogram of student scores
# Hint: Use ggplot2 for better visualization or base R hist() function
# Make sure to add proper title, labels, and adjust bin width as needed


# TODO: Create a scatter plot to visualize the relationship between study hours and scores
# Hint: Use plot() or ggplot() with geom_point()
# Add a trend line to better visualize the relationship


# TODO: Create a box plot of scores by subject
# Hint: Use boxplot() or ggplot() with geom_boxplot()
# Make sure to clearly label the plot


# =================================================================
# Part 3: Analysis
# =================================================================

# TODO: Calculate the correlation between study hours and scores
# Hint: Use cor() function and interpret the result


# TODO: Fit a simple linear regression model to predict scores based on study hours
# Hint: Use lm() function
model <- 

# TODO: Display the summary of the regression model
# Hint: Use summary() to see detailed statistics about your model


# TODO: Extract the model coefficients and interpret them
# What do the intercept and slope mean in this context?


# TODO: Calculate the R-squared value and explain what it means
# Hint: The R-squared value indicates how well the model fits the data


# =================================================================
# Part 4: Additional Analysis
# =================================================================

# TODO: Analyze if the relationship between study hours and scores 
# differs by subject
# Hint: You might consider creating separate models for each subject
# or use interaction terms


# TODO: Predict the score for a student who studies for 6 hours
# Hint: Use the predict() function with your model


# =================================================================
# Conclusion
# =================================================================

# TODO: Write a brief conclusion about your findings
# Consider the following questions:
# 1. Is there a significant relationship between study hours and scores?
# 2. Are there differences in scores across subjects?
# 3. What other factors might influence student scores?
# 4. How could the analysis be improved with additional data?


# =================================================================
# Bonus (Optional)
# =================================================================

# TODO: Create a more advanced visualization that combines multiple 
# aspects of the data
# Ideas:
# - Scatter plot with color-coded subjects
# - Faceted plots showing different relationships
# - Interactive visualization


# =================================================================
# End of Assignment
# =================================================================
