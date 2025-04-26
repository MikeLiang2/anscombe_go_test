package main

import (
	"testing"
)

func BenchmarkSimpleLinearRegression(b *testing.B) {
	datasets := []struct {
		x []float64
		y []float64
	}{
		{x1, y1},
		{x2, y2},
		{x3, y3},
		{x4, y4},
	}

	for i := 0; i < b.N; i++ {
		for _, data := range datasets {
			_, _, _ = simpleLinearRegression(data.x, data.y)
		}
	}
}
