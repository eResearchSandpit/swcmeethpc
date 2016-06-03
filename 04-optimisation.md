# Optimising performance

Extrapolating from our previous result for $N=100$, we can estimate how long it would take to multiply matrices with $N=1000$: the number of floating-point operations increases by a factor of $1000$, owing to complexity of matrix multiplication. It would therefore take roughly $1.035*1000=1035$ seconds or 17 minutes to obtain the result, and matrix multiplication is probably just one step of a real-world application!

We already saw that our CPU should be able to compute a lot faster, so we can try to optimise our program to speed things up. Such optimisation can be a difficult topic - every program will require careful analysis to find bottlenecks and custom solutions to remove them, which can take a long time.

The situation is much simpler in our case. The first thing we can do is to use the `NumPy` package rather than implementing the matrix multiplication algorithm ourselves - apart from much better performance, we will also have the added benefit of using a well-tested and robust implementation of matrix multiplication, which reduces the risk of getting wrong results.

Let's look at the second implementation of matrix multiplication:
```
[user@build-sb ~]$ cat matmulti2.py
```
Our own algorithm is now replaced by the `dot` function implemented in the `NumPy` package.

We run this example with $N=1000$:
```
[user@build-sb swcmeethpc]$ python matmulti2.py
```
~~~ {.output}
Running NumPy dot function 10 times...
Best runtime [seconds]: 7.084
~~~

We just computed $2,000,000,000$ or 2 billion floating-point operations for each iteration, so we can get another performance estimate:
```
[user@build-sb ~]$ python -c "print(2.e9/7.084)"
```
~~~ {.python}
282326369.283
~~~
We now reached 282 MFLOPS - this is much better than before, the speed-up is about $1035/7.084\approx 146$, which is a dramatic improvement. And yet, we are still relatively far away from optimal performance of modern processors.

Matrix multiplications is a standard problem for which processor makers offer highly optimised implementations, such as Intel's MKL or AMD's ACML for CPUs, and Nvidia's cuBLAS for GPUs. They allow us to use a processor's maximal performance with very little effort. For our Python example, which can simply use a Python version that has been built with the Intel MKL, so that `NumPy` will use this fast math library when computing matrix multiplication:
```
[user@build-sb swcmeethpc]$ module load Python/2.7.9-intel-2015a
[user@build-sb swcmeethpc]$ python --version
```
~~~ {.output}
Python 2.7.9
~~~
The `module load` command changes the shell environment, allowing us to override the standard version of Python with the "accelerated" version.

Let's run the same example again. We first have to tell MKL how many processors it should use by setting a so-called "environment variable". Environment variables work like `bash` variables, but they can be read by every program, not only `bash`. In this case, we use variable "MKL\_NUM\_THREADS" to tell MKL that it should use one processor for now to compute the results:
```
[user@build-sb swcmeethpc]$ export MKL_NUM_THREADS=1
[user@build-sb swcmeethpc]$ python matmulti2.py
```
~~~ {.output}
Running NumPy dot function 10 times...
Best runtime [seconds]: 0.08726
~~~

This is $7.084/0.08726\approx 81$ times faster than the standard version of Python, resulting in a performance of about 23 GFLOPS.

Now we can tell MKL to use 4 processors:
```
[user@build-sb swcmeethpc]$ export MKL_NUM_THREADS=4
[user@build-sb swcmeethpc]$ python matmulti2.py
```
~~~ {.output}
Running NumPy dot function 10 times...
Best runtime [seconds]: 0.02455

~~~

This is $0.08726/0.02455\approx 3.6$ times faster than running on processor, and results in a performance of about 81 GFLOPS.

And finally 8 processors:
```
[user@build-sb swcmeethpc]$ export MKL_NUM_THREADS=8
[user@build-sb swcmeethpc]$ python matmulti2.py
```
~~~ {.output}
Running NumPy dot function 10 times...
Best runtime [seconds]: 0.01257
~~~

This is $0.02455/0.01257\approx 2$ times faster then the previous result, and equivalent to about 159 GFLOPS.

To get back to our standard version of Python, we will need to unload the module:
```
module unload Python/2.7.9-intel-2015a
```
