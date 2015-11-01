import numpy as np
import numpy.matlib
import timeit

def matmulti2(X,Y):
    Z=np.matlib.zeros_like(X)
    Z=np.dot(X,Y)

def wrapper(func, *args, **kwargs):
    def wrapped():
        return func(*args, **kwargs)
    return wrapped

N=10000
X=np.matlib.rand(N,N)
Y=np.matlib.rand(N,N)

print "Numpy dot function:",timeit.timeit(wrapper(matmulti2,X,Y),number=10)

