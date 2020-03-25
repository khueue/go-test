package main

import (
	"math/rand"
	"time"
)

func main() {
	rand.Seed(time.Now().UnixNano())

	items := []string{
		"one",
		"two",
		"three",
		"four",
		"five",
		"six",
		"seven",
		"eight",
	}

	waitGroupWorker := NewWaitGroupWorker(items)
	waitGroupWorker.Run()

	queueChanWorker := NewQueueChanWorker(items, 3)
	queueChanWorker.Run()
}
