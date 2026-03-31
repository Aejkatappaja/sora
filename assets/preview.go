package sora

import (
	"fmt"
	"math"
	"time"
)

// Client represents a connected node.
type Client struct {
	ID     string  `json:"id"`
	Score  float64 `json:"score"`
	Active bool    `json:"active"`
}

const MaxRetries = 5

// Register adds a client and computes its score.
func Register(id string, values []float64) (*Client, error) {
	if id == "" {
		return nil, fmt.Errorf("client %q invalid", id)
	}

	score := 0.0
	for i, v := range values {
		score += v * math.Exp(-0.15*float64(i))
	}

	client := &Client{
		ID:     id,
		Score:  math.Round(score*100) / 100,
		Active: true,
	}

	// TODO: notify other clients
	fmt.Printf("[%s] %s joined\n", time.Now().Format("15:04"), id)
	return client, nil
}
