funcprot(0);
function y=l(xs,j,x)
  y=1;
  for i=1:length(xs)
    if i<>j then y=y*(x-xs(i))/(xs(j)-xs(i)); end
  end
endfunction
function y=lagrange(xs,ys,x)
  y=0;
  for j=1:length(xs)
    y=y+ys(j)*l(xs,j,x);
  end
endfunction
xs=[0 0.2 0.4 0.6];
ys=[1 1.2214 1.4918 1.8221];
function y=ddif(xs,ys)
  if length(ys)<=1 then
    y=ys(1);
  else
    y=(ddif(xs(2:$),ys(2:$))-ddif(xs(1:$-1),ys(1:$-1)))/(xs($)-xs(1));
  end
endfunction
function y=n(xs,j,x)
  y=1;
  for i=1:j-1
    y=y*(x-xs(i));
  end
endfunction
function y=newton(xs,ys,x)
  y=0;
  for j=1:length(xs)
    y=y+ddif(xs(1:j),ys(1:j))*n(xs,j,x);
  end
endfunction
function tabula()
  
endfunction
