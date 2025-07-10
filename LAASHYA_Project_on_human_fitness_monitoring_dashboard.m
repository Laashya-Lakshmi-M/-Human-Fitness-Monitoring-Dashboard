% Human Fitness Monitoring Dashboard
% Author: Lasshya Lakshmi M.

clc; clear; close all;

% Define API Key and Channel ID
writeAPIKey = '12DDX46ACYLY6GR9'; % Replace with your Write API Key
readAPIKey = 'YRE13GX8H06T8T97';  % Replace with your Read API Key
channelID = 2879601;  % Replace with your Channel ID

% Setup Mobile Connection
m = mobiledev;  % Connect to MATLAB Mobile
m.AccelerationSensorEnabled = true;
m.AngularVelocitySensorEnabled = true;
%m.MagneticFieldSensorEnabled = true;
m.Logging = true;  % Start Logging Data

disp("📡 Collecting Data... Move Your Phone!");

while true
    % Read the latest sensor data
    accel_data = m.Acceleration;   % Read acceleration
    gyro_data = m.AngularVelocity; % Read gyroscope
    mag_data = m.MagneticField;    % Read magnetometer
    
    % Compute mean values for each sensor
    mean_accel = mean(accel_data, 'all'); 
    mean_gyro = mean(gyro_data, 'all');   
    mean_mag = mean(mag_data, 'all');    
    
    % Detect Steps (Simple Peak Detection)
    threshold = 1.5;  % Adjust threshold if needed
    steps = sum(accel_data(:,1) > threshold);  
    
    % Display Data
    disp(['📊 Acceleration: ', num2str(mean_accel)]);
    disp(['🌀 Gyroscope: ', num2str(mean_gyro)]);
    disp(['🧲 Magnetometer: ', num2str(mean_mag)]);
    disp(['🚶 Steps: ', num2str(steps)]);
    
    % Send data to ThingSpeak
    response = webwrite('https://api.thingspeak.com/update', ...
        'api_key', writeAPIKey, ...
        'field1', mean_accel, ...
        'field2', mean_gyro, ...
        'field3', mean_mag, ...
        'field4', steps);
    
    disp(['✅ ThingSpeak Response: ', num2str(response)]);

    % Pause for 15 seconds (ThingSpeak free version limitation)
    pause(15);
end

% Stop Logging Data
m.Logging = false;

% Update ThingSpeak with latest values
writeAPIKey = '12DDX46ACYLY6GR9'; % Replace with your actual key
response = webwrite('https://api.thingspeak.com/update', ...
    'api_key', writeAPIKey, ...
    'field1', mean(accel_data(:)), ...
    'field2', mean(gyro_data(:)));

disp(['ThingSpeak Response: ', num2str(response)]);

