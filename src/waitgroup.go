package main

import (
	"fmt"
	"math/rand"
	"sync"
	"time"
)

func NewWaitGroupWorker(items []string) *WaitGroupWorker {
	return &WaitGroupWorker{
		items: items,
		wg:    sync.WaitGroup{},
	}
}

type WaitGroupWorker struct {
	items []string
	wg    sync.WaitGroup
}

func (w *WaitGroupWorker) process(x string) {
	time.Sleep(time.Duration(rand.Intn(500)) * time.Millisecond)
	Dump(x)
}

func (w *WaitGroupWorker) Run() {
	for _, x := range w.items {
		x := x // Unique copy for the processing.
		w.wg.Add(1)
		go func() {
			w.process(x)
			w.wg.Done()
		}()
	}
	w.wg.Wait()
	fmt.Println("All done!")
}
