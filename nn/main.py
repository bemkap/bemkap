from nn1 import *
import files as fi
import numpy as np

ii=fi.img('data/train-images-idx3-ubyte')
# tt=fi.lab('data/train-labels-idx1-ubyte')

def sigmoid(x): return 1.0/(1.0+np.exp(-x))
def sigmoid1(x): return sigmoid(x)*(1-sigmoid(x))

nn=CNN([CONV((28,28),3,1),
        RELU(),
        POOL(2,2)])
        # FULL(14,7,sigmoid,sigmoid1),
        # SOFT()])


print(nn.ff(ii[0].reshape(28,28)).shape)
