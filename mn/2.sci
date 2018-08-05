funcprot(0);
function y=iteration(X)
  x=X(1); y=X(2);
  J=[2*x+%e^x*cos(y),-2*y-%e^x*sin(y);2*y+%e^x*sin(y),2*x+%e^x*cos(y)];
  f=[1+x^2-y^2+%e^x*cos(y);2*x*y+%e^x*sin(y)];
  y=X-inv(J)*f;
endfunction
function y=f(x)
  y=[2*x(1)+3*x(2)^2+%e^(2*x(1)^2+x(2)^2)];
endfunction
function y=g(x)
  y=[2+%e^(2*x(1)^2+x(2)^2)*4*x(1);6*x(2)+%e^(2*x(1)^2+x(2)^2)*2*x(2)];
endfunction
function y=newton(f,x,e)
  y=x+e+1;
  while abs(x-y)>e do
    y=x;
    J=numderivative(f,x);
    x=x-inv(J)*f(x);
  end
endfunction
