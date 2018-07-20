function i = trap(a, b, n, f)
  h = (b-a)/n
  i = f(a)/2 + f(b)/2

  for k = a+h:h:b-h do
    i = i + f(k)
  end

  i = h * i
endfunction

function i = homero(a, b, n, f)
  h = (b-a)/n
  i = f(a) + f(b)
  m = 4

  for k = a+h:h:b-h do
    i = i + m*f(k)
    if m == 2 then m = 4
    else m = 2
    end
  end    

  i = h/3 * i
endfunction

function y = a(x), y = 1/x            ,	endfunction
function y = c(x), y = x*(1+x^2)^(1/2), endfunction
function y = e(x), y = x*sin(x)       ,	endfunction
function y = b(x), y = x^3            ,	endfunction
function y = d(x), y = sin(%pi*x)     ,	endfunction
function y = f(x), y = x^2*%e^x       ,	endfunction

function y = z(x), y = (x+1)^(-1)     , endfunction