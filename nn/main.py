from nn import *
import files as fi

nn=NN([784,100,10])
it=zip(fi.img('train-images-idx3-ubyte'),fi.lab('train-labels-idx1-ubyte'))
# nn.sgd(it,10,0.5,30,5)
# fi.save('nn-100-60000',nn.ww,nn.bb,nn.sz)
nn.ww,nn.bb,nn.sz=fi.load('nn-100-60000')
print(nn.test(zip(fi.img('t10k-images-idx3-ubyte')[:100],fi.lab('t10k-labels-idx1-ubyte')[:100])))
