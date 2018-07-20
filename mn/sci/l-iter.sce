// metodo general

function y = iter_g(a, x, b, e, n, fi) // fi(a, x, b, n): 1 iteracion
  y = fi(a, x, b, n)
  while norm(x-y, "inf") >= e do
    x = y
    y = fi(a, y, b, n)
  end
endfunction

// jacobi

function y = jiter(a, x, b, n)
  y = (n-a)*x+b
  for i = 1:size(a, 1) do
    y(i) = y(i)/n(i, i)
  end
endfunction

function y = jaco(a, x, b, e)
  y = iter_g(a, x, b, e, eye(a).*a, jiter)
endfunction

// gauss-seidel

function y = giter(a, x, b, n)
  y = (n-a)*x+b
  y = progre(a, y)
endfunction

function y = seid(a, x, b, e)
  y = iter_g(a, x, b, e, tril(a), giter)
endfunction

// sor

function y = siter(a, x, b, w)
  d = eye(a).*a
  l = tril(a)-d
  u = triu(a)-d
  y = ((1-w)*d-w*u)*x+w*b
  y = progre(d+w*l, y)
endfunction
    
function y = sor(a, x, b, w, e)
  y = iter_g(a, x, b, e, w, siter) // w no es matriz pero funciona igual
endfunction
