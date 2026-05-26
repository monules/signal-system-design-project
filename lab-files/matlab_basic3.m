%% Interactive MATLAB Script: Smart Home IoT Device Data Visualization
% This script demonstrates data visualization for a real-world application
% in a smart home IoT environment. It simulates sensor data (e.g., temperature,
% humidity, light intensity) and applies both clean and noisy signals. The script
% covers 2D and 3D plotting, data manipulation, and saving data to CSV and Excel.
% Prof. Mehdi Pirahandeh
% Clear the workspace and command window
clc; clear;

disp('Welcome to the Interactive MATLAB Tutorial on Smart Home IoT Device Data Visualization!');
disp('------------------------------------------------------------------------------------------------');

%% Section 1: Simulating Smart Home IoT Sensor Data
disp('Section 1: Simulating Smart Home IoT Sensor Data');

% Sample rate and time vector (simulate 24 hours of data with 1-minute intervals)
fs = 1/60;  % 1 sample per minute
t = 0:fs:(24*60-1)/60;  % Time vector for 24 hours (in hours)

% Simulate sensor data:
% - Temperature data (sine wave representing temperature variation over a day)
% - Humidity data (sine wave with random fluctuation)
% - Light intensity data (light intensity variation based on time of day)

temperature = 20 + 5*sin(2*pi*(1/24)*t);  % Clean temperature signal (20-25 °C)
humidity = 50 + 10*sin(2*pi*(1/24)*t) + 2*randn(size(t));  % Noisy humidity signal (40-60%)
light_intensity = 1000 * (sin(2*pi*(1/24)*t) > 0);  % Light intensity signal (day/night simulation)

% Save the IoT sensor data into Excel and CSV files
sensor_data = table(t', temperature', humidity', light_intensity', ...
                    'VariableNames', {'Time_Hours', 'Temperature_C', 'Humidity_Percent', 'Light_Intensity_Lux'});

% Prompt user for filename for Excel and CSV files
file_name = input('Enter the filename to save the IoT sensor data (without extension): ', 's');

% Save as Excel
writetable(sensor_data, [file_name '.xlsx']);
disp(['IoT sensor data saved as Excel file: ', file_name '.xlsx']);

% Save as CSV
writetable(sensor_data, [file_name '.csv']);
disp(['IoT sensor data saved as CSV file: ', file_name '.csv']);

disp('The IoT sensor data contains the following columns:');
disp('- Time_Hours: Time over a 24-hour period');
disp('- Temperature_C: Temperature readings in Celsius');
disp('- Humidity_Percent: Humidity readings in percentage');
disp('- Light_Intensity_Lux: Light intensity readings in lux');
disp('------------------------------------------------------------------------------------------------');

%% Section 2: Visualizing Smart Home Sensor Data in a Single Grid of Plots
disp('Section 2: Visualizing Smart Home Sensor Data');

% Create a grid of subplots for sensor data visualization
figure;
subplot(3, 2, 1);
plot(t, temperature, 'LineWidth', 2);
title('Temperature (°C) over 24 hours');
xlabel('Time (hours)');
ylabel('Temperature (°C)');
grid on;

subplot(3, 2, 2);
scatter(t, humidity, 'filled');
title('Humidity (%) over 24 hours');
xlabel('Time (hours)');
ylabel('Humidity (%)');
grid on;

subplot(3, 2, 3);
plot(t, light_intensity, 'LineWidth', 2);
title('Light Intensity (Lux) over 24 hours');
xlabel('Time (hours)');
ylabel('Light Intensity (Lux)');
grid on;

% Adding more 2D plots for comparison
subplot(3, 2, 4);
bar(t(1:60:end), temperature(1:60:end));
title('Temperature (Bar Plot, Hourly)');
xlabel('Time (hours)');
ylabel('Temperature (°C)');
grid on;

subplot(3, 2, 5);
histogram(humidity, 20);
title('Histogram of Humidity (%)');
xlabel('Humidity (%)');
ylabel('Frequency');
grid on;

subplot(3, 2, 6);
plot(t, temperature, 'b', t, humidity, 'r', t, light_intensity, 'g', 'LineWidth', 1.5);
title('Overlay: Temperature, Humidity, and Light Intensity');
xlabel('Time (hours)');
ylabel('Values');
legend('Temperature (°C)', 'Humidity (%)', 'Light Intensity (Lux)');
grid on;

disp('------------------------------------------------------------------------------------------------');

%% Section 3: 3D Plotting for IoT Sensor Data
disp('Section 3: 3D Plotting for IoT Sensor Data');

% Create a 3D plot combining temperature, humidity, and time
figure;

% Use meshgrid to create a grid for time and temperature
[X, Y] = meshgrid(t, temperature);

% Repeat humidity values to create a matrix for Z
Z = repmat(humidity, length(temperature), 1);

% Plot mesh for Temperature vs Humidity vs Time
subplot(1, 2, 1);
mesh(X, Y, Z);
title('3D Mesh: Temperature, Humidity, and Time');
xlabel('Time (hours)');
ylabel('Temperature (°C)');
zlabel('Humidity (%)');
grid on;

