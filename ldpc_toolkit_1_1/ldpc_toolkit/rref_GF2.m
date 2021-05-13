function [b]=rref_GF2(A)
%convert to reduced row echelon form over GF(2)
%[b]=rref_GF2(A)
%For examples and more details, please refer to the LDPC toolkit tutorial at
%http://arun-10.tripod.com/ldpc/ldpc.htm 
dim=size(A);
rows=dim(1);
cols=dim(2);

   for i=1:rows
      if A(i,i)==0
         k=i+1;
         if k<cols
         	%while A(rows,k)==0
             while A(i,k)==0
               k=k+1;
            	if k==cols
               	break
            	end
         	end 
         	%if k~=cols
         		temp=A(1:rows,k);
         		A(1:rows,k)=A(1:rows,i);
            	A(1:rows,i)=temp;
         	%end
         end
      end
      %for j=1:rows
       %  if j~=i
        %    if A(j,i)==1
         %      A(j,1:cols)=xor(A(i,1:cols),A(j,1:cols));
          %  end 
         %end
     % end
      A;

end   

for i=1:rows
   if A(i,i)~=1
      i
   end
end


   b=A;