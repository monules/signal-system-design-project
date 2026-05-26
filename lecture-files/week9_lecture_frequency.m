% Fourier Representation Examples and Visualizations
% Author: Prof. Mehdi Pirahandeh

clear; close all; clc;

% Parameters
n = 0:50; % discrete time index
t = 0:0.01:5; % continuous time range
Omega = 0.2 * pi; % discrete angular frequency
alpha = 1; % decay factor for exponential signals
RC = 1; % RC circuit parameter
fs = 100; % Sampling frequency

% Initialize figure for subplots
figure('Name', 'Fourier Representation Examples', 'NumberTitle', 'off');
set(gcf, 'Position', [100, 100, 1200, 800]);

%% 1. Frequency Response of LTI System
H_Omega = 0.5 * exp(-1j * Omega); % Example frequency response
x_n = exp(1j * Omega * n); % Input signal
y_n = H_Omega .* x_n; % Output signal

subplot(4, 4, 1);
stem(n, real(y_n), 'b');
title('Frequency Response of LTI System');
xlabel('n'); ylabel('Re\{y[n]\}');
grid on;

%% 2. Discrete vs Continuous-Time Frequency Responses
% Discrete-time impulse response
h_k = 0.5.^(0:10);
H_ejOmega = freqz(h_k, 1, 512);

subplot(4, 4, 2);
plot(abs(H_ejOmega));
title('Discrete-Time Frequency Response');
xlabel('\Omega'); ylabel('|H(e^{j\Omega})|');
grid on;

%% 3. Fourier Series Representation
% Fourier series for x(t) = cos(2*pi*t) + sin(4*pi*t)
t_series = 0:0.01:1;
x_t_series = cos(2*pi*t_series) + sin(4*pi*t_series);

subplot(4, 4, 3);
plot(t_series, x_t_series);
title('Fourier Series of x(t) = cos(2\pi t) + sin(4\pi t)');
xlabel('t'); ylabel('x(t)');
grid on;

%% 4. Continuous-Time Fourier Transform (CTFT)
% CTFT of x(t) = exp(-alpha*t) * u(t)
X_jw = @(w) 1 ./ (alpha + 1j*w);
w_vals = linspace(-10, 10, 500);
X_ctft = X_jw(w_vals);

subplot(4, 4, 4);
plot(w_vals, abs(X_ctft));
title('CTFT |X(j\omega)| of x(t) = e^{-\alpha t}u(t)');
xlabel('\omega'); ylabel('|X(j\omega)|');
grid on;

%% 5. Parseval’s Theorem (Discrete)
% Parseval’s theorem for x[n] = 0.5^n * u[n]
x_n_parseval = (0.5).^n;
E_time = sum(abs(x_n_parseval).^2); % Time-domain energy
X_w = fft(x_n_parseval, 512); % Frequency-domain representation
E_freq = sum(abs(X_w).^2) / length(X_w); % Frequency-domain energy

subplot(4, 4, 5);
bar([E_time, E_freq]);
title('Parseval''s Theorem');
xticklabels({'Time Domain', 'Frequency Domain'});
ylabel('Energy');
grid on;

%% 6. Filtering in Frequency Domain
% Low-pass filter example
f = linspace(-fs/2, fs/2, 512);
H_filter = double(abs(f) < fs/4); % Ideal low-pass filter
X_signal = fftshift(fft(x_n, 512));
Y_filtered = X_signal .* H_filter;

subplot(4, 4, 6);
plot(f, abs(Y_filtered));
title('Low-Pass Filtering in Frequency Domain');
xlabel('Frequency (Hz)'); ylabel('|Y(f)|');
grid on;

%% 7. Time Shifting in Frequency Domain
% Time shift for x(t) = e^(-alpha * t) * u(t)
t0 = 1;
x_t_shifted = exp(-alpha * (t - t0)) .* (t >= t0);
X_shifted = abs(1 ./ (alpha + 1j * w_vals) .* exp(-1j * w_vals * t0));

subplot(4, 4, 7);
plot(w_vals, X_shifted);
title('Time Shifting in Frequency Domain');
xlabel('\omega'); ylabel('|X(j\omega) e^{-j\omega t_0}|');
grid on;

%% 8. Scaling in Frequency Domain
% Scaling: x(2t)
x_scaled = exp(-alpha * (2 * t)) .* (t >= 0);
X_scaled = abs(1 / 2 * X_jw(w_vals / 2));

subplot(4, 4, 8);
plot(w_vals, X_scaled);
title('Scaling in Frequency Domain');
xlabel('\omega'); ylabel('|X(j\omega / 2) / 2|');
grid on;

%% 9. RC Circuit Frequency Response
% RC circuit frequency response
H_rc = @(w) 1 ./ (1 + 1j * w * RC);
w_vals_rc = linspace(0, 10, 500);
H_rc_vals = H_rc(w_vals_rc);

subplot(4, 4, 9);
plot(w_vals_rc, abs(H_rc_vals));
title('RC Circuit Frequency Response');
xlabel('\omega'); ylabel('|H(j\omega)|');
grid on;

%% 10. Orthogonality of Sinusoids
% Sinusoids with different frequencies are orthogonal
f1 = 1; f2 = 3; T = 1; % Periods
t_orth = 0:0.01:T;
y1 = cos(2*pi*f1*t_orth);
y2 = sin(2*pi*f2*t_orth);
dot_product = sum(y1 .* y2); % Should be close to zero

subplot(4, 4, 10);
plot(t_orth, y1, t_orth, y2);
legend('cos(2\pi t)', 'sin(6\pi t)');
title(['Orthogonality of Sinusoids, Dot Product = ', num2str(dot_product)]);
xlabel('t'); ylabel('Amplitude');
grid on;

%% 11. Discrete-Time Fourier Series (DTFS)
% DTFS example for a periodic sequence
N = 20;
x_dtfs = cos(2 * pi / N * n) + sin(4 * pi / N * n);
X_dtfs = fft(x_dtfs, N);

subplot(4, 4, 11);
stem(0:N-1, abs(X_dtfs));
title('DTFS of Discrete Periodic Signal');
xlabel('k'); ylabel('|X[k]|');
grid on;

%% 12. Time Scaling of Continuous-Time Signal
% Scaling: x(at)
a = 2;
x_scaled_cont = exp(-alpha * a * t) .* (t >= 0);

subplot(4, 4, 12);
plot(t, x_scaled_cont);
title('Time Scaling x(2t)');
xlabel('t'); ylabel('x(2t)');
grid on;

%% Layout Adjustments
% Adjust subplot layout
sgtitle('Fourier Representation Examples');
