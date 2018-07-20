function y = aux(x, n) // x > 0
    i = 0
    while x < 10**n do
        i = i+1
        x = x*10
    end
    x = floor(x)
    y = [i x]
endfunction

function y = truncar(x, n)
    s = (-1)**(x < 0)
    j = aux(abs(x), n-1)
    y = s*j(2)/10**j(1)
endfunction

function y = redo(x, n)
    s = (-1)**(x < 0)
    j = aux(abs(x), n)
    d = modulo(j(2), 10)>5
    y = s*(floor(j(2)/10)+d)/10**(j(1)-1)
endfunction

function y = err_abs(x, n)
    y = abs(x-redo(x, n))    
endfunction

function y = err_rel(x, n)
    y = err_abs(x, n)/abs(x)
endfunction
