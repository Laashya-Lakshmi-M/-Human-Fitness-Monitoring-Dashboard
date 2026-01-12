% =========================================================
% Human Fitness Monitoring Dashboard
% Author: Lasshya Lakshmi M.
%
% Description:
% This script collects real-time motion sensor data from a
% smartphone using MATLAB Mobile, estimates step count, and
% uploads processed values to ThingSpeak for visualization.
% =========================================================

clc; clear; close all;

%% ThingSpeak Configuration
% Replace these with your own ThingSpeak credentials
writeAPIKey = '12DDX46ACYLY6GR9';   % Write API Key
readAPIKey  = 'YRE13GX8H06T8T97';   % Read API Key
channelID   = 2879601;             % Channel ID

%% Mobile Sensor Setup
% Connect to MATLAB Mobile
m = mobiledev;

% Enable required sensors
m.AccelerationSensorEnabled     = true;
m.AngularVelocitySensorEnabled  = true;
m.MagneticFieldSensorEnabled    = true;

% Start logging sensor data
m.Logging = true;

disp("📡 Collecting sensor data... Move your phone!");

%% Continuous Data Acquisition Loop
while true
    
    % ---------------------------------
    % Read sensor data from smartphone
    % ---------------------------------
    accel_data = m.Acceleration;        % Accelerometer data (m/s^2)
    gyro_data  = m.AngularVelocity;     % Gyroscope data (rad/s)
    mag_data   = m.MagneticField;       % Magnetometer data (µT)
    
    % ---------------------------------
    % Feature extraction (mean values)
    % ---------------------------------
    mean_accel = mean(accel_data, 'all');
    mean_gyro  = mean(gyro_data, 'all');
    mean_mag   = mean(mag_data, 'all');
    
    % ---------------------------------
    % Step Detection (Simple Threshold)
    % ---------------------------------
    threshold = 1.5;  % Threshold for detecting steps
    steps = sum(accel_data(:,1) > threshold);
    
    % ---------------------------------
    % Display computed values
    % ---------------------------------
    disp(['📊 Mean Acceleration: ', num2str(mean_accel)]);
    disp(['🌀 Mean Gyroscope: ', num2str(mean_gyro)]);
    disp(['🧲 Mean Magnetometer: ', num2str(mean_mag)]);
    disp(['🚶 Estimated Steps: ', num2str(steps)]);
    
    % ---------------------------------
    % Upload data to ThingSpeak cloud
    % ---------------------------------
    response = webwrite('https://api.thingspeak.com/update', ...
        'api_key', writeAPIKey, ...
        'field1', mean_accel, ...
        'field2', mean_gyro, ...
        'field3', mean_mag, ...
        'field4', steps);
    
    disp(['✅ ThingSpeak Update Status: ', num2str(response)]);
    
    % Pause due to ThingSpeak free-tier limitation
    pause(15);
end

%% Stop Logging (Executed when loop is terminated)
m.Logging = false;
