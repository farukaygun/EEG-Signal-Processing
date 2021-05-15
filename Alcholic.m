clc;
clear all;

Fs = 256;
Ts = 1/Fs;
t = 0:Ts:1;

data = readmatrix("SMNI_CMI_TRAIN/Data288.csv");
A = data(1:257, 5);

X = fft(A);
f = linspace(0, Fs, length(X));

figure('Name','FFT of Alcoholic Human''s Signal ','NumberTitle','off')

subplot(3,1,1)
plot(X, 'o')
xlabel('Re');
ylabel('Im');
title('Fourier coefficients in the complex plane')

n = floor(length(f)/2);

subplot(3,1,2)
plot(f(1:n), abs(X(1:n)))
xlabel('Frekans (Hz)')
title('The magnitude of the Fourier coefficients ')

subplot(3,1,3)
P = X.*conj(X)/n;
plot(f, P)
xlabel('Frekans (Hz)')
title('Power Spectrum density ')

fil = bandpass(A, [13, 29], Fs);

figure('Name','Alcoholic Human''s EEG signal','NumberTitle','off')

subplot(2,1,1)
plot(t, A)
xlabel('Time(sec)')
ylabel('Amplitude')
title('Raw EEG Signal')

subplot(2,1,2)
plot(t, fil, 'r')
xlabel('Time(sec)')
ylabel('Amplitude')
title('Filtered EEG Signal')

figure('Name','Filtered Healthy Human Signal','NumberTitle','off')
bandpass(A, [13, 29], Fs);
