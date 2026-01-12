# 🧍 Human Fitness Monitoring Dashboard
**Real-time fitness tracking using MATLAB Mobile & ThingSpeak**

🏆 **Best MATLAB Usage Award**  
Awarded during *“MATLAB for AI, Data Analytics, and IoT”* workshop series.

---

## 📌 Problem Statement
With the rise of wearable and mobile health monitoring, there is a need for a **simple, low-cost system** to track basic fitness parameters like motion activity and step count using commonly available devices.

---

## 🎯 Objective
To design a **real-time human fitness monitoring system** that:
- Collects motion sensor data from a smartphone
- Estimates step count using signal processing
- Visualizes data on a cloud-based IoT dashboard

---

## 🧠 System Workflow
1. Smartphone sensors collect motion data using MATLAB Mobile  
2. Data is processed in MATLAB (filtering & step detection)  
3. Extracted features are uploaded to ThingSpeak  
4. Live visualization is displayed on a cloud dashboard  

*(Add a block diagram image here if possible)*

---

## 📌 Features
- 📱 Live sensor data collection (Accelerometer, Gyroscope, Magnetometer)
- 🚶 Step detection using peak-based logic
- 🌐 IoT cloud integration using ThingSpeak
- 📊 Real-time dashboard visualization
- ⚙️ Implemented fully in MATLAB (no external hardware)

---

## 🛠 Tools & Technologies
- **MATLAB Mobile** – Sensor data acquisition  
- **MATLAB** – Signal processing & analysis  
- **ThingSpeak** – IoT cloud & dashboard  
- **Smartphone sensors**

---

## 📊 Output Preview## 
![ThingSpeak Dashboard](assets/dashboard.png)

---

## ⚙️ How to Run
1. Install **MATLAB Mobile** on your smartphone
2. Enable motion sensors in the app
3. Connect MATLAB Mobile to MATLAB Desktop
4. Run the MATLAB scripts in this repository
5. Configure your ThingSpeak **Write API Key**
6. View real-time data on the ThingSpeak dashboard

---

## 📄 Sample Code
```matlab
% Step detection
threshold = 1.5;
steps = sum(accel_data(:,1) > threshold);

% Upload to ThingSpeak
webwrite('https://api.thingspeak.com/update', ...
    'api_key', writeAPIKey, ...
    'field1', mean_accel, ...
    'field2', mean_gyro, ...
    'field3', mean_mag, ...
    'field4', steps);
