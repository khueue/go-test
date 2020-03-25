package main

import (
	"fmt"
	"time"
)

func NewQueueChanWorker(items []string, batchSize int) *QueueChanWorker {
	return &QueueChanWorker{
		items:     items,
		queueChan: make(chan bool, batchSize),
	}
}

type QueueChanWorker struct {
	items     []string
	queueChan chan bool
}

func (w *QueueChanWorker) process(x string) {
	time.Sleep(400 * time.Millisecond)
	Dump(x)
}

func (w *QueueChanWorker) Run() {
	for _, x := range w.items {
		x := x
		w.queueChan <- true
		go func() {
			w.process(x)
			<-w.queueChan
		}()
	}
	time.Sleep(2 * time.Second)
	fmt.Println("All done, hopefully!")
}
