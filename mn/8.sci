funcprot(0);
function i=trap(a,b,f); i=(b-a)*(f(a)+f(b))/2; endfunction
function i=simpson(a,b,f); i=(b-a)/6*(f(a)+4*f((a+b)/2)+f(b)); endfunction
function i=aux(g,a,b,f,n)
  i=0;
  st=(b-a)/n;
  for j=a:st:b; i=i+g(j,j+st,f); end
endfunction
function i=trap_c(a,b,f,n); i=aux(trap,a,b,f,n); endfunction
function i=simpson_c(a,b,f,n); i=aux(simpson,a,b,f,n); endfunction

function y=a(x); y=1/x; endfunction
function y=b(x); y=sqrt(x*(1+x^2)); endfunction
function y=c(x); y=x*sin(x); endfunction
function y=d(x); y=x^3; endfunction
function y=e(x); y=sin(%pi*x); endfunction
function y=f(x); y=x^2*%e^x; endfunction
