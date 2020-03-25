# go-test

Experiments in Go.

Run using (requires Docker):

```
make run
```


## Notes

To minimize executable weight:

```
go build -ldflags "-s -w"
```

```
upx \
	-o ../_dist/linux/app-upx \
	../_dist/linux/app
```
