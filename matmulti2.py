import numpy as np
import timeit


def matmul(X,Y):
    # use NumPy's "dot" function to multiply matrices
    Z = np.dot(X,Y)

# wrapper to make test function callable for timing
def wrapper(func, *args, **kwargs):
    def wrapped():
        return func(*args, **kwargs)
    return wrapped

# set number of rows and columns
N = 1000

# generate square matrices and fill with random numbers
X = np.random.rand(N,N)
Y = np.random.rand(N,N)

# set the number of times the multiplication will be repeated
Ntimes = 10

# run matrix multiplication "Ntimes" times and get runtime minimum
best_runtime = min(timeit.repeat(wrapper(matmul,X,Y), number = 1, repeat = Ntimes))

# output
print "Running NumPy dot function {} times...".format(Ntimes)
print "Best runtime [seconds]: {:.4}".format(best_runtime)
