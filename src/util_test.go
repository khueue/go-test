package main

import (
	"testing"
)

func TestAddInts(t *testing.T) {
	actual := AddInts(2, 3)
	if actual != 5 {
		t.Errorf("Got: %d", actual)
	}
}
