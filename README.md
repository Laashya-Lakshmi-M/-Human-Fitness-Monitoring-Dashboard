# -Human-Fitness-Monitoring-Dashboard
Real-time fitness tracking system using MATLAB Mobile and ThingSpeak

🏆 Achievement
🏅 Best MATLAB Usage Award
Awarded during the workshop series “MATLAB for AI, Data Analytics, and IoT”.


# 🧍 Human Fitness Monitoring Dashboard

This project demonstrates a real-time human fitness monitoring system using **MATLAB Mobile**, **MATLAB Desktop**, and **ThingSpeak**. It collects motion-related data like acceleration, angular velocity, and magnetometer readings from your smartphone and estimates steps, uploading all metrics live to ThingSpeak for visualization.

---

## 📌 Features

- 📱 Collects live sensor data from mobile (accelerometer, gyroscope, magnetometer)
- 🚶 Detects step activity using simple peak-based logic
- 🌐 Uploads data to **ThingSpeak IoT Cloud**
- 📊 Real-time cloud dashboard for visualization
- ⚙ Built entirely using **MATLAB** scripting

---

## 🛠 Tools & Technologies Used

- MATLAB Mobile (sensor data logging)
- MATLAB (data processing + visualization)
- ThingSpeak (cloud platform)
- Smartphone sensors

---

## ⚙️ How It Works

1. MATLAB Mobile connects your phone's motion sensors to MATLAB.
2. Acceleration, angular velocity, and magnetic field data are collected.
3. Basic peak detection estimates the number of steps taken.
4. All sensor averages and step count are uploaded to **ThingSpeak** every 15 seconds.

---

## 📄 Sample Code Snippet

```matlab
% Step detection
threshold = 1.5;
steps = sum(accel_data(:,1) > threshold);

% ThingSpeak Upload
webwrite('https://api.thingspeak.com/update', ...
    'api_key', writeAPIKey, ...
    'field1', mean_accel, ...
    'field2', mean_gyro, ...
    'field3', mean_mag, ...
    'field4', steps);
