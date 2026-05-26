%% Interactive MATLAB Script: Basic Operations, Control Structures, and Functions
% This script demonstrates basic MATLAB operations, matrix manipulations,
% control statements, loops, and user-defined functions in an interactive way.
% Prof. Mehdi Pirahandeh 

% Clear the workspace and command window
clc;      % Clear command window
clear;    % Clear all variables from workspace

disp('Welcome to the Interactive MATLAB Tutorial!');
disp('------------------------------------------------');

%% Section 1: Interactive Basic Arithmetic Operations
disp('Section 1: Basic Arithmetic Operations');
% Prompt user to input two numbers
a = input('Enter the first number (a): ');
b = input('Enter the second number (b): ');

% Perform arithmetic operations
sum_result = a + b;           % Addition
difference_result = a - b;    % Subtraction
product_result = a * b;       % Multiplication
division_result = a / b;      % Division
power_result = a ^ b;         % Exponentiation

% Display results
disp('Results of Arithmetic Operations:');
disp(['Sum (a + b): ', num2str(sum_result)]);
disp(['Difference (a - b): ', num2str(difference_result)]);
disp(['Product (a * b): ', num2str(product_result)]);
disp(['Division (a / b): ', num2str(division_result)]);
disp(['Power (a ^ b): ', num2str(power_result)]);
disp('------------------------------------------------');

%% Section 2: Interactive Matrix and Array Operations
disp('Section 2: Matrix and Array Operations');
% Prompt user to input elements of a row vector
row_vector = input('Enter a row vector in the format [x y z ...]: ');

% Display the entered row vector
disp(['You entered the row vector: ', mat2str(row_vector)]);

% Generate a random column vector of the same size as row_vector
col_vector = randi(10, length(row_vector), 1);
disp(['Generated column vector: ', mat2str(col_vector)]);

% Matrix multiplication and element-wise operations
matrix_product = row_vector * col_vector;         % Matrix multiplication
element_wise_product = row_vector .* col_vector'; % Element-wise multiplication

% Display results
disp('Matrix and Array Operations Results:');
disp(['Matrix Product (row_vector * col_vector): ', num2str(matrix_product)]);
disp(['Element-wise Product (row_vector .* col_vector): ', mat2str(element_wise_product)]);
disp('------------------------------------------------');

%% Section 3: Built-in Functions with User Interaction
disp('Section 3: Built-in Functions');
% Create a matrix interactively
rows = input('Enter the number of rows for the matrix: ');
cols = input('Enter the number of columns for the matrix: ');
A = randi(20, rows, cols);  % Generate a random matrix
disp(['Generated Matrix A:']);
disp(A);

% Built-in functions for basic statistics
matrix_sum = sum(A, 'all');       % Sum of all elements
matrix_mean = mean(A, 'all');     % Mean of all elements
matrix_max = max(A(:));           % Maximum value in matrix
matrix_min = min(A(:));           % Minimum value in matrix

% Display results
disp('Results of Built-in Functions:');
disp(['Sum of matrix A: ', num2str(matrix_sum)]);
disp(['Mean of matrix A: ', num2str(matrix_mean)]);
disp(['Max value in matrix A: ', num2str(matrix_max)]);
disp(['Min value in matrix A: ', num2str(matrix_min)]);
disp('------------------------------------------------');

%% Section 4: Interactive Control Statements
disp('Section 4: Control Statements');
% Prompt the user for a number and check conditions
x = input('Enter a number to check its condition (x): ');

% Conditional check using if-else
if x > 10
    disp('x is greater than 10.');
elseif x == 10
    disp('x is equal to 10.');
else
    disp('x is less than 10.');
end

% Switch-case example with user input
color = input('Enter a color (red, blue, green): ', 's');

switch color
    case 'red'
        disp('The color is red.');
    case 'blue'
        disp('The color is blue.');
    case 'green'
        disp('The color is green.');
    otherwise
        disp('Unknown color.');
end
disp('------------------------------------------------');

%% Section 5: Interactive Loops
disp('Section 5: Loops');
% Prompt user for a range to sum up numbers using a for-loop
n = input('Enter a number N to calculate the sum of the first N natural numbers: ');

% For-loop: Sum of first N natural numbers
sum_natural = 0;
for i = 1:n
    sum_natural = sum_natural + i;
end
disp(['Sum of the first ', num2str(n), ' natural numbers is: ', num2str(sum_natural)]);

% While-loop example: Continue adding numbers until sum exceeds a limit
sum_while = 0;
limit = input('Enter a limit for the sum (e.g., 50): ');
i = 1;
while sum_while <= limit
    sum_while = sum_while + i;
    i = i + 1;
end
disp(['Sum reached ', num2str(sum_while), ' after adding ', num2str(i - 1), ' numbers.']);
disp('------------------------------------------------');

%% Section 6: Interactive User-defined Functions
disp('Section 6: Functions');
% Prompt the user for a number to calculate its square
num = input('Enter a number to calculate its square: ');

% Call the user-defined function to calculate the square
square_result = calculate_square(num);
disp(['Square of ', num2str(num), ' is: ', num2str(square_result)]);

% Multiple outputs from a function
[a_squared, a_cubed] = power_function(num);
disp(['Square of ', num2str(num), ' is: ', num2str(a_squared)]);
disp(['Cube of ', num2str(num), ' is: ', num2str(a_cubed)]);
disp('------------------------------------------------');

%% Local Functions
% Functions can be defined at the end of the script (not inside sections)
% and are accessible within the script.

% Function to calculate the square of a number
function sq = calculate_square(x)
    sq = x^2;
end

% Function to calculate both square and cube of a number
function [square, cube] = power_function(x)
    square = x^2;
    cube = x^3;
end

%{
Here’s a sample set of inputs you can use to run each section of the script:

Section 1: Basic Arithmetic Operations
a = 5
b = 3
Results:

Sum: 8
Difference: 2
Product: 15
Division: 1.6667
Power: 125
Section 2: Matrix and Array Operations
Row vector = [1, 2, 3]
Generated random column vector (example):

Column vector = [4; 5; 6]
Results:

Matrix Product: 32
Element-wise Product: [4, 10, 18]
Section 3: Built-in Functions
Number of rows = 3
Number of columns = 3
Example generated matrix:

css
Copy code
A = 
    10    15    12
    19     4    20
     3    17     7
Results of built-in functions:

Sum of matrix A: 107
Mean of matrix A: 11.89
Max value in matrix A: 20
Min value in matrix A: 3
Section 4: Control Statements
x = 12 → Output: x is greater than 10.
color = 'blue' → Output: The color is blue.
Section 5: Loops
N = 5
For loop result:

Sum of the first 5 natural numbers: 15

Limit = 50

While loop result:

Sum reaches 55 after adding 10 numbers.
Section 6: User-defined Functions
num = 4
Function results:

Square of 4: 16
Cube of 4: 64
%}
