

x1 = [0:99];
% x = 20*(x1/100) + 1 +sin( (4 * x1  + 7)* 2*pi/100 );
x = sin( (4 * x1  - (10 * pi))* 2*pi/100 );

Fs = length(x);
N = length(x);
xdft = fft(x); % fourier transform

%     p = unwrap(angle(xdft)); 

xdft = xdft(1:floor(N/2+1));
psdx = (1/(Fs*N)) * abs(xdft).^2;
psdx(2:end-1) = 2*psdx(2:end-1);
[m,idx] = max(psdx(2:end)); % find the maximum "spike"

p = unwrap(angle(xdft)); 

%     p = (angle(xdft(idx+1)) / (2 * pi)) * N;    % frame id for Phase
%     p = floor(abs(p));
%     p = mod(p,freqSize);

% a = 2.738 * 100
% b = total frame size / 4
% ans = mod(a,b)
    
freqSize = floor(N/idx);

Xaxis = 0:Fs/length(x):Fs/2;
plot(Xaxis,10*log10(psdx))
hold on
plot(Xaxis,p)

grid on
title('Periodogram Using FFT')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')