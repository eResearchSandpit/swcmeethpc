import numpy as np
import numpy.matlib
import timeit

def matmulti1(X,Y):
#    print "Nested for loops"
    Z=np.matlib.zeros_like(X)
    # iterate through rows of X
    for i in range(X.shape[0]):
        # iterate through columns of Y
        for j in range(Y.shape[1]):
            # iterate through rows of Y
            for k in range(Y.shape[0]):
                Z[i,j] += X[i,k] * Y[k,j]

def wrapper(func, *args, **kwargs):
    def wrapped():
        return func(*args, **kwargs)
    return wrapped

N=100
X=np.matlib.rand(N,N)
Y=np.matlib.rand(N,N)

print "Nested for loops: ", timeit.timeit(wrapper(matmulti1,X,Y),number=10)

