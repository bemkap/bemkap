funcprot(0);
function [L,U]=doolittle(A)
  U=zeros(A); L=eye(A);
  U(1,:)=A(1,:);
  L(:,1)=A(:,1)/U(1,1);
  for k=2:size(A,1) do
    for m=k:size(A,1) do U(k,m)=A(k,m)-L(k,1:k-1)*U(1:k-1,m); end
    for i=k+1:size(A,1) do L(i,k)=(A(i,k)-L(i,1:k-1)*U(1:k-1,k))/U(k,k); end
  end
endfunction
function [x,i]=seidel(A,b,x,e)
  i=0;
  N=triu(A);
  P=N-A;
  M=inv(N)*P;
  c=inv(N)*b;
  while norm(A*x-b,"inf")>e do
    x=M*x+c;
    i=i+1;
  end
endfunction
function [x,i]=sor(A,b,x,e,w)
  i=0;
  while norm(A*x-b,"inf")>e do
    for i=1:size(x,1) do
      s=b(i);
      for j=1:i-1 do
        s=s-A(i,j)*x(j);
      end
      for j=i+1:size(x,1) do
        s=s-A(i,j)*x(j);
      end
      s=s*w/A(i,i);
      x(i)=s+(1-w)*x(i);
    end
    i=i+1;
  end
endfunction
function w=best(A)
  w=2/(1+sqrt(1-max(abs(spec(eye(A).*A)))^2));
endfunction
function [x,i]=jacobi(A,b,x,e)
  i=0;
  D=A.*eye(A);
  R=A-D;
  Di=inv(D);
  while norm(A*x-b,"inf")>e do
    x=Di*(b-R*x);
    i=i+1;
  end
endfunction
function [A,b]=crt(n)
  A=8*eye(n,n)+2*diag(ones(n-1,1),1)+2*diag(ones(n-1,1),-1)+diag(ones(n-3,1),3)+diag(ones(n-3,1),-3);
  b=ones(n,1);
endfunction
A=[4 3 0;3 4 -1;0 -1 4];
b=[24 30 -24]';
