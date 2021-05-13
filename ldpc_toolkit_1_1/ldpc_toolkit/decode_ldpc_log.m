function [vhat,iteration]=decode_ldpc(rx_waveform,No,amp,h,scale)
%[vhat]=decode_ldpc(rx_waveform,No,amp,h,scale)
%For examples and more details, please refer to the LDPC toolkit tutorial at
%http://arun-10.tripod.com/ldpc/ldpc.htm 
dim=size(h);
rows=dim(1);
cols=dim(2);

vhat(1,1:cols)=0;

zero(1,1:rows)=0;

prevhat(1:cols)=1;

s=struct('alpha_mn',0,'beta_mn',0,'gamma_mn',0);
%associate this structure with all non zero elements of h



%Initialization : set gamma_n to log-likelyhood ratios for every code bit and then initialize the alpha_mns for
% all non -zero elements of the parity_check matrix
for j=1:cols
   gamma_n(j)=(4/No)*rx_waveform(j);
   temp=exp(-abs(gamma_n(j)));
   for i=1:rows
      if (h(i,j)==1)
         newh(i,j)=s;
         newh(i,j).alpha_mn=sign(gamma_n(j))*log((1+temp)/(1-temp));  			       
      end
   end   
end

for iteration=1:100
	%%%%%%%%%%%begin horizontal step%%%%%%%%%%%%%%%%%%%%%%5
	for i=1:rows
      prod_of_alpha_mn=1;
      sum_of_alpha_mn=0;
   	for j=1:cols
         if h(i,j)==1
            for k=1:cols
               if ((h(i,j)==1)&(j~=k))
                  prod_of_alpha_mn=prod_of_alpha_mn*newh(i,j).alpha_mn;
                  sum_of_alpha_mn=sum_of_alpha_mn+abs(newh(i,j).alpha_mn);
               end               
            end
            temp=exp(-sum_of_alpha_mn);
            newh(i,j).beta_mn=sign(prod_of_alpha_mn)*log((1+temp)/(1-temp));
         end
      end
   end
   %%%%%%%%%%%%%%end horizontal step%%%%%%%%%%%%%%%%%%%%%%%%
   
   
   %%%%%%%%%%%%%%%begin vertical step%%%%%%%%%%%%%%%%%
   for j=1:cols         
      sum_of_beta_mn=0;
      for i=1:rows
         if (h(i,j)==1)
         	sum_of_beta_mn=sum_of_beta_mn+newh(i,j).beta_mn;   
         end         
      end
      
      for i=1:rows
         newh(i,j).gamma_mn=gamma_n(j)+sum_of_beta_mn-newh(i,j).beta_mn;
         temp=exp(-abs(newh(i,j).gamma_mn));
         newh(i,j).alpha_mn=sign(newh(i,j).gamma_mn)*log((1+temp)/(1-temp));
      end
      
      %%%%%%calculate pseudo log APP ratios
      lambda_n(j)=gamma_n(j)+sum_of_beta_mn;
      if lambda_n(j)>=0
            vhat(j)=0;
         else
            vhat(j)=1;
         end 
   end
   %%%%%%%%%%%%%%%%%%%end vertical step%%%%%%%%%
   %%%%%%%%%%stop if v.hat'=0 or if u get the same codeword 20 consequtive times
  iteration;
  if prevhat==vhat
      converge=converge+1;
   else
      converge=0;
      prevhat=vhat;
   end
   
   if mul_GF2(vhat,h.')==zero
      break;
   end
   
   if converge==20
      break
   end
end

%decoding
