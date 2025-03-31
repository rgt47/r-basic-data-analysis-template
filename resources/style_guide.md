# R Style Guide

Good coding style is like correct punctuation: you can manage without it, but it sure makes things easier to read. This style guide outlines best practices for R code to help you write clear, readable, and maintainable code.

## File Organization

1. **Use clear file names** that describe the content (e.g., `data_cleaning.R`, `visualization.R`)
2. **Begin each file with comments** explaining the purpose of the script
3. **Include library loading** at the beginning of the script
4. **Organize your code** into labeled sections

Example:
```r
# ===================================================
# Data Cleaning for Student Performance Analysis
# Author: Your Name
# Date: YYYY-MM-DD
# Description: This script cleans the raw student data
# ===================================================

# Load libraries
library(tidyverse)
library(janitor)

# Import data
# ...
```

## Naming Conventions

1. **Variable names** should be lowercase, with words separated by underscores
2. **Function names** should be verbs that describe what the function does
3. **Avoid using names of existing functions** or variables

Good examples:
```r
# Good variable names
student_scores <- read.csv("scores.csv")
mean_score <- mean(student_scores$score)

# Good function names
calculate_grade_average <- function(scores) {
  # Function code
}
```

Bad examples:
```r
# Bad variable names
s <- read.csv("scores.csv")  # Too short to be meaningful
StudentScores <- read.csv("scores.csv")  # Inconsistent capitalization
student.scores <- read.csv("scores.csv")  # Dot notation can be confused with S3 methods

# Bad function names
function1 <- function(x) { }  # Not descriptive
mean <- function(x) { }  # Overwrites an existing function
```

## Spacing and Indentation

1. **Use spaces around operators** (`+`, `-`, `=`, `<-`, etc.)
2. **Use two spaces for indentation** (not tabs)
3. **Place spaces after commas**, just like in English
4. **No spaces around brackets** for function calls

Example:
```r
# Good spacing
if (condition) {
  x <- function_call(argument1, argument2)
  y <- x + 1
}

# Bad spacing
if( condition ){
  x<-function_call ( argument1,argument2 )
  y<-x+1
}
```

## Commenting

1. **Comment your code** to explain WHY, not WHAT
2. **Use section headers** to organize your script
3. **Document functions** with their purpose, parameters, and return values

Example:
```r
# Calculate grade based on numerical score
# Parameters:
#   score: Numerical score (0-100)
# Returns:
#   Letter grade (A, B, C, D, or F)
assign_grade <- function(score) {
  # Input validation
  if (score < 0 || score > 100) {
    stop("Score must be between 0 and 100")
  }
  
  # Determine grade based on common scale
  if (score >= 90) {
    return("A")
  } else if (score >= 80) {
    return("B")
  } else if (score >= 70) {
    return("C")
  } else if (score >= 60) {
    return("D")
  } else {
    return("F")
  }
}
```

## Line Length and Function Size

1. **Keep lines under 80 characters** when possible
2. **Break long functions** into smaller, more focused functions
3. **Avoid deep nesting** of loops and conditionals

Example of line breaking:
```r
# Long line broken into multiple lines
student_data <- data.frame(
  id = 1:100,
  name = student_names,
  score = student_scores,
  grade = sapply(student_scores, assign_grade)
)
```

## Pipe Operator (`%>%`) Usage

If you're using the tidyverse, format pipe chains for readability:

```r
# Good pipe formatting
students %>%
  filter(grade %in% c("A", "B")) %>%
  group_by(class) %>%
  summarize(
    count = n(),
    avg_score = mean(score, na.rm = TRUE)
  ) %>%
  arrange(desc(avg_score))
```

## Summary

Following a consistent style guide will make your code:
- Easier to read
- Easier to maintain
- Easier to debug
- More consistent across projects
- More professional

Remember that the ultimate goal of style guidelines is to make your code more readable and maintainable, both for others and for your future self.
