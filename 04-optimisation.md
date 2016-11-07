# Optimising performance

Extrapolating from our previous result for $N=100$, we can estimate how long it would take to multiply matrices with $N=1000$: the number of floating-point operations increases by a factor of $1000$, owing to complexity of matrix multiplication. It would therefore take roughly $9.944*1000=9944$ seconds or 2 hours and 45 minutes to obtain the result, and matrix multiplication is probably just one step of a real-world application!

We already saw that our CPU should be able to compute a lot faster, so we can try to optimise our program to speed things up. Such optimisation can be a difficult topic - every program will require careful analysis to find bottlenecks and custom solutions to remove them, which can take a long time.

The situation is much simpler in our case. The first thing we can do is to use the `NumPy` package rather than implementing the matrix multiplication algorithm ourselves - apart from much better performance, we will also have the added benefit of using a well-tested and robust implementation of matrix multiplication, which reduces the risk of getting wrong results.

Let's look at the second implementation of matrix multiplication:
```
-bash-4.2$ cat matmulti2.py
```
Our own algorithm is now replaced by the `dot` function implemented in the `NumPy` package.

We run this example with $N=1000$:
```
-bash-4.2$ python matmulti2.py
```
~~~ {.output}
Running NumPy dot function 10 times...
Best runtime [seconds]: 4.443
~~~

We just computed $2,000,000,000$ or 2 billion floating-point operations for each iteration, so we can get another performance estimate:
```
-bash-4.2$ python -c "print(2.e9/4.443)"
```
~~~ {.python}
450146297.547
~~~
We now reached 450 MFLOPS - this is much better than before, the speed-up is about $9944/4.443\approx 2240$, which is a dramatic improvement. And yet, we are still relatively far away from optimal performance of modern processors.

> ## Challenge
>
> Extend the program "matmulti2.py" to calculate and print the FLOPS performance based on matrix size $N$ and the best runtime. Can you think of reasons why it is better to use the `dot` function than handwritten Python code?

We can now unload the Python module:
```
-bash-4.2$ module unload python/2.7.5
```
This is not always necessary - logging off Fitzroy will have the same effect, but we may need to work with the default system version of Python for another application.