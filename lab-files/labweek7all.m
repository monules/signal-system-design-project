% Initialize Variables
t = -3; % Shift Value for time shift
n = 1; d = 4; % Scaling Factors
t3 = -4; % Condition value for Reversal

% Continuous-Time Piecewise Definitions
x1 = 0:0.2:4;  y1 = 2 * sin((pi/4) * x1); % Continuous Sine
x2 = -2:0.5:0; y2 = -x2;                  % Negative Slope
x3 = -4:-2;    y3 = [2, 2, 2];            % Constant

% Discrete-Time Piecewise Definitions
xx1 = 0:0.5:4; yy1 = 2 * sin((pi/4) * xx1); % Discrete Sine
xx2 = -2:0.5:0; yy2 = -xx2;                 % Negative Slope
xx3 = -4:-2;    yy3 = [2, 2, 2];            % Constant

% Grid Layout for Visualization
figure;
% Continuous-Time Scenarios
subplot(2,4,1); plotOriginalSignal(x1, y1, x2, y2, x3, y3, 'Original Continuous-Time Signal');
subplot(2,4,2); plotTimeShift(x1, y1, x2, y2, x3, y3, t, 'Time-Shifted Continuous-Time Signal');
subplot(2,4,3); plotScaling(x1, y1, x2, y2, x3, y3, n, d, t, 'Scaled Continuous-Time Signal');
subplot(2,4,4); plotReversal(x1, y1, x2, y2, x3, y3, n, d, t, t3, 'Reversed Continuous-Time Signal');

% Discrete-Time Scenarios
subplot(2,4,5); stemOriginalSignal(xx1, yy1, xx2, yy2, xx3, yy3, 'Original Discrete-Time Signal');
subplot(2,4,6); stemTimeShift(xx1, yy1, xx2, yy2, xx3, yy3, t, 'Time-Shifted Discrete-Time Signal');
subplot(2,4,7); stemScaling(xx1, yy1, xx2, yy2, xx3, yy3, n, d, t, 'Scaled Discrete-Time Signal');
subplot(2,4,8); stemReversal(xx1, yy1, xx2, yy2, xx3, yy3, n, d, t, t3, 'Reversed Discrete-Time Signal');

% Function Definitions
% Sub-function for Continuous Original Signal Plot
function plotOriginalSignal(x1, y1, x2, y2, x3, y3, titleText)
    plot(x1, y1, x2, y2, x3, y3, 'LineWidth', 2);
    title(titleText);
    xlabel('time'); ylabel('f(t)');
    grid on; axis([-5, 5, -1, 2.5]);
end

% Sub-function for Continuous Time Shift Plot
function plotTimeShift(x1, y1, x2, y2, x3, y3, t, titleText)
    if t < 0
        plot((x1 - t), y1, (x2 - t), y2, (x3 - t), y3, 'LineWidth', 2);
    else
        plot((x1 + t), y1, (x2 + t), y2, (x3 + t), y3, 'LineWidth', 2);
    end
    title(titleText);
    xlabel('time'); ylabel('f(t)');
    grid on; axis([-5, 5, -1, 2.5]);
end

% Sub-function for Continuous Scaling Plot
function plotScaling(x1, y1, x2, y2, x3, y3, n, d, t, titleText)
    if n == d
        plot((x1 - t) * (d / n), y1, (x2 - t) * (d / n), y2, (x3 - t) * (d / n), y3, 'LineWidth', 2);
    else
        plot((x1 - t) * (n / d), y1, (x2 - t) * (n / d), y2, (x3 - t) * (n / d), y3, 'LineWidth', 2);
    end
    title(titleText);
    xlabel('time'); ylabel('f(t)');
    grid on; axis([-5, 5, -1, 2.5]);
end

% Sub-function for Continuous Reversal Plot
function plotReversal(x1, y1, x2, y2, x3, y3, n, d, t, t3, titleText)
    if t3 < 0 && n == d
        plot(-(x1 - t) * (d / n), y1, -(x2 - t) * (d / n), y2, -(x3 - t) * (d / n), y3, 'LineWidth', 2);
    else
        plot((x1 - t) * (n / d), y1, (x2 - t) * (n / d), y2, (x3 - t) * (n / d), y3, 'LineWidth', 2);
    end
    title(titleText);
    xlabel('time'); ylabel('f(t)');
    grid on; axis([-5, 5, -1, 2.5]);
end

% Sub-function for Discrete Original Signal Plot
function stemOriginalSignal(xx1, yy1, xx2, yy2, xx3, yy3, titleText)
    stem(xx1, yy1, 'filled'); hold on;
    stem(xx2, yy2, 'filled');
    stem(xx3, yy3, 'filled'); hold off;
    title(titleText);
    xlabel('n'); ylabel('x(n)');
    grid on; axis([-5, 5, -1, 2.5]);
end

% Sub-function for Discrete Time Shift Plot
function stemTimeShift(xx1, yy1, xx2, yy2, xx3, yy3, t, titleText)
    if t < 0
        stem(xx1 - t, yy1, 'filled'); hold on;
        stem(xx2 - t, yy2, 'filled');
        stem(xx3 - t, yy3, 'filled'); hold off;
    else
        stem(xx1 + t, yy1, 'filled'); hold on;
        stem(xx2 + t, yy2, 'filled');
        stem(xx3 + t, yy3, 'filled'); hold off;
    end
    title(titleText);
    xlabel('n'); ylabel('x(n)');
    grid on; axis([-5, 5, -1, 2.5]);
end

% Sub-function for Discrete Scaling Plot
function stemScaling(xx1, yy1, xx2, yy2, xx3, yy3, n, d, t, titleText)
    if n == d
        stem((xx1 - t) * (d / n), yy1, 'filled'); hold on;
        stem((xx2 - t) * (d / n), yy2, 'filled');
        stem((xx3 - t) * (d / n), yy3, 'filled'); hold off;
    else
        stem((xx1 - t) * (n / d), yy1, 'filled'); hold on;
        stem((xx2 - t) * (n / d), yy2, 'filled');
        stem((xx3 - t) * (n / d), yy3, 'filled'); hold off;
    end
    title(titleText);
    xlabel('n'); ylabel('x(n)');
    grid on; axis([-5, 5, -1, 2.5]);
end

% Sub-function for Discrete Reversal Plot
function stemReversal(xx1, yy1, xx2, yy2, xx3, yy3, n, d, t, t3, titleText)
    if t3 < 0 && n == d
        stem(-(xx1 - t) * (d / n), yy1, 'filled'); hold on;
        stem(-(xx2 - t) * (d / n), yy2, 'filled');
        stem(-(xx3 - t) * (d / n), yy3, 'filled'); hold off;
    else
        stem((xx1 - t) * (n / d), yy1, 'filled'); hold on;
        stem((xx2 - t) * (n / d), yy2, 'filled');
        stem((xx3 - t) * (n / d), yy3, 'filled'); hold off;
    end
    title(titleText);
    xlabel('n'); ylabel('x(n)');
    grid on; axis([-5, 5, -1, 2.5]);
end
