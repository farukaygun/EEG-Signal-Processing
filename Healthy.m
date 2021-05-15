% sampling frequency(f) = 256 Hz for 1 sec (3.9msec epoch) 
% period(T) = 3.90625 msec - 0.0039 sec

clc;
clear all;

% Sinyal info
Fs = 256; % sampling rate
Ts = 1/Fs; % sampling period as sec
t = 0:Ts:1; % time vector

% dataset
% read signal
% read sensor value from csv file.
data = readmatrix("SMNI_CMI_TRAIN/Data1.csv"); % sağlıklı insan 
A = data(1:257, 5); % Genlik

% FFT
X = fft(A);
f = linspace(0, Fs, length(X)); % Frequency vector

% plotting the FFT of the signal 
% Fourier coefficients in the complex plane 
figure('Name','FFT of the Healthy Human''s Signal','NumberTitle','off')

subplot(3,1,1)
plot(X, 'o')
xlabel('Re');
ylabel('Im');
title('Fourier coefficients in the complex plane')

% Since the signal is difficult to read in the complex plane, 
% we take the magnitude of the signal and draw it again. 
% Recall that a Fourier transform reveals the frequency components within a signal. 
% Note that the part after fs / 2 is a mirror image of the previous part. 
% Therefore, we only need to see the part of [0, Fs / 2], the other part does not contain extra information. 

% In case the length of the vector is not an integer, we rounded the result. 
n = floor(length(f)/2);

% The magnitude of the Fourier coefficients 
subplot(3,1,2)
plot(f(1:n), abs(X(1:n)))
xlabel('Frequency (Hz)')
title('The magnitude of the Fourier coefficients')

% Power Spectrum density 
subplot(3,1,3)
P = X.*conj(X)/n;
plot(f, P)
xlabel('Frekans (Hz)')
title('Power Spectrum density ')

% Bandpass filter

% Beta waves in EEG signals indicate the activity of humans, 
% let's set the lower limit of the filter to be 13 Hz. 
% The FFT signal does not contain information after 50 Hz in the frequency domain, 
% let's set the upper limit of it as 50 Hz. 
fil = bandpass(A, [13, 50], Fs);

figure('Name','Healthy Human EEG signal','NumberTitle','off')

% Ham EEG Sinyali
subplot(2,1,1)
plot(t, A)
xlabel('Time(sec)')
ylabel('Amplitude')
title('Raw EEG Signal')

% Filtrelenmiş EEG Sinyali
subplot(2,1,2)
plot(t, fil, 'r')
xlabel('Time(sec)')
ylabel('Amplitude')
title('Filtered EEG Signal')

figure('Name','Filtered Healthy Human Signal','NumberTitle','off')
bandpass(A, [13, 50], Fs);
