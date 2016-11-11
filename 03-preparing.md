# Preparing code for running on a HPC

We are no longer working on our own computer, so we will need to prepare our code to run on the HPC. For a larger project, this can take many hours and could involve transfering data, building an executable program, and running test cases to make sure that the output of our program is exactly what we want. Our examples are a lot simpler, but we still have to make sure that everything works.

We will need Python for our first example. Let's check which version of Python is available on Fitzroy:
```
-bash-4.2$ cd matmul/swcmeethpc
-bash-4.2$ python --version
```
~~~ {.output}
Python 2.6.7
~~~
The default version does not provide the NumPy package that we will need for our examples. We will need to load a different version, which can be done with the ```module``` command:
```
-bash-4.2$ module load python/2.7.5
-bash-4.2$ python --version
```
~~~ {.output}
Python 2.7.5
~~~
The module command is a very easy way to customise the work environment, allowing us to choose between different software packages. A complete list of available packages can be shown using the command ```module avail```.

## Matrix Multiplication

Matrix multiplication is a classical performance test for computers: multiplying two N x N (real) matrices requires $N$ multiplications and $N - 1$ additions, which is a total of $2N-1$ "floating-point" operations for each element. We have $N^2$ elements in the matrix and thus need a grand total of $N^2(2N - 1)$ floating-point operations. For large values of $N$ the total number of floating-point operations is approximately $2N^3$, the so-called complexity of matrix multiplication is therefore $O(n^3)$. A fast computer can perform many floating-point operations per second ("FLOPS"), computational performance is thus often measured in FLOPS. Processors in modern laptop computers easily reach several GFLOPS, or billions of floating-point operations per second. Large HPC systems offer PFLOPS, or $10^{15}$ FLOPS.

![Figure 1](images/image00.png) <br>
Figure 1 : Schematic diagram of matrix multiplication operation

![Figure 2](images/image01.png)<br>
Figure 2: Example of square matrix multiplication with $D=2$

More information about computational complexity of mathematical operations is available on Wikipedia: https://en.wikipedia.org/wiki/Computational_complexity_of_mathematical_operations.

Let's look at a simple implementation of matrix multiplication:
```
-bash-4.2$ cat matmulti1.py
```
The algorithm uses three nested loops to compute the output matrix. A timing utility is used to measure the time needed to multiply matrices with $N=100$ rows and columns, repeating the process several times to obtain a mean value.

We can run the example directly on the remote computer:
```
-bash-4.2$ python matmulti1.py
```
~~~ {.python}
Running nested for loops 10 times...
Best runtime [seconds]: 9.944
~~~
The program returns the best time in seconds. Note that this number is influenced by many factors, including the type of computer on which we are running, and if there are other users on the remote computer running programs at the same time.

We can use Python to calculate the FLOPS performance, given that the processor needed to perform about $2N^3=2,000,000$ floating-point operations to compute the result in each iteration:
```
-bash-4.2$ python -c "print(2.e6/9.944)"
```
~~~ {.python}
201126.307321
~~~
We achieved 200 KFLOPS for our example, which is far below the processor's numerical capabilities - this has to do with the way in which Python runs programs, causing the processor to do much more than just floating-point operations. It also has to do with the age of the POWER6 microprocessor; modern processors can do a lot more FLOPS.

> ## Challenge
>
> How would you expect runtime to (approximately) change when doubling size $N$ of the two matrices? Remember that the computer needs to perform approximately $2N^3$ floating-point operations for the multiplication.
>
> 1. No change
> 2. Runtime doubles
> 3. Runtime increases by a factor of 4
> 4. Runtime increases by a factor of 8
