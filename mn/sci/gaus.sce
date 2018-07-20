function y = regre(a, b)
  y = b
  for i = size(a, 1):-1:1 do
    y(i) = y(i) - a(i, i+1:$) * y(i+1:$)
    y(i) = y(i) / a(i, i)
  end
endfunction

function y = progre(a, b)
  y = b
  for i = 1:size(a, 1) do
    y(i) = y(i) - a(i, 1:i-1) * y(1:i-1)
    y(i) = y(i) / a(i, i)
  end
endfunction

function [l, u] = gausp(a)
  n = size(a, 1)
  l = eye(n, n)
  for i = 1:n do
    // reduccion
    for j = i+1:n do
      m = -a(j, i) / a(i, i)
      a(j, :) = m * a(i, :) + a(j, :)
      l(j, i) = -m
    end
  end
  u = a
endfunction
