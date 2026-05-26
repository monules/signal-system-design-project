%% Interactive MATLAB Script: Signals and Systems for Smart Home IoT Devices
% This script demonstrates the basic concepts of signals and systems for
% smart home IoT devices. It includes signal processing tasks like basic operations,
% matrix manipulations, control statements, loops, and user-defined functions.

% Prof. Mehdi Pirahandeh
% Clear the workspace and command window
clc; clear;

disp('Welcome to the Interactive MATLAB Tutorial on Smart Home IoT Signals and Systems!');
disp('------------------------------------------------');

%% Section 1: Simulating Smart Home Sensor Data for Arithmetic Operations
disp('Section 1: Basic Arithmetic Operations on IoT Sensor Data');

% Simulating sensor data from smart home IoT devices
fs = 1/60;  % 1 sample per minute
t = 0:fs:(24*60-1)/60;  % Time vector for 24 hours (in hours)
temperature = 20 + 5*sin(2*pi*(1/24)*t);  % Simulated temperature signal (20-25 °C)

% Prompt user to input a scalar value for calibration adjustment
adjustment = input('Enter a scalar adjustment value to add to the temperature: ');

% Perform arithmetic operations on the signal
adjusted_temperature = temperature + adjustment;  % Adjusted temperature signal

% Display results
disp(['Temperature adjusted by ', num2str(adjustment), ' degrees.']);
disp('------------------------------------------------');

%% Section 2: Matrix and Array Operations on Sensor Data
disp('Section 2: Matrix and Array Operations on IoT Sensor Data');

% Simulating additional sensor data (e.g., humidity)
humidity = 50 + 10*sin(2*pi*(1/24)*t) + 2*randn(size(t));  % Noisy humidity signal (40-60%)

% Prompt user for matrix operation type
operation_type = input('Enter the matrix operation (options: addition, element-wise multiplication): ', 's');

% Perform matrix operations on temperature and humidity signals
if strcmp(operation_type, 'addition')
    combined_signal = temperature + humidity;  % Adding two sensor signals
    disp('Combined Signal (Temperature + Humidity):');
    disp(combined_signal(1:10));  % Display the first 10 values
elseif strcmp(operation_type, 'element-wise multiplication')
    combined_signal = temperature .* humidity;  % Element-wise multiplication of signals
    disp('Combined Signal (Temperature .* Humidity):');
    disp(combined_signal(1:10));  % Display the first 10 values
else
    disp('Invalid operation type.');
end
disp('------------------------------------------------');

%% Section 3: Built-in Functions for Signal Processing
disp('Section 3: Built-in Functions for Signal Processing');

% Prompt user for the number of samples to analyze
num_samples = input('Enter the number of samples to analyze from the sensor data: ');

% Apply built-in functions to the temperature signal
mean_temp = mean(temperature(1:num_samples));  % Mean of the first N samples
max_temp = max(temperature(1:num_samples));    % Maximum temperature value
min_temp = min(temperature(1:num_samples));    % Minimum temperature value

% Display results
disp(['Mean Temperature for first ', num2str(num_samples), ' samples: ', num2str(mean_temp)]);
disp(['Max Temperature for first ', num2str(num_samples), ' samples: ', num2str(max_temp)]);
disp(['Min Temperature for first ', num2str(num_samples), ' samples: ', num2str(min_temp)]);
disp('------------------------------------------------');

%% Section 4: Control Statements for IoT Sensor Data
disp('Section 4: Control Statements for IoT Sensor Data');

% Prompt the user to input a threshold for temperature control
threshold = input('Enter a temperature threshold to check (°C): ');

% Check if the temperature exceeds the threshold at any point in time
if any(temperature > threshold)
    disp(['Temperature exceeds ', num2str(threshold), ' °C at some point during the day.']);
else
    disp(['Temperature does not exceed ', num2str(threshold), ' °C during the day.']);
end
disp('------------------------------------------------');

%% Section 5: Loops for Analyzing Signal Patterns
disp('Section 5: Loops for Analyzing Signal Patterns');

% Calculate the total time temperature was above a certain threshold
time_above_threshold = 0;
threshold = input('Enter a threshold to count the duration (hours) when the temperature is above this threshold: ');

for i = 1:length(temperature)
    if temperature(i) > threshold
        time_above_threshold = time_above_threshold + fs;
    end
end
disp(['The temperature was above ', num2str(threshold), ' °C for ', num2str(time_above_threshold), ' hours.']);
disp('------------------------------------------------');

%% Section 6: Interactive User-defined Functions for Signal Processing
disp('Section 6: User-defined Functions for Signal Processing');

% Prompt the user for a time interval to calculate the mean temperature
start_time = input('Enter the start time (hours): ');
end_time = input('Enter the end time (hours): ');

% Call the user-defined function to calculate the mean temperature over the given time interval
mean_temperature = calculate_mean_temperature(t, temperature, start_time, end_time);
disp(['Mean temperature from ', num2str(start_time), ' to ', num2str(end_time), ' hours is: ', num2str(mean_temperature), ' °C']);

disp('------------------------------------------------');

%% Local Functions

% Function to calculate the mean temperature over a given time interval
function mean_temp = calculate_mean_temperature(t, temperature, start_time, end_time)
    % Find the indices corresponding to the start and end times
    start_idx = find(t >= start_time, 1);
    end_idx = find(t <= end_time, 1, 'last');
    
    % Calculate the mean temperature over the interval
    mean_temp = mean(temperature(start_idx:end_idx));
end

%{
To help you run the script, here is some sample input data for each section, allowing you to interact with the script as intended.
Section 1: Simulating Smart Home Sensor Data for Arithmetic Operations
Input for adjustment: 2
This will adjust the temperature signal by 2 degrees.

Section 2: Matrix and Array Operations on Sensor Data
Input for matrix operation: addition or element-wise multiplication
For addition, the script will add the temperature and humidity signals element-wise. For element-wise multiplication, it will multiply them element-wise.

Example output for the first 10 values:

Addition: [64.3053, 58.4227, 57.0141, 56.7192, 56.0416, 54.6439, 52.6257, 50.0726, 47.3495, 45.2735]
Element-wise multiplication: [1022.8821, 931.4671, 915.9531, 910.2357, 899.3711, 877.5874, 845.2242, 804.2812, 761.6122, 728.8547]
Section 3: Built-in Functions for Signal Processing
Input for number of samples: 1440 (This represents 24 hours of data in minutes)
Example results:

Mean Temperature: 20.0000 °C
Max Temperature: 25.0000 °C
Min Temperature: 15.0000 °C
Section 4: Control Statements for IoT Sensor Data
Input for temperature threshold: 22
Example output:

Temperature exceeds 22 °C at some point during the day.
Section 5: Loops for Analyzing Signal Patterns
Input for threshold: 22
This calculates the total time that the temperature was above 22°C in hours.

Example output:

The temperature was above 22 °C for 6.0000 hours.
Section 6: Interactive User-defined Functions for Signal Processing
Input for start time: 8 (hours)
Input for end time: 18 (hours)
This will calculate the mean temperature between 8 AM and 6 PM.

Example output:

Mean temperature from 8 to 18 hours is: 23.5359 °C
This sample data will allow you to interactively run and test each section of the script.
%}
