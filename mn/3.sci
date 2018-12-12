funcprot(0);
function [M,c]=gauss(A,b)
  M=cat(2,A,b)
  for i=1:size(M,1)-1
    for j=i+1:size(M,1)
      if M(i,i)<>0 then
        M(j,:)=M(j,:)-M(i,:)*M(j,i)/M(i,i);
      end
    end
  end
  c=M(:,$)
  M=M(:,1:$-1)
endfunction
function x=regre(A,x)
  x(size(A,1))=x(size(A,1))/A(size(A,1),size(A,1));
  for i=size(A,1)-1:-1:1 do x(i)=(x(i)-A(i,i+1:$)*x(i+1:$))/A(i,i); end
endfunction
function x=progre(A,x)
  x=regre(A($:-1:1,$:-1:1),x($:-1:1))($:-1:1);
endfunction
function x=iter(f,n,x)
  for i=1:n do x=f(x); end
endfunction
function y=e7(x)
  y=4*%pi^2/(245*tanh(4*x));
endfunction
