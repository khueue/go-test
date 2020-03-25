package main

import (
	"fmt"
	"math/rand"
	"sync"
	"time"
)

func WaitGroupRun(items []string) {
	process := func(x string) {
		time.Sleep(time.Duration(rand.Intn(500)) * time.Millisecond)
		Dump(x)
	}

	var wg sync.WaitGroup
	for _, x := range items {
		x := x // Unique copy for the processing.
		wg.Add(1)
		go func() {
			process(x)
			wg.Done()
		}()
	}
	wg.Wait()
	fmt.Println("All done")
}
