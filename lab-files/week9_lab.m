% Define the time shift
tt = -3;

% Define the coordinates for the signals
xx1 = 0:10;                             % X-coordinates for signal 1
yy1 = sin(xx1);                         % Y-coordinates for signal 1 (sine wave)
xx2 = 0:10;                             % X-coordinates for signal 2
yy2 = cos(xx2);                         % Y-coordinates for signal 2 (cosine wave)
xx3 = 0:10;                             % X-coordinates for signal 3
yy3 = xx3.^2;                           % Y-coordinates for signal 3 (quadratic)

% Define coordinates for drawing a cross on Cartesian plane
tts1 = [0 0];                           % Vertical line X-coordinates
tts2 = [-1 2.5];                        % Vertical line Y-coordinates
tts3 = [(-5-tt) (5-tt)];                % Horizontal line X-coordinates
tts4 = [0 0];                           % Horizontal line Y-coordinates

% Create figure and plot each signal in a separate subplot
figure;

% Subplot for the first signal
subplot(2,2,1);                         % Position the first subplot in the upper left
stem(xx1-tt, yy1, 'filled');
title('Time-Shifted Sine Wave');
xlabel('n');
ylabel('x(n)');
grid on;

% Subplot for the second signal
subplot(2,2,2);                         % Position the second subplot in the upper right
stem(xx2-tt, yy2, 'filled');
title('Time-Shifted Cosine Wave');
xlabel('n');
ylabel('x(n)');
grid on;

% Subplot for the third signal
subplot(2,2,3);                         % Position the third subplot in the lower left
stem(xx3-tt, yy3, 'filled');
title('Time-Shifted Quadratic');
xlabel('n');
ylabel('x(n)');
grid on;

% Subplot for plotting the Cartesian cross
subplot(2,2,4);                         % Position the cross plot in the lower right
plot([tts1 tts3], [tts2 tts4], 'k', 'LineWidth', 1);
title('Cartesian Cross');
xlabel('n');
ylabel('x(n)');
grid on;
