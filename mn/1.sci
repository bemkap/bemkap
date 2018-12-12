funcprot(0);
function xs=raices(p)
    a=coeff(p,2);
    b=coeff(p,1);
    c=coeff(p,0);
    if b<0 then
        xs(1)=2*c/(-b+sqrt(b^2-4*a*c));
        xs(2)=(-b+sqrt(b^2-4*a*c))/(2*a);
    else
        xs(1)=(-b-sqrt(b^2-4*a*c))/(2*a);r
        xs(2)=2*c/(-b-sqrt(b^2-4*a*c));
    end
endfunction
p=poly([-0.0001 10000.0 0.0001],"x","coeff");
