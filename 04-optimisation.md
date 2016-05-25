# Optimising performance

Extrapolating from our previous result for $N=100$, we can estimate how long it would take to multiply matrices with $N=1000$: the number of floating-point operations increases by a factor of $1000$, owing to complexity of matrix multiplication. It would therefore take roughly $6.75*1000=6750$ seconds or almost 2 hours to obtain the result, and matrix multiplication is probably just one step of a real-world application!

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
NumPy dot function: 7.66896131039
~~~

We just computed $2,000,000,000$ or 2 billion floating-point operations for each iteration, so we can get another performance estimate:
```
[user@build-sb ~]$ python -c "print(2.e9/7.67)"
```
~~~ {.python}
260756192.96
~~~
We now reached 261 MFLOPS - this is much better than before, the speed-up is about $6750/7.67\approx 880$, which is a dramatic improvement. And yet, we are still relatively far away from optimal performance of modern processors.

Matrix multiplications is a standard problem for which processor makers offer highly optimised implementations, such as Intel's MKL or AMD's ACML for CPUs, and Nvidia's cuBLAS for GPUs. They allow us to use a processor's maximal performance with very little effort. For our Python example, which can simply use a Python version that has been built with the Intel MKL, so that `NumPy` will use this fast math library when computing matrix multiplication:
```
[user@build-sb swcmeethpc]$ module load Python/2.7.9-intel-2015a
[user@build-sb swcmeethpc]$ python --version
```
~~~ {.output}
Python 2.7.9
~~~
The `module load` command changes the shell environment, allowing us to override the standard version of Python with the "accelerated" version.

Let's run the same example again. We first have to tell the MKL how many processors it should use by setting a so-called "environment variable" - MKL can use several processors in parallel to compute the results, enabling further speedups:
```
[user@build-sb swcmeethpc]$ export MKL_NUM_THREADS=1
[user@build-sb swcmeethpc]$ python matmulti2.py
```
~~~ {.output}
NumPy dot function: 0.0965677022934
~~~

This is $7.67/0.0966\approx 79$ times faster than the standard version of Python, resulting in a performance of about 21 GFLOPS.

Now we can try 4 processors:
```
[user@build-sb swcmeethpc]$ export MKL_NUM_THREADS=4
[user@build-sb swcmeethpc]$ python matmulti2.py
```
~~~ {.output}
NumPy dot function: 0.0318387985229
~~~

This is $0.0966/0.0318\approx 3$ times faster than running on processor, and results in a performance of about 63 GFLOPS.

And finally 8 processors:
```
[user@build-sb swcmeethpc]$ export MKL_NUM_THREADS=8
[user@build-sb swcmeethpc]$ python matmulti2.py
```
~~~ {.output}
NumPy dot function: 0.0206004142761
~~~

This is $0.0318/0.0206=1.54$ times faster then the previous result, and equivalent to about 97 GFLOPS.

Note that performance is not proportional to the number of processors used - parallel computation does not always "scale linearly". Nevertheless, we achieved a total speedup of more than 300,000 between our initial version that uses nested loops and our last test the fast math library on 8 processors!