% Surface plot for Light Intensity as a function of Time and Temperature
subplot(1, 2, 2);
Z_light = repmat(light_intensity, length(temperature), 1);  % Create a matrix for light intensity
surf(X, Y, Z_light);
title('3D Surface: Light Intensity vs Temperature and Time');
xlabel('Time (hours)');
ylabel('Temperature (°C)');
zlabel('Light Intensity (Lux)');
grid on;

disp('------------------------------------------------------------------------------------------------');

%% Section 4: Data Manipulation for Smart Home Sensor Data
disp('Section 4: Data Manipulation for Smart Home Sensor Data');

% Read the IoT sensor data from the previously saved file (CSV or Excel)
data_choice = input('Do you want to read data from (1) CSV file or (2) Excel file? Enter 1 or 2: ');

if data_choice == 1
    % Read data from CSV
    read_data_csv = readtable([file_name '.csv']);
    disp('Data read from CSV file:');
    disp(read_data_csv(1:10, :));  % Display first 10 rows of the table
    
    % Ensure correct column name reference
    column_names = read_data_csv.Properties.VariableNames;
    temp_column = column_names{strcmp(column_names, 'Temperature_C')};
    hum_column = column_names{strcmp(column_names, 'Humidity_Percent')};
    
    % Example data manipulation:
    % Filtering: Select times when temperature exceeds 22°C
    high_temp_indices = read_data_csv.(temp_column) > 22;
    filtered_data = read_data_csv(high_temp_indices, :);
    disp('Filtered data for times when temperature exceeds 22°C:');
    disp(filtered_data(1:10, :));  % Display first 10 rows of filtered data
    
    % Sorting: Sort the data by humidity in ascending order
    sorted_data = sortrows(read_data_csv, hum_column);
    disp('Data sorted by Humidity (in ascending order):');
    disp(sorted_data(1:10, :));  % Display first 10 rows of sorted data
    
elseif data_choice == 2
    % Read data from Excel
    read_data_excel = readtable([file_name '.xlsx']);
    disp('Data read from Excel file:');
    disp(read_data_excel(1:10, :));  % Display first 10 rows of the table
    
    % Ensure correct column name reference
    column_names = read_data_excel.Properties.VariableNames;
    temp_column = column_names{strcmp(column_names, 'Temperature_C')};
    hum_column = column_names{strcmp(column_names, 'Humidity_Percent')};
    
    % Example data manipulation:
    % Filtering: Select times when temperature exceeds 22°C
    high_temp_indices = read_data_excel.(temp_column) > 22;
    filtered_data = read_data_excel(high_temp_indices, :);
    disp('Filtered data for times when temperature exceeds 22°C:');
    disp(filtered_data(1:10, :));  % Display first 10 rows of filtered data
    
    % Sorting: Sort the data by humidity in ascending order
    sorted_data = sortrows(read_data_excel, hum_column);
    disp('Data sorted by Humidity (in ascending order):');
    disp(sorted_data(1:10, :));  % Display first 10 rows of sorted data
    
else
    disp('Invalid option selected.');
end

disp('------------------------------------------------------------------------------------------------');

%% Conclusion
disp('This concludes the interactive MATLAB tutorial on Smart Home IoT Data Visualization and Analysis.');
disp('Feel free to modify this script and experiment with different features!');

%{
Here’s a sample input data to run the script:

Section 1: Simulating Smart Home IoT Sensor Data
file_name: smart_home_iot_data
This will save the simulated data to smart_home_iot_data.csv and smart_home_iot_data.xlsx.

Simulated data includes:

Temperature (°C): A clean sine wave ranging from 20°C to 25°C.
Humidity (%): A noisy sine wave ranging from 40% to 60% with some random noise.
Light Intensity (Lux): A step function to simulate day (1000 lux) and night (0 lux) cycles.
Section 2: Visualizing Smart Home Sensor Data
The script will create the following plots:
Temperature over 24 hours (Line Plot)
Humidity over 24 hours (Scatter Plot)
Light Intensity over 24 hours (Line Plot)
Hourly Temperature (Bar Plot)
Histogram of Humidity
Overlay of Temperature, Humidity, and Light Intensity
These plots will help you visualize the simulated data.

Section 3: 3D Plotting for IoT Sensor Data
The script generates two 3D plots:
3D Mesh: Temperature vs. Humidity vs. Time.
3D Surface: Light Intensity vs. Temperature and Time.
Section 4: Data Manipulation for Smart Home Sensor Data
Data reading choice: You can choose either CSV or Excel.
Example data manipulations:
Filter data: Extract all rows where the temperature exceeds 22°C.
Sort data: Sort the data by humidity in ascending order.
For instance:

matlab
Copy code
Enter the filename to save the IoT sensor data (without extension): smart_home_iot_data
Do you want to read data from (1) CSV file or (2) Excel file? Enter 1 or 2: 1
Output:

The script will display the first 10 rows of the filtered data where temperature exceeds 22°C and the sorted data by humidity.
This input data will allow you to run the full script and interact with the simulated smart home IoT sensor data effectively.
%}