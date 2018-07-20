function h = horn (a, x0) // a vector de coeficientes [a_n a_n+1 ... a_0]
  h = 0
  for i = a do
    h = h*x0+i
  end
endfunction

function h = dhorn (a, x0) // a vector de coeficientes [a_n a_n+1 ... a_0]
  h1 = 0
  h2 = 0
  for i = a(1:$-1) do
    h1 = h1*x0+i
    h2 = h2*x0+h1
  end
  h = [h1*x0+a($) h2]
endfunction

function y = df_der (f, v, n)
  s1 = '1'
  deff ('y = df1(x)', 'y = derivative(f,v)')
  for i = 2:n do
    s1 = string(i)
    s2 = string(i-1)
    deff ('y = df'+s1+'(x)', 'y = derivative(df'+s2+', x)')
  end
  y = eval('df'+s1+'(v)')
endfunction
  
function y = df_inc (f, v, n, h)
  s1 = '1'
  deff ('y = df1(x)', 'y = (f(x+h)-f(x))/h')
  for i = 2:n do
    s1 = string(i)
    s2 = string(i-1)
    deff ('y = df'+s1+'(x)', 'y = (df'+s2+'(x+h)-df'+s2+'(x))/h')
  end
  y = eval('df'+s1+'(v)')
endfunction

function m = fact (n)
  m = 1
  for i = 2:n do m = m*i, end
endfunction

function p = taylor (f, n, x, a)
  p = f(a)
  for i = 2:n do
    p = p+df_inc(f, a, i, 1D-8)/fact(i)*(x-a)^i
  end
endfunction