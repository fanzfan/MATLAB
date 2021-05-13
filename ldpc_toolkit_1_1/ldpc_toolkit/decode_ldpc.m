function [vhat]=decode_ldpc(rx_waveform,No,amp,h,scale)
%[vhat]=decode_ldpc(rx_waveform,No,amp,h,scale)
%For examples and more details, please refer to the LDPC toolkit tutorial at
%http://arun-10.tripod.com/ldpc/ldpc.htm 
dim=size(h);
rows=dim(1);
cols=dim(2);

vhat(1,1:cols)=0;

zero(1,1:rows)=0;

s=struct('qmn0',0,'qmn1',0,'dqmn',0,'rmn0',0,'rmn1',0,'qn0',0,'qn1',0,'alphamn',1);
%associate this structure with all non zero elements of h

%Prior Probabilities
for i=1:length(rx_waveform)
   pl1(i)=1/(1+exp(-2*amp*rx_waveform(i)*scale(i)/(No/2)) );
   pl0(i)=1-pl1(i);
end

%initialization
for i= 1:rows
   for j=1:cols
      newh(i,j)=s;
      if h(i,j)==1
         newh(i,j).qmn0=pl0(j);
         newh(i,j).qmn1=pl1(j);
      end
   end
end

for iteration=1:1000
	%horizontal step
	for i=1:rows
   	ones_in_row=0;
   	index=1;
   	for j=1:cols
      	if h(i,j)==1
         	ones_in_row(index)=j;
         	index=index+1;
         	newh(i,j).dqmn=newh(i,j).qmn0 -newh(i,j).qmn1;
     	   end
   	end
   	for j=1:index-1
      	drmn=1;
      	for k=1:index-1
         	if k~=j
            	drmn=drmn*newh(i,ones_in_row(k)).dqmn;
         	end
      	end
   		newh(i,ones_in_row(j)).rmn0=(1+drmn)/2;   
      	newh(i,ones_in_row(j)).rmn1=(1-drmn)/2;   
   	end
	end


	%vertical step
	for j=1:cols
   	ones_in_col=0;
   	index=1;
   	for i=1:rows
      	if h(i,j)==1
         	ones_in_col(index)=i;
         	index=index+1;
      	end
   	end
   	for i=1:index-1
      	prod_rmn0=1;
      	prod_rmn1=1;
      	for k=1:index-1
         	if k~=i
            	prod_rmn0=prod_rmn0*newh(ones_in_col(k),j).rmn0;
            	prod_rmn1=prod_rmn1*newh(ones_in_col(k),j).rmn1;
         	end
      	end 
      	const1=pl0(j)*prod_rmn0;
      	const2=pl1(j)*prod_rmn1;
      	newh(ones_in_col(i),j).alphamn=1/( const1 + const2 ) ;   
   		newh(ones_in_col(i),j).qmn0=newh(ones_in_col(i),j).alphamn*const1;   
      	newh(ones_in_col(i),j).qmn1=newh(ones_in_col(i),j).alphamn*const2;
      	%update pseudo posterior probability
      	const3=const1*newh(ones_in_col(i),j).rmn0;
      	const4=const2*newh(ones_in_col(i),j).rmn1;
      	alpha_n=1/(const3+const4);
      	newh(ones_in_col(i),j).qn0=alpha_n*const3;   
         newh(ones_in_col(i),j).qn1=alpha_n*const4;
         %tentative decoding
         if newh(ones_in_col(i),j).qn1>0.5
            vhat(j)=1;
         else
            vhat(j)=0;
         end         
    	end
	end
   iteration;
   if mul_GF2(vhat,h.')==zero
      break;
   end

end

%decoding
