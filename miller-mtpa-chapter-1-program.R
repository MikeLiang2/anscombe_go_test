# Start measuring time
start_time <- Sys.time()

options(repos = c(CRAN = "https://cloud.r-project.org"))

# Load pryr library for memory usage
if (!require(pryr)) {
  install.packages("pryr")
  library(pryr)
}

start_memory <- mem_used()  # Start measuring memory

# Prepare Anscombe data
anscombe <- data.frame(
    x1 = c(10, 8, 13, 9, 11, 14, 6, 4, 12, 7, 5),
    x2 = c(10, 8, 13, 9, 11, 14, 6, 4, 12, 7, 5),
    x3 = c(10, 8, 13, 9, 11, 14, 6, 4, 12, 7, 5),
    x4 = c(8, 8, 8, 8, 8, 8, 8, 19, 8, 8, 8),
    y1 = c(8.04, 6.95, 7.58, 8.81, 8.33, 9.96, 7.24, 4.26,10.84, 4.82, 5.68),
    y2 = c(9.14, 8.14, 8.74, 8.77, 9.26, 8.10, 6.13, 3.10, 9.13, 7.26, 4.74),
    y3 = c(7.46, 6.77, 12.74, 7.11, 7.81, 8.84, 6.08, 5.39, 8.15, 6.42, 5.73),
    y4 = c(6.58, 5.76, 7.71, 8.84, 8.47, 7.04, 5.25, 12.5, 5.56, 7.91, 6.89)
)

# Show results from four regression analyses (short format)
datasets <- list(
  list("x1", "y1"),
  list("x2", "y2"),
  list("x3", "y3"),
  list("x4", "y4")
)

for (i in seq_along(datasets)) {
  xvar <- datasets[[i]][[1]]
  yvar <- datasets[[i]][[2]]
  model <- lm(as.formula(paste(yvar, "~", xvar)), data = anscombe)
  coef <- coef(model)
  intercept <- coef[1]
  slope <- coef[2]
  cat(sprintf("Dataset %d: Slope = %.5f, Intercept = %.5f\n", i, slope, intercept))
}

# End measuring
end_time <- Sys.time()
end_memory <- mem_used()

# Calculate and print
execution_time_ms <- as.numeric(difftime(end_time, start_time, units = "secs")) * 1000
memory_used_mb <- as.numeric(end_memory - start_memory) / 1024^2

cat("\nTotal R execution time:", sprintf("%.3f", execution_time_ms), "milliseconds\n")
cat("Memory used:", sprintf("%.3f", memory_used_mb), "MB\n")


# # Place four plots on one page using standard R graphics
# pdf(file = "fig_anscombe_R.pdf", width = 8.5, height = 8.5)
# par(mfrow=c(2,2), mar=c(5.1, 4.1, 4.1, 2.1))
# with(anscombe, plot(x1, y1, xlim=c(2,20), ylim=c(2,14), pch = 19, 
#     col = "darkblue", cex = 1.5, las = 1, xlab = "x1", ylab = "y1"))  
# title("Set I")
# with(anscombe, plot(x2, y2, xlim=c(2,20), ylim=c(2,14), pch = 19, 
#     col = "darkblue", cex = 1.5, las = 1, xlab = "x2", ylab = "y2"))
# title("Set II")
# with(anscombe, plot(x3, y3, xlim=c(2,20), ylim=c(2,14), pch = 19, 
#     col = "darkblue", cex = 1.5, las = 1, xlab = "x3", ylab = "y3"))
# title("Set III")
# with(anscombe, plot(x4, y4, xlim=c(2,20), ylim=c(2,14), pch = 19, 
#     col = "darkblue", cex = 1.5, las = 1, xlab = "x4", ylab = "y4"))
# title("Set IV")
# dev.off()

# # End measuring




# cat("\nTotal R execution time:", sprintf("%.3f", execution_time_ms), "milliseconds\n")
# cat("Memory used:", sprintf("%.3f", memory_used_mb), "MB\n")
