clear all
close all
clc
fs=10000; % sampling frequency
f0=3000; % carrier frequency
Br=500; % Bit rate
Bs=Br; % symbol rate
Ns = 100000; % Number of simulated symbols/bits
nsps=fs/Bs; % oversampling factor (number of samples per symbol)
dt=1/fs; % sampling time
%******************* Initialize the coefficients of the receiver’s filter
% the receiver’s filter must be matched to the TX pulse
h=ones(1,nsps); % Rect impulse response
DelayFilter=nsps/2;
% *** Run a Monte Carlo simulation for 10 different values of SNR
index=1;
for EbN0=1:10 % EbNo cycle
%******************** START MONTE CARLO SIMULATION *********************
%******************** Generation of transmitted bits ***********
TXdata=BinarySource(Ns);
symbols=Encoder(TXdata,2); % binary transmission
%******************** BPSK Modulation (PAM) ***********************
% generate a PAM signal with RECT pulses
[x,DelayPAM]=PAMmodulator(symbols,nsps,'RECT');
% ** vector "pamsignal" contains the sampled version of the PAM signal
% construct the in-phase e quadrature components
Xi=real(x);
Xq=imag(x); % actualy this is zero in binary case
s=ModQAM(Xi,Xq,f0,fs); % modulated signal

%****************** Channel *****************
% insert here possible channel model (e.g., fading)
sr=s; % ideal channel
%************ AWGN ***************
P=sum(sr.*sr)*dt/(Ns*nsps*dt); % measure the mean received power
Eb=P/Br; % mean received energy
% sigman^2=N0*fs/2; % noise power
% compute the noise power per via to meet the required EbNo
sigman=sqrt(Eb*fs/2*10.^(-EbN0/10));
% generate the Gaussian noise
noise=randn(1,length(sr)).*sigman;
r=sr+noise; % add the noise to the received signal
%************ RX matched filter **************
[ri,rq,DelayQAM]=DeModQAM(r,f0,fs); % demodulate the signal
r=ri+1i*rq;
y=conv(r,h)/nsps; % receiver (matched) filter
% ********** Sampling ******************
% compute the overall delay introduced by the TX and RX filters
delay=DelayPAM+DelayQAM+DelayFilter;
% sample the signal every symbol time accounting for the delay
yk = y(delay:nsps:nsps*Ns+delay-1);
%******************** Binary detection ********************
RXdata=real(yk) > 0; % take only the real part
%******************** Bit Error Rate (BER) estimate ******************
noe=sum(abs(TXdata-RXdata)); % Errors count
nod=length(TXdata);
SNRdB(index)=EbN0;
ber(index)=noe/nod; % Estimate the BER
fprintf('EbNo=%.1f (dB) BER=%g\n',SNRdB(index),ber(index));
index=index+1;
end
% **************** Plot BER vs EbN0 ************************
figure
semilogy(SNRdB,ber);
xlabel('EbNo (dB)');

ylabel('BER');
grid on
% **************** Plot Spectrum ************************
figure
PlotSpectrum(s,fs);
% **************** Plot Constellation ************************
% plot only the sampling instants
x=real(yk);
y=imag(yk);
figure
plot(x,y,'o'), axis ([-2 2 -2 2]);
title('Constellation');
xlabel('In-Phase');
ylabel('In-Quadrature');