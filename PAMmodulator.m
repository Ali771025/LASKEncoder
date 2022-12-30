function [x, Delay] = PAMmodulator(symbols, nsps, pulsetype)
%%Generating symbol sequence
N=length(symbols);
M=N*nsps;
xn=zeros(1,M);
xn(1:nsps:M)=symbols;
%%Generating pulse shapes
switch pulsetype
    case 'RECT'

        h=ones(1,nsps);
    case 'DIRAC'
        h=zeros(1,nsps);
        h(1)=1;
    case 'SINC'
        h = sinc (linspace(-2, 2, nsps));
end
%%Modulation and Delay
Delay=length(h)/2;
x=conv(xn, h);
end
