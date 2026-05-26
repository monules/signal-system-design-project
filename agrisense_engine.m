%% AgriSense Math Engine
% This script contains the modular logic for the AgriSense Dashboard.
% Each function is designed to be easily called by MATLAB App Designer.

function [t, noisy_signal, clean_signal] = get_moisture_data(noise_amp)
    % 1. SIGNAL GENERATION (Assignment Requirement: Signal Simulation)
    t = linspace(0, 10, 1000); % 10 seconds of data
    base_moisture = 40 + 5*sin(2*pi*0.1*t); % Slow changing moisture level
    
    % High frequency noise (interference from greenhouse equipment)
    noise = noise_amp * sin(2*pi*50*t) + (noise_amp/2)*randn(size(t));
    
    noisy_signal = base_moisture + noise;
    
    % 2. LTI SYSTEM / CONVOLUTION (Assignment Requirement: LTI Models)
    % Define a Moving Average Filter (Low-pass)
    windowSize = 20;
    b = (1/windowSize)*ones(1,windowSize);
    a = 1;
    
    % clean_signal = filter(b, a, noisy_signal); % One way to do it
    clean_signal = conv(noisy_signal, b, 'same'); % Using Convolution specifically
end

function [f, P1] = perform_fourier_analysis(signal, Fs)
    % 3. FOURIER REPRESENTATION (Assignment Requirement: Frequency-domain insights)
    L = length(signal);
    Y = fft(signal);
    
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    f = Fs*(0:(L/2))/L;
end

function [isStable, sys] = check_irrigation_stability(K_gain)
    % 4. LAPLACE & STABILITY (Assignment Requirement: Laplace / Control)
    % Model the soil moisture response as a 2nd order LTI system
    % H(s) = K / (s^2 + 3s + 2)
    num = [K_gain];
    den = [1 3 2];
    sys = tf(num, den);
    
    % Check stability via poles
    p = pole(sys);
    if all(real(p) < 0)
        isStable = true;
    else
        isStable = false;
    end
end

%% Example Execution Script (For testing the logic)
Fs = 100; % Sampling frequency
[t, noisy, clean] = get_moisture_data(2.0);
[freq, spectrum] = perform_fourier_analysis(noisy, Fs);
[stable, mySys] = check_irrigation_stability(10);

% Visualization for verification
subplot(3,1,1);
plot(t, noisy, 'r', t, clean, 'b', 'LineWidth', 1.5);
title('AgriSense: Time Domain (Noisy vs Filtered)');
legend('Raw Sensor', 'Filtered Moisture');

subplot(3,1,2);
plot(freq, spectrum);
title('AgriSense: Frequency Domain (Fourier Analysis)');
xlabel('Frequency (Hz)'); ylabel('|P1(f)|');

subplot(3,1,3);
pzmap(mySys);
title('AgriSense: Laplace Domain Stability (Pole-Zero Map)');
