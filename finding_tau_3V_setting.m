%% LOADING 2 VOLT DATA
data = readtable('velocity_data_2volts_take2.txt');  % Or replace with your actual filename
x = data.Var1;  % Assuming 't' is the column for the independent variable
y = data.Var2;  % Assuming 'vx' is the column for the dependent variable

%% LOADING 3 VOLT DATA
data = readtable('velocity_data_3volts_take2.txt');  % Or replace with your actual filename
x = data.Var1;  % Assuming 't' is the column for the independent variable
y = data.Var2;  % Assuming 'vx' is the column for the dependent variable

%% Loading 4 VOLT DATA
data = readtable('velocity_data_4volts.txt');  % Or replace with your actual filename
x = data.Var1;  % Assuming 't' is the column for the independent variable
y = data.Var2;  % Assuming 'vx' is the column for the dependent variable

%% 
% Define the saturating exponential function
format short;
model_func = @(b, x) b(1) ./ (1 + exp(-b(2)*x));  % b(1) = A, b(2) = B

% Initial guess for parameters [A, B, C]
initial_guess = [max(y), 1, mean(x)];
% Options for lsqcurvefit (disable display of fitting progress)
options = optimset('Display', 'off');

% Fit the model using lsqcurvefit
params = lsqcurvefit(model_func, initial_guess, x, y, [], [], options);
% Evaluate the fitted model at the data points
y_fit = model_func(params, x);

% Plot the original data and the fitted curve
figure;
plot(x, y, 'o', 'DisplayName', 'Data');  % Original data points
hold on;
plot(x, y_fit, '-', 'DisplayName', 'Fitted Curve');  % Fitted curve
hold off;
legend;
title('Saturating Exponential Fit using lsqcurvefit');
A = params(1)
B = params(2)
tau = 1/B

% disp(['Fitted parameters: A = ', num2str(params(1)), ', B = ', num2str(params(2))]);

%% Compute the residuals
residuals = y - y_fit;
% Compute the root-squared value
SS_res = sum(residuals.^2);  % Sum of squared residuals
SS_tot = sum((y - mean(y)).^2);  % Total sum of squares
R_squared = 1 - (SS_res / SS_tot);  % R-squared value
disp(['R-squared: ', num2str(R_squared)]);

