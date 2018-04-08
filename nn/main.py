from nn1 import *
import files as fi
import numpy as np

# nn=NN([784,100,10])
# it=zip(fi.img('train-images-idx3-ubyte'),fi.lab('train-labels-idx1-ubyte'))
# # nn.sgd(it,10,0.5,30,5)
# # fi.save('nn-100-60000',nn.ww,nn.bb,nn.sz)
# nn.ww,nn.bb,nn.sz=fi.load('nn-100-60000')
# print(nn.test(zip(fi.img('t10k-images-idx3-ubyte')[:100],fi.lab('t10k-labels-idx1-ubyte')[:100])))

def sigmoid(x): return 1.0/(1.0+np.exp(-x))
def sigmoid1(x): return sigmoid(x)*(1-sigmoid(x))

nn=FULL(16,2,sigmoid,sigmoid1)
print(nn.ff(np.random.randn(16,1)))
