function [syms] = Encoder(bits, nlevels)

L  = nlevels;   
l  = log2(L);    
[~,map] = bin2gray(1,'pam',L); 



blocks   = buffer(bits,l,0); 
bits2dec = bi2de(blocks', 'left-msb'); 

LA   = -L+1:2:L-1;  
syms = bits2dec;

for g = 0:L-1 
i = find(map==g);
syms(bits2dec==g) = LA(i);
 end
end