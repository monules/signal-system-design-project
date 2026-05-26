% New Parameters
t_shift = -2; % Shift Value for time shift
n = 2; d = 3; % Scaling Factors
t_reverse = -2; % Condition value for Reversal

% Continuous-Time Signal Definitions
t = -4:0.1:4; % Time range for continuous signal
y_cont1 = cos(2 * pi * t) .* exp(-0.1 * t); % Cosine with Exponential Decay
y_cont2 = sin(2 * pi * t);                  % Sine Wave
y_cont3 = 0.5 * t;                          % Linear Ramp

% Discrete-Time Signal Definitions (higher resolution)
n_discrete = -4:0.1:4; 
y_disc1 = cos(2 * pi * n_discrete) .* exp(-0.1 * n_discrete); % Cosine with Exponential Decay
y_disc2 = sin(2 * pi * n_discrete);                           % Sine Wave
y_disc3 = 0.5 * n_discrete;                                   % Linear Ramp

% Grid Layout for Visualization
figure;

% Continuous-Time Scenarios
subplot(2,4,1); plotOriginalContinuous(t, y_cont1, y_cont2, y_cont3, 'Original Continuous-Time Signals');
subplot(2,4,2); plotTimeShiftContinuous(t, y_cont1, y_cont2, y_cont3, t_shift, 'Time-Shifted Continuous-Time Signals');
subplot(2,4,3); plotScalingContinuous(t, y_cont1, y_cont2, y_cont3, n, d, t_shift, 'Scaled Continuous-Time Signals');
subplot(2,4,4); plotReversalContinuous(t, y_cont1, y_cont2, y_cont3, n, d, t_shift, t_reverse, 'Reversed Continuous-Time Signals');

% Discrete-Time Scenarios
subplot(2,4,5); stemOriginalDiscrete(n_discrete, y_disc1, y_disc2, y_disc3, 'Original Discrete-Time Signals');
subplot(2,4,6); stemTimeShiftDiscrete(n_discrete, y_disc1, y_disc2, y_disc3, t_shift, 'Time-Shifted Discrete-Time Signals');
subplot(2,4,7); stemScalingDiscrete(n_discrete, y_disc1, y_disc2, y_disc3, n, d, t_shift, 'Scaled Discrete-Time Signals');
subplot(2,4,8); stemReversalDiscrete(n_discrete, y_disc1, y_disc2, y_disc3, n, d, t_shift, t_reverse, 'Reversed Discrete-Time Signals');

% Function Definitions
% Sub-function for Continuous Original Signals Plot
function plotOriginalContinuous(t, y1, y2, y3, titleText)
    plot(t, y1, t, y2, t, y3, 'LineWidth', 2);
    legend('Cosine Decay', 'Sine Wave', 'Linear Ramp');
    title(titleText);
    xlabel('time'); ylabel('f(t)');
    grid on; axis([-5, 5, -2, 2]);
end

% Sub-function for Continuous Time Shift Plot
function plotTimeShiftContinuous(t, y1, y2, y3, t_shift, titleText)
    plot(t - t_shift, y1, t - t_shift, y2, t - t_shift, y3, 'LineWidth', 2);
    legend('Cosine Decay', 'Sine Wave', 'Linear Ramp');
    title(titleText);
    xlabel('time'); ylabel('f(t)');
    grid on; axis([-5, 5, -2, 2]);
end

% Sub-function for Continuous Scaling Plot
function plotScalingContinuous(t, y1, y2, y3, n, d, t_shift, titleText)
    t_scaled = (t - t_shift) * (n / d);
    plot(t_scaled, y1, t_scaled, y2, t_scaled, y3, 'LineWidth', 2);
    legend('Cosine Decay', 'Sine Wave', 'Linear Ramp');
    title(titleText);
    xlabel('time'); ylabel('f(t)');
    grid on; axis([-5, 5, -2, 2]);
end

% Sub-function for Continuous Reversal Plot
function plotReversalContinuous(t, y1, y2, y3, n, d, t_shift, t_reverse, titleText)
    if t_reverse < 0
        t_reversed = -(t - t_shift) * (n / d);
    else
        t_reversed = (t - t_shift) * (n / d);
    end
    plot(t_reversed, y1, t_reversed, y2, t_reversed, y3, 'LineWidth', 2);
    legend('Cosine Decay', 'Sine Wave', 'Linear Ramp');
    title(titleText);
    xlabel('time'); ylabel('f(t)');
    grid on; axis([-5, 5, -2, 2]);
end

% Sub-function for Discrete Original Signals Plot
function stemOriginalDiscrete(n_discrete, y1, y2, y3, titleText)
    stem(n_discrete, y1, 'filled'); hold on;
    stem(n_discrete, y2, 'filled');
    stem(n_discrete, y3, 'filled'); hold off;
    legend('Cosine Decay', 'Sine Wave', 'Linear Ramp');
    title(titleText);
    xlabel('n'); ylabel('x(n)');
    grid on; axis([-5, 5, -2, 2]);
end

% Sub-function for Discrete Time Shift Plot
function stemTimeShiftDiscrete(n_discrete, y1, y2, y3, t_shift, titleText)
    stem(n_discrete - t_shift, y1, 'filled'); hold on;
    stem(n_discrete - t_shift, y2, 'filled');
    stem(n_discrete - t_shift, y3, 'filled'); hold off;
    legend('Cosine Decay', 'Sine Wave', 'Linear Ramp');
    title(titleText);
    xlabel('n'); ylabel('x(n)');
    grid on; axis([-5, 5, -2, 2]);
end

% Sub-function for Discrete Scaling Plot
function stemScalingDiscrete(n_discrete, y1, y2, y3, n, d, t_shift, titleText)
    n_scaled = (n_discrete - t_shift) * (n / d);
    stem(n_scaled, y1, 'filled'); hold on;
    stem(n_scaled, y2, 'filled');
    stem(n_scaled, y3, 'filled'); hold off;
    legend('Cosine Decay', 'Sine Wave', 'Linear Ramp');
    title(titleText);
    xlabel('n'); ylabel('x(n)');
    grid on; axis([-5, 5, -2, 2]);
end

% Sub-function for Discrete Reversal Plot
function stemReversalDiscrete(n_discrete, y1, y2, y3, n, d, t_shift, t_reverse, titleText)
    if t_reverse < 0
        n_reversed = -(n_discrete - t_shift) * (n / d);
    else
        n_reversed = (n_discrete - t_shift) * (n / d);
    end
    stem(n_reversed, y1, 'filled'); hold on;
    stem(n_reversed, y2, 'filled');
    stem(n_reversed, y3, 'filled'); hold off;
    legend('Cosine Decay', 'Sine Wave', 'Linear Ramp');
    title(titleText);
    xlabel('n'); ylabel('x(n)');
    grid on; axis([-5, 5, -2, 2]);
end
