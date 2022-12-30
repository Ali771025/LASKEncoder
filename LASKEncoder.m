function [sym,gtable]= LASKEncoder (bits,nlevels)
nlevels= 16
k=log2(16); %bits per symbol
n=length(bits)/k; %number of symbols
%% creating Graycoding table
[Y,map]=bin2gray(0:nlevels-1,'pam',nlevels);
bmap=dec2base(map,2,k);
gtable=zeros(nlevels,k);
for i=1:nlevels
    gtable(i,1:k)=sprintf('%s',bmap(i,:))-'0';
end
%%Creating symbols matrix
for i=1:nlevels
ys(i)=-nlevels+(2*i-1);
end
%%Turning bits to symbols
y=zeros(n,k);
for i=1:n

    y(i,:)= bits(1+(i-1)*k:i*k);
end
sym=zeros(1,n);
for i=1:n

    for j=1:nlevels
    if y(i,:)==gtable(j,:)
       sym(1,i)=ys(j);
    else
    end
    end
end
end
