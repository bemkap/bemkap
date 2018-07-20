function a = coef(x, y, gr)
  a = zeros(gr, gr+1)
  for i = 1:gr do
    for j = 1:gr do
      a(i, j) = x' .^ (j-1) * x .^ (i-1)
    end
    a(i, gr+1) = y' * x .^ (i-1)
  end
endfunction

function as = cua(x, y, gr)
  a      = coef(x, y, gr)
  [l, u] = gausp(a(:, 1:$-1))
  as     = regre(u, progre(l, a(:, $)))
endfunction 
