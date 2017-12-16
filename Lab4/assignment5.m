
% Question 1
[y,Fs] = audioread('corrupted_voice.wav');
F = fftshift(abs(fft(y)));
f = linspace(-Fs/2, Fs/2, numel(y)+1);
f(end) = [];    
plot(f, F);

% Question 2
% values 200 and 1500 found by looking at the plot (zooming)
n = 3;
beginFreq = 200 / (Fs/2);
endFreq = 1500 / (Fs/2);
[b,a] = butter(n, [beginFreq, endFreq], 'bandpass');
fOut = filtfilt(b, a, y);
audiowrite('voice.wav', real(fOut), Fs);
