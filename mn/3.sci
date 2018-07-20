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
function x=regre(A,b)
    x=b;
    for i=size(A,1):-1:1
        x(i)=(x(i)-A(i,i+1:$)*x(i+1:$))/A(i,i);
    end
endfunction
A=[1 1 0 3;2 1 -1 1;3 -1 -1 2;-1 2 3 -1];
B=[1 -1 2 -1;2 -2 3 -3;1 1 1 0;1 -1 4 3];
C=[1 1 0 4;2 1 -1 1;4 -1 -2 2;3 -1 -1 2];
b=[4;1;-3;4];
