# Arduino Ultrasonic Sensor

## Table of Contents

1. [Overview](#overview)
2. [Hardware Components](#hardware-components)
3. [Pin Mapping](#pin-mapping)
4. [How to Run](#how-to-run)


## Overview

Project that scans the environment and displays data visually. How it's done:
* The environment is scanned 180 degrees horizontally by servo motor and to read the distance to the objects (scan the environment) in the "effective detection range" project uses ultrasonic sensor HC-SR04.   
* To do those actions project utilizes Arduino board programmed in C++ (via Arduino IDE).
* Data is displayed visually via Processing. 

Note: By "effective detection range" I mean distance 2 - 40 cm. HC-SR04 can sense up to 400 cm but I configured it's detection range for the project needs.


## Hardware Components 

| Component | Quantity | Comments |
| ---- | ----- | ----- |
| Arduino Uno R3 | 1 | It is possible to use different Arduino board |
| Ultrasonic sensor HC-SR04 | 1 | To measure distance to the object |
| Servo motor | 1 | To move ultrasonic sensor |
| Breadboard | 1 | - |
| Jumper wires | - | - |


## Pin Mapping

| Component | Arduino pin | Comments |
| ---- | ----- | ----- |
| Ultrasonic sensor's Trig pin | 12 | - |
| Ultrasonic sensor's Echo pin | 11 | - |
| Servo motor | 8 | - |


## How to Run

### Step 1

Install and launch an IDE capable of compiling and uploading Arduino code (e.g., [Arduino IDE](https://www.arduino.cc/en/software/)). Additionaly you have to install [Processing](https://processing.org/download) (for visual display).

### Step 2 

Connect all components according to the pin mapping above. 

### Step 3 

Connect your board to the PC. Upload C++ to Arduino first, then run the Processing sketch on your PC.
