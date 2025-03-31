# Common R Error Messages and Solutions

This guide covers frequent errors encountered when working with R and how to fix them.

## Syntax Errors

### Missing Closing Parenthesis, Bracket, or Quote

**Error:**
```
Error: unexpected symbol in:
"   geom_point()
  scale_color"
```

**Solution:**
Check for balanced parentheses, brackets, and quotes. Use RStudio's automatic indentation to help identify where the issue is.

### Incorrect Assignment Operator

**Error:**
```
Error: unexpected '=' in "x ="
```

**Solution:**
In R, the preferred assignment operator is `<-` rather than `=`.
```r
# Fix this:
x = 10

# To this:
x <- 10
```

### Missing Comma in Function Arguments

**Error:**
```
Error in data.frame(name = c("A", "B", "C") age = c(20, 30, 40)) : 
  argument "age" matches multiple formal arguments
```

**Solution:**
Add the missing comma.
```r
# Fix this:
data.frame(name = c("A", "B", "C") age = c(20, 30, 40))

# To this:
data.frame(name = c("A", "B", "C"), age = c(20, 30, 40))
```

## Object Errors

### Object Not Found

**Error:**
```
Error: object 'student_data' not found
```

**Solution:**
- Check for typos in your variable name
- Make sure you've created the object before trying to use it
- Verify you're working in the correct environment
- Check if your DataFrame and column names are correct

### Cannot Coerce Type

**Error:**
```
Error in mean(x) : argument is not numeric
```

**Solution:**
Check the data type of your variable and convert if necessary.
```r
# Check data type
class(x)

# Convert to numeric if needed
x <- as.numeric(x)
```

### Incorrect Subscript Type / Index Out of Bounds

**Error:**
```
Error: Invalid subscript type 'character'
```
or
```
Error: subscript out of bounds
```

**Solution:**
- For data frames, use `$` for column names: `df$column_name`
- For vectors, make sure index is within bounds: `x[1]` is valid if `length(x) >= 1`
- Check vector length with `length(x)`

## Package and Function Errors

### Package Not Found

**Error:**
```
Error in library(ggplot3) : there is no package called 'ggplot3'
```

**Solution:**
Check the package name and install it if needed.
```r
# Check for typos (e.g., ggplot3 vs ggplot2)
# Install the package if needed
install.packages("ggplot2")
```

### Function Not Found

**Error:**
```
Error: could not find function "geom_point"
```

**Solution:**
Load the required package that contains the function.
```r
# For ggplot2 functions
library(ggplot2)
```

## Data Import Errors

### File Not Found

**Error:**
```
Error in file(file, "rt") : cannot open the connection
```

**Solution:**
- Check file path and name
- Verify working directory with `getwd()`
- Use `setwd()` to change directory or use full file paths
- Use forward slashes `/` instead of backslashes in file paths

### Column Name Mismatch

**Error:**
```
Error: Can't subset columns that don't exist.
✖ Column `Score` doesn't exist.
```

**Solution:**
Check your column names. R is case-sensitive.
```r
# See all column names
names(df)

# Use the exact column name with correct capitalization
df$score  # not df$Score
```

## ggplot2 Specific Errors

### Aesthetics Must Be Length 1 or Same Length as Data

**Error:**
```
Error: Aesthetics must be either length 1 or the same as the data (5): x
```

**Solution:**
Ensure the variable mapped to an aesthetic exists in your data.
```r
# Fix this:
ggplot(data, aes(x = non_existent_column)) + geom_point()

# To something like this:
ggplot(data, aes(x = actual_column)) + geom_point()
```

### Incompatible Length Error

**Error:**
```
Error: Aesthetics must be either length 1 or the same as the data
```

**Solution:**
Make sure vectors used in your data frame have the same length.
```r
# Fix this:
data.frame(x = 1:5, y = 1:4)  # Different lengths

# To this:
data.frame(x = 1:5, y = c(1:4, NA))  # Same length with NA
```

## Tips for Debugging

1. **Read the error message carefully** - R usually tells you exactly what's wrong
2. **Use `str()` to check data structure**
   ```r
   str(df)  # Shows structure of dataframe including column types
   ```
3. **Check variable types with `class()`**
   ```r
   class(x)
   ```
4. **Use `head()` to view the first few rows**
   ```r
   head(df)
   ```
5. **For complex issues, create a minimal reproducible example**
6. **Comment out sections of code** to isolate where the error is occurring
7. **Use `traceback()` after an error** to see the function call stack
   ```r
   traceback()
   ```
8. **Use `browser()` to enter interactive debugging mode**
   ```r
   my_function <- function(x) {
     browser()  # Execution will pause here when function is called
     # Rest of function
   }
   ```

Remember: Debugging is a normal part of programming. With practice, you'll get better at quickly identifying and fixing errors.
