function [H]=gen_ldpc(rows,cols)
%H=gen_ldpc(rows,cols)
%For examples and more details, please refer to the LDPC toolkit tutorial at
%http://arun-10.tripod.com/ldpc/ldpc.htm 
bits_per_col=3;
for i=1:rows
   row_flag(i)=0;
   for j=1:cols
      parity_check(i,j)=0;
   end
end
%add bits_per_col 1's to each column with the only constraint being that the 1's should be
%placed in distinct rows
for i=1:cols
   a=randperm(rows);
   for j=1:bits_per_col
      parity_check(a(j),i)=1;
      row_flag(a(j))=row_flag(a(j))+1;
   end
end
row_flag;
max_ones_per_row=ceil(cols*bits_per_col/rows);
parity_check;


%add 1's to rows having no 1(a redundant row) or only one 1(that bit in the codeword becomes
%zero irrespective of the input)
for i=1:rows
   if row_flag(i)==1
      j=unidrnd(cols);
      while parity_check(i,j)==1
         j=unidrnd(cols);
      end
      parity_check(i,j)=1;
      row_flag(i)=row_flag(i)+1;
   end
   if row_flag(i)==0
     for k=1:2 
      	j=unidrnd(cols);
      	while parity_check(i,j)==1
         	j=unidrnd(cols);
      	end
      	parity_check(i,j)=1;
         row_flag(i)=row_flag(i)+1;
      end
   end
end



%try to distribute the ones so that the number of ones per row is as uniform as possible

for i=1:rows
   j=1;
   a=randperm(cols);
   while row_flag(i)>max_ones_per_row;
       if parity_check(i,a(j))==1
            parity_check(i,a(j))=0;
            row_flag(i)=row_flag(i)-1;
            newrow=unidrnd(rows);
            k=0; 
            while row_flag(newrow)>=max_ones_per_row | parity_check(newrow,a(j))==1
               newrow=unidrnd(rows);
               k=k+1;
               if k>=rows
                  break;
               end
            end
            if parity_check(newrow,a(j))==0
               parity_check(newrow,a(j))=1;
               row_flag(newrow)=row_flag(newrow)+1;
            else
               parity_check(i,a(j))=1;
               row_flag(i)=row_flag(i)+1;
            end
        end%if loop
         j=j+1;
   end%while loop
end%for loop

row_flag;

parity_check;

parity_check;
%try to eliminate cycles of length 4 in the factor graph
for loop=1:10
ones_position(1)=0;
for r=1:rows
   ones_count=0;
   for c=1:cols
      if parity_check(r,c)==1
         ones_count=ones_count+1;
         ones_position(ones_count)=c;
      end
   end
   for i=1:r-1
     common=0;
      for j=1:ones_count
         if parity_check(i,ones_position(j))==1
            common=common+1 ;   
            if common==1
               thecol=ones_position(j);
            end
         end
         if common==2
            common=common-1;
            if(round(rand)==0)
               coltoberearranged=thecol;
               thecol=ones_position(j);
            else               
               coltoberearranged=ones_position(j);
            end
            parity_check(i,coltoberearranged)=3; %make this entry 3 so that we dont use 
                                                 %of this entry again while getting rid 
                                                 %of other cylces  
            newrow=unidrnd(rows);
            %while ((newrow==i)|(parity_check(newrow,ones_position(j))==1))
            iteration=0;
            while parity_check(newrow,coltoberearranged)~=0
               newrow=unidrnd(rows);   
               iteration=iteration+1;
               if iteration==5
                  break;
               end
            end
            if iteration==5
               while parity_check(newrow,coltoberearranged)==1
                  newrow=unidrnd(rows);
               end
            end
            parity_check(newrow,coltoberearranged)=1;
         end
      end
   end

   for i=r+1:rows
      common=0;
      for j=1:ones_count
         if parity_check(i,ones_position(j))==1
            common=common+1 ;  
            if common==1
               thecol=ones_position(j);
            end
         end
         if common==2
            common=common-1;
            if(round(rand)==0)
               coltoberearranged=thecol;
               thecol=ones_position(j);
            else               
               coltoberearranged=ones_position(j);
            end
            parity_check(i,coltoberearranged)=3;%make this entry 3 so that we dont use 
                                                 %of this entry again while getting rid 
                                                 %of other cylces 
            newrow=unidrnd(rows);
            %while ((newrow==i)|(parity_check(newrow,ones_position(j))==1))
            iteration=0;
            while parity_check(newrow,coltoberearranged)~=0
               newrow=unidrnd(rows);
               iteration=iteration+1;
               if iteration==5
                  break
                end
             end
             if iteration==5
               while parity_check(newrow,coltoberearranged)==1
                  newrow=unidrnd(rows);
               end
            end
            parity_check(newrow,coltoberearranged)=1;
         end
      end
   end   
end
end;
parity_check;

for i=1:rows
   row_flag(i)=0;
   for j=1:cols
      if parity_check(i,j)==1
            row_flag(i)=row_flag(i)+1;
      end  
      if eq(parity_check(i,j),3) %replace the 3's with 0's
         parity_check(i,j)=0;
      end
   end
end

variance=var(row_flag)
H=parity_check;
%Get the Parity Checks

%A=0;
%B=0;
%for i=1:rows
%   for j=1:rows
%      A(i,j)=parity_check(i,j);
%   end
%end
%for i=1:rows
%   for j=rows+1:cols
%      B(i,j-rows)=parity_check(i,j);
%   end
%end
%ainvb=inv(sparse(A))*sparse(B);
%ainvb=inv(A)*B;
%toc