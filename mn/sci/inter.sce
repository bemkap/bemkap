function y = lagra(p, x) // p: [x0 y0; x1 y1; ...]
  y = 0
  for i = 1:size(p, 1) do
    l = p
    
    l(i, 1) = x - 1
    n = prod(x - l(1:$, 1))
    
    l(i, 1) = p(i, 1) - 1
    d = prod(p(i, 1) - l(1:$, 1))
    
    y = y + n/d * p(i, 2)
  end
endfunction

function y = dif_div(p)
  n = size(p, 1)
  if n == 1 then
    y = p(1, 2)
  else
    y = dif_div(p(2:$, :)) - dif_div(p(1:$-1, :))
    y = y / (p(n, 1) - p(1, 1))
  end
endfunction

function y = nwtn(p, x) // p: [x0 y0; x1 y1; ...]
  y = p(1, 2)
  for i = 2:size(p, 1) do
    y = y + prod(x - p(1:i-1, 1)) * dif_div(p(1:i, :))
  end
endfunction

function p = T(n, x)
  if     n == 0 then p = 1
  elseif n == 1 then p = x
  else   p = 2 * x * T(n-1, x) + T(n-2, x)
  end
endfunction

// error
// f(x) - Pn(x) = 1/(n+1)! * (x-x0)(x-x1)...(x-xn) * f(n+1)(c)