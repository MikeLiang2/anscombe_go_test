package main

import (
	"fmt"
	"runtime"
	"time"

	"github.com/montanaflynn/stats"
)

// Anscombe data
var (
	x1 = []float64{10, 8, 13, 9, 11, 14, 6, 4, 12, 7, 5}
	y1 = []float64{8.04, 6.95, 7.58, 8.81, 8.33, 9.96, 7.24, 4.26, 10.84, 4.82, 5.68}

	x2 = []float64{10, 8, 13, 9, 11, 14, 6, 4, 12, 7, 5}
	y2 = []float64{9.14, 8.14, 8.74, 8.77, 9.26, 8.10, 6.13, 3.10, 9.13, 7.26, 4.74}

	x3 = []float64{10, 8, 13, 9, 11, 14, 6, 4, 12, 7, 5}
	y3 = []float64{7.46, 6.77, 12.74, 7.11, 7.81, 8.84, 6.08, 5.39, 8.15, 6.42, 5.73}

	x4 = []float64{8, 8, 8, 8, 8, 8, 8, 19, 8, 8, 8}
	y4 = []float64{6.58, 5.76, 7.71, 8.84, 8.47, 7.04, 5.25, 12.50, 5.56, 7.91, 6.89}
)

// Function to calculate slope and intercept
func simpleLinearRegression(x, y []float64) (slope, intercept float64, err error) {
	xMean, err := stats.Mean(x)
	if err != nil {
		return
	}
	yMean, err := stats.Mean(y)
	if err != nil {
		return
	}
	var numerator, denominator float64
	for i := range x {
		numerator += (x[i] - xMean) * (y[i] - yMean)
		denominator += (x[i] - xMean) * (x[i] - xMean)
	}
	slope = numerator / denominator
	intercept = yMean - slope*xMean
	return
}

func main() {
	var memStart runtime.MemStats
	runtime.ReadMemStats(&memStart)
	start := time.Now()

	datasets := []struct {
		x    []float64
		y    []float64
		name string
	}{
		{x1, y1, "Dataset 1"},
		{x2, y2, "Dataset 2"},
		{x3, y3, "Dataset 3"},
		{x4, y4, "Dataset 4"},
	}

	for _, data := range datasets {
		slope, intercept, err := simpleLinearRegression(data.x, data.y)
		if err != nil {
			fmt.Printf("Error calculating regression for %s: %v\n", data.name, err)
			continue
		}
		fmt.Printf("%s: Slope = %.5f, Intercept = %.5f\n", data.name, slope, intercept)
	}

	duration := time.Since(start)
	var memEnd runtime.MemStats
	runtime.ReadMemStats(&memEnd)

	fmt.Printf("\nTotal Go execution time: %v\n", duration)
	fmt.Printf("Memory used: %.2f KB\n", float64(memEnd.Alloc-memStart.Alloc)/1024)
}
