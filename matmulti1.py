import numpy as np
import timeit

def matmul(X,Y):
    # initialise result matrix Z
    Z = np.zeros_like(X)
    # iterate through rows of matrix X
    for i in range(X.shape[0]):
        # iterate through columns of matrix Y
        for j in range(Y.shape[1]):
            # iterate through rows of Y
            for k in range(Y.shape[0]):
                Z[i,j] += X[i,k] * Y[k,j]

# wrapper to make test function callable for timing
def wrapper(func, *args, **kwargs):
    def wrapped():
        return func(*args, **kwargs)
    return wrapped

# set number of rows and columns
N = 100

# generate square matrices and fill with random numbers
X = np.random.rand(N,N)
Y = np.random.rand(N,N)

# set the number of times the multiplication will be repeated
Ntimes = 10

# run matrix multiplication "Ntimes" times and print average timing
print "Nested for loops: ", timeit.timeit(wrapper(matmul,X,Y), number = 10)/Ntimes
