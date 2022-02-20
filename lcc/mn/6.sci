funcprot(0);
a=[1 0 0;-1 0 1;-1 -1 2];
b=[1 0 0;-0.1 0 0.1;-0.1 -0.1 2];
c=[1 0 0;-0.25 0 0.25;-0.25 -0.25 2];
d=[4 -1 0;-1 4 -1;-1 -1 4];
e=[3 2 1;2 3 0;1 0 3];
f=[4.75 2.25 -0.25;2.25 4.75 1.25;-0.25 1.25 4.75];
function A=mat(e)
  A=[1 -1 0;-2 4 -2;0 -1 1+e*0.1];
endfunction
function p=ej3()
  for e=1:10 p(e)=poly(mat(e),"x"); end
endfunction
a1=[6 4 4 1;4 6 1 4;4 1 6 4;1 4 4 6];
a2=[12 1 3 4;1 -3 1 5;3 1 6 -2;4 5 -2 -1];
function x=pota(A,x,e)
  y=A*x/norm(A*x);
  while norm(y-x)>e do
    x=y;
    y=A*x/norm(A*x);
  end
endfunction
