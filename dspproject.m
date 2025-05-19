function plot_spectrum(signal, Fs, windowing)
 % This function plots the PSD of a real signal (single sided spectrum)
 Nfft = 2^10; % FFT size used in the spectrum analyzer
 percentage_overlap = 0.5; % 50% overlap between segments
 window_length = Nfft; % length of each segment (can be <= NFFT)
 
 switch windowing
 case 1 
   kaiser_beta = 7;
   window = kaiser(window_length, kaiser_beta);
 case 2 
   window = ones(window_length, 1);
 case 3 
   window = hann(window_length);
 case 4 
   window = hamming(window_length);
 otherwise
   error('Invalid windowing option. Use 1=Kaiser, 2=Rectangular, 3=Hanning, 4=Hamming.');
 end
 
 PSD = pwelch(signal, window, percentage_overlap * window_length, Nfft, Fs);
 Freq = 0:Fs/Nfft:Fs/2;
 Freq = Freq * 1e-3; % Convert to kHz
 figure; plot(Freq, 10*log10(PSD), 'LineWidth', 1.5);
 grid on;
 xlabel('Frequency (KHz)');
 ylabel('PSD (dB/Hz)');
 switch windowing
 case 1 
    title(['PSD with ', 'kaiser window']);
 case 2 
   title(['PSD with ', 'rectangular  window']);
 case 3 
   title(['PSD with ', 'hanning window']);
 case 4 
   title(['PSD with ', 'hamming window']);
 otherwise
   error('Invalid windowing option. Use 1=Kaiser, 2=Rectangular, 3=Hanning, 4=Hamming.');
 end
end

[audio_data, Fs] = audioread('music_test_fayrouz.mp3');
audio_length = length(audio_data);

% Extract 3 seconds from the middle
mid_index = floor(audio_length / 2);
samples_3s = round(3 * Fs);
start_index = mid_index - floor(samples_3s / 2);
end_index = start_index + samples_3s - 1;
audio_clip = audio_data(start_index:end_index, :); 

% audiowrite('audio_beforeI.wav', audio_clip, Fs);

% Create vector t
t = (0:length(audio_clip)-1) / Fs;

% Plot the audio signal without interference
figure;
plot(t, audio_clip(:,1), 'b'); 
xlabel('Time (s)');
ylabel('Amplitude');
title('The 3-sec Audio Signal');
grid on;

%Sinosuidal interference
A = 1.8; 
f_interf = 15200; 
[rows, cols] = size(audio_clip);
interference = A * sin(2 * pi * f_interf * t)';

% Checks if the audio signal has multiple channels and repeat the
% interference for every channel
if cols > 1
    interference = repmat(interference, 1, cols);
end

%Add the audio signal to the interference
audio_with_interf = audio_clip + interference;
sound(audio_clip, Fs); 
pause(4);
sound(audio_with_interf, Fs);

% audiowrite('audio_afterI.wav', audio_with_interf, Fs);

%Plot the audio signal with different windows using the plot spectrum
%function
plot_spectrum(audio_with_interf(:,1), Fs, 1);
plot_spectrum(audio_with_interf(:,1), Fs, 2);
plot_spectrum(audio_with_interf(:,1), Fs, 3);
plot_spectrum(audio_with_interf(:,1), Fs, 4);

function Hd = kaiser_window
    % FIR Window Lowpass filter using Kaiser window
    Fs = 32000;        % Sampling Frequency
    N = 175;           % Filter order
    Fc = 14800;        % Cutoff Frequency
    Beta = 6.76;       % Kaiser window parameter
    flag = 'scale';    % Normalize gain

    win = kaiser(N+1, Beta);  % Kaiser window
    b = fir1(N, Fc/(Fs/2), 'low', win, flag);  % FIR filter design
    Hd = dfilt.dffir(b);  % Create filter object
end


Hd = kaiser_window();  
filtered_audio = filter(Hd, audio_with_interf);  


sound(filtered_audio, Fs);
pause(4);

% audiowrite('audio_afterF.wav', filtered_audio, Fs);

plot_spectrum(audio_with_interf(:,1), Fs, 1);  
plot_spectrum(filtered_audio(:,1), Fs, 1);     