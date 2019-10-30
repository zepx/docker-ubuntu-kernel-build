## memo

```
docker build -t kernel-build .
docker run -it --rm -v ~/kbuild:/data -v ~/linux-patches:/patches -e KERNEL_MAJOR=4.15.0 kernel-build
```
