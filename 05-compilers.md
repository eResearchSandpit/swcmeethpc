# Using compilers

We will try the same computation using a Fortran program. Fortran was first created in the late 1950s, and it is the oldest among "high-level" programming languages. While it is often seen as very old-fashioned, it has evolved over the decades and is still very popular in the HPC world.

A Fortran code needs a Fortran compiler: the compiler translates the source code directly into machine instructions, which are stored in a new file called "executable". Once compiled, the compiler is no longer needed to run the program. Python works a bit differently in that respect - some implementations can also compile Python code into machine instructions, but usually the Python program is only compacted into a byte code, which still needs Python to run. Python also does a lot of convenience work under the hood, to make the language easier to use than a "less-high-level" language like Fortran. This often results in worse performance, as we shall see.

The XL Fortran compiler is already available on the system, so we won't need to load a module:
```
-bash-4.2$ xlf90 -qversion
```
~~~ {.output}
IBM XL Fortran for AIX, V14.1 (5765-J04, 5725-C74)
Version: 14.01.0000.0012
~~~

Here is the plain Fortran implementation of the matrix multiplication algorithm:
```
-bash-4.2$ cat matmulti1.f90
```
The program looks very different from the Python program - unlike Python, the Fortran language requires strict variable definitions. We need to declare each type of variable and we are not allowed to reuse the variable for any other type of data.

Let's compile the program:
```
-bash-4.2$ xlf90 -o matmulti1.x -qsclk=micro -O3 -qstrict -qarch=pwr6 -qtune=pwr6  matmulti1.f90

```
~~~ {.output}
** matmulti1   === End of Compilation 1 ===
1501-510  Compilation successful for file matmulti1.f90.
~~~
There are a lot of settings on the command line, which are called compiler flags. Apart from telling ```xlf90``` that we want to compile ```matmulti1.f90```, we also use a few optimisation settings. The flags ```-qarch=pwr6``` and ```-qtune=pwr6``` tell the compiler that we are going to run the program on a POWER6 processor, and it can therefore take advantage of all its capabilities. The flag ```-O3``` tells the compiler to use automatic optimisation to make the program faster, while ```-qstrict``` restricts some of these optimisations to ensure that the results of the computation are reliable. Setting ```-qsclk``` instructs the compiler to use a more precise timing method for measuring compute times, and ```-o``` finally sets the name of the executable.

We can now run our freshly compiled program:
```
-bash-4.2$ ./matmulti1.x

```
~~~ {.output}
 Running nested do loops 10 times...
 Best runtime [seconds]: 0.783828999999999998
 Performance [GFLOPS]: 2.55157693833731614
~~~
The code evaluates its performance itself, and we now run at 2.6 GFLOPS, we are more than 5 times faster compared to the fastest Python code!

Matrix multiplication is a standard problem for which processor makers offer highly optimised implementations, such as Intel's MKL, AMD's ACML, or IBM's ESSL for CPUs, and Nvidia's cuBLAS for GPUs. They allow us to use a processor's maximal performance with very little effort.

We will now run another example that uses ESSL (Engineering and Scientific Subroutine Library):
```
-bash-4.2$ xlf90 -o matmulti3.x -qsclk=micro -O3 -qstrict -qarch=pwr6 -qtune=pwr6 -lessl matmulti3.f90

```
~~~ {.output}
** matmulti3   === End of Compilation 1 ===
1501-510  Compilation successful for file matmulti3.f90.
~~~
Note the new flag ```-lessl```, which instructs the compiler to include ESSL in our executable. Libraries are collections of ready-made functions. ESSL implements the function "DGEMM", which is part of BLAS (Basic Linear Algebra Subprograms) and performs matrix multiplications very quickly.

Let's run the code:
```
-bash-4.2$ ./matmulti3.x

```
~~~ {.output}
 Running BLAS routine DGEMM 10 times...
 Best runtime [seconds]: 0.150283000000000000
 Performance [GFLOPS]: 13.3082251485530634
~~~
We now reach more than 13 GFLOPS, or another speedup of 5 over our own Fortran program. Compared to our original Python program, we have reached a speedup of more than 60,000...

> ## Challenge
>
> Why is the `python` program still needed to run a code written in Python language, while the `xlf90` program is not needed to run a Fortran code? Hint: look at the files "matmulti1.py", "matmulti1.f90", and "matmulti1.x" using the `less` program; you will need to confirm that you want to look at binary file "matmulti1.x" by typing "y". Will the microprocessor understand the Python code in "matmulti1.py" or the Fortran code in "matmulti1.f90"? Can you understand the content of "matmulti1.x"?