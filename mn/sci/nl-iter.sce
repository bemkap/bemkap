function x0 = biseccion(f, a, b, e, u)
  while abs(a-b) >= e & u > 0 do
    c = (a+b)/2
    if     f(a)*f(c) < 0 then b = c
    elseif f(c)*f(b) < 0 then a = c
    else   break
    end
    u = u-1
  end
  if (u == 0) then printf("fue..\n"), end
  x0 = c
endfunction

function x0 = secante(f, a, b, e, u)
  while abs(a-b) >= e & u > 0 do
    t = a
    a = b
    b = b-f(b)*(b-t)/(f(b)-f(t))
    u = u-1
  end
  if (u == 0) then printf("fue..\n"), end
  x0 = b
endfunction

function x0 = falsa(f, a, b, e, u)
  while abs(a-b) >= e & u > 0 do
    c = b-f(b)*(b-a)/(f(b)-f(a))
    if     f(a)*f(c) < 0 then b = c
    elseif f(c)*f(b) < 0 then a = c
    else   break
    end
    u = u-1
  end
  if (u == 0) then printf("fue..\n"), end
  x0 = c
endfunction

function x0 = nwtn(f, x, e, u)
  t = x
  x = x-1/(derivative(f, x))*f(x)
  while norm(t-x) > e & u > 0 do
    t = x
    x = x-1/(derivative(f, x))*f(x)
    u = u-1
  end
  if (u == 0) then printf("fue..\n"), end
  x0 = x
endfunction
