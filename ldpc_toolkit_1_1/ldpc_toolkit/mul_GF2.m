function [c]=mul_GF2(A,B)
%[c]=mul_GF2(A,B)
%For examples and more details, please refer to the LDPC toolkit tutorial at
%http://arun-10.tripod.com/ldpc/ldpc.htm
dim=size(A);
m=dim(1);%no of rows of the first matrix
n=dim(2);%no of cols of the first matrix and no of rows of 2nd matrix
dim=size(B);
p=dim(2);%no of cols of the second matrix

for i=1:m
   for j=1:p
      temp1=A(i,1:n);
      temp2=B(1:n,j);
      prod=temp1.*(temp2.');
      sum1=0;
      for k=1:n
         sum1=xor(sum1,prod(k));
      end
      c(i,j)=sum1;
   end
end

         
