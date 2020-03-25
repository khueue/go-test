package main

import (
	"fmt"
	"math/rand"
	"time"
)

func QueueChanRun(items []string) {
	process := func(x string) {
		time.Sleep(time.Duration(rand.Intn(500)) * time.Millisecond)
		Dump(x)
	}

	queueChan := make(chan int, 3)
	for _, x := range items {
		x := x
		queueChan <- 1
		go func() {
			process(x)
			<-queueChan
		}()
	}
	time.Sleep(2 * time.Second)
	fmt.Println("All done, hopefully")
}
