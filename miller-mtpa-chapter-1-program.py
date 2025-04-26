# prepare for Python version 3x features and functions
from __future__ import division, print_function

# import packages for Anscombe Quartet demonstration
import pandas as pd  # data frame operations
import numpy as np  # arrays and math functions
import statsmodels.api as sm  # statistical models (including regression)
import time
import psutil

process = psutil.Process()
start_memory = process.memory_info().rss  # Start memory usage
start_time = time.time()  # Start timing

# define the anscombe data frame using dictionary of equal-length lists
anscombe = pd.DataFrame({
    'x1' : [10, 8, 13, 9, 11, 14, 6, 4, 12, 7, 5],
    'x2' : [10, 8, 13, 9, 11, 14, 6, 4, 12, 7, 5],
    'x3' : [10, 8, 13, 9, 11, 14, 6, 4, 12, 7, 5],
    'x4' : [8, 8, 8, 8, 8, 8, 8, 19, 8, 8, 8],
    'y1' : [8.04, 6.95,  7.58, 8.81, 8.33, 9.96, 7.24, 4.26,10.84, 4.82, 5.68],
    'y2' : [9.14, 8.14,  8.74, 8.77, 9.26, 8.10, 6.13, 3.10, 9.13, 7.26, 4.74],
    'y3' : [7.46, 6.77, 12.74, 7.11, 7.81, 8.84, 6.08, 5.39, 8.15, 6.42, 5.73],
    'y4' : [6.58, 5.76, 7.71, 8.84, 8.47, 7.04, 5.25, 12.50, 5.56, 7.91, 6.89]
})

# fit linear regression models by ordinary least squares
datasets = ['x1', 'x2', 'x3', 'x4']
responses = ['y1', 'y2', 'y3', 'y4']

for i, (x, y) in enumerate(zip(datasets, responses), start=1):
    X = sm.add_constant(anscombe[x])  # add intercept
    model = sm.OLS(anscombe[y], X)
    results = model.fit()
 #   print(f"\nRegression results for {x} and {y}:")
 #   print(results.summary())
    intercept, slope = results.params
    print(f"Dataset {i}: Slope = {slope:.5f}, Intercept = {intercept:.5f}")

end_time = time.time()
end_memory = process.memory_info().rss  # End memory usage

print("\nTotal Python execution time: {:.3f} milliseconds".format((end_time - start_time)*1000))
print(f"Memory used: {(end_memory - start_memory)/1024:.3f} KB")
