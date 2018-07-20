function d = b2d_ieee(b)
    s = (-1)**b(1)
    e = 0
    m = 1

    for i = 1:9 do
        e = e + b(i) * 2**(9-i)
    end

    for i = 10:32 do
        m = m + b(i) * 2**(9-i)
    end

    d = s * 2**(e-127) * m
endfunction

function b = d2b_ieee(d)
    e  = 127
    eb = []
    m  = []
    s  = d < 0

    while d / 2 > 1 do
        d = d / 2
        e = e + 1
    end

    while e >= 1 do
        eb = [modulo(e, 2) eb]
        e  = floor(e / 2)
    end

    d = d - 1
    for i = 1:23 do
        d = d * 2
        m = [m floor(d)]
        d = d - (d >= 1)
    end

    b = [s eb m]
endfunction
