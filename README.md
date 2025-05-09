# Duck Car Controller Design

## Overview

This project involves designing a "Duck car" control system that stops at a predetermined distance from an obstacle using an infrared sensor. The system uses a PD (Proportional-Derivative) controller to minimize oscillations and ensure smooth stopping behavior. The compensator was modeled and simulated in MATLAB to optimize performance before implementation in hardware.

## Features

- **Obstacle Detection**: Infrared sensor measures the distance to obstacles.
- **Distance Control**: The Duck car stops at a specified distance with minimal oscillation.
- **PD Controller**: A Proportional-Derivative controller ensures smooth stopping with minimal overshoot.
- **System Modeling**: The sensor and motor systems were characterized before designing the controller.

## System Components

### 1. Infrared Sensor
The infrared sensor detects obstacles and converts the distance to a voltage signal. The sensor's transfer function was determined using experimental data at 17 cm.

### 2. Motor (Plant)
The motor is responsible for driving the Duck car. Its open-loop velocity response was used to model the motor as a first-order system with the transfer function:

![Motor TF](https://github.com/sumaJonathan/engs26-final-project/blob/main/images/transferfxn_image.png)

### 3. PD Controller
A PD controller was designed to address performance issues such as overshoot and slow response. The controller was tuned to meet the following design specifications:

- **Settling Time (Ts)**: < 1 sec
- **Steady-State Error (e_ss)**: < 15%
- **Overshoot (Mp)**: < 10%

## System Modeling and Analysis

### Sensor Modeling

The infrared sensor was characterized by measuring the voltage output at various distances. The data was fitted to a decaying exponential curve to determine the sensor's transfer function. The sensor gain at 17 cm was calculated as K_s = -6.08 V/m.

### Motor Characterization
The motor's velocity response was characterized by applying step inputs of 2V, 3V, and 4V. The motor was modeled as a first-order system, and the transfer function was derived as illustrated in the report.

### Stability Analysis
The system's stability was analyzed using MATLAB's sisotool. The root locus, step response, and frequency response plots indicated a stable system with good phase margin and gain margin, but performance improvements were necessary for faster response and minimal overshoot. The figure below shows the initial SISO plots modeling the uncompensated system:
![siso plot](https://github.com/sumaJonathan/engs26-final-project/blob/main/images/Initial_siso_plots.png)

### Compensator Design
A PD controller was designed to compensate for the system's behavior, improving its settling time and minimizing overshoot. The controller's performance was evaluated using simulations to ensure it met the design criteria first before building the circuit using the projected R and C values. The op amp used make the PD controller is shown in the figure below:
![PD circuit](https://github.com/sumaJonathan/engs26-final-project/blob/main/images/final_PD_circuit.png)

Upon testing this set up, we observed jitter and a high pitched humming sound, especially when we run the car on smoother surfaces. After consultation, we decided added a low-pass filter to the PD circuit which attenuated high frequencies and reduced vibration (refer to image below).
![Low pass filter](https://github.com/sumaJonathan/engs26-final-project/blob/main/images/low_pass_filter_circuit.png)

It is worth noting that addition of the filter not only reduced jitter but also improved the car's response to input, making it quick and smooth.

![Final Block Diagram](https://github.com/sumaJonathan/engs26-final-project/blob/main/images/full_circuit_block_diag.png)

For a deeper analysis of the system, please refer to the final report.

## Future Improvements
- Enhance the sensor calibration for more accurate distance readings.
- Implement additional controllers to handle different speeds or distances.
- Improve the robustness of the system in different environmental conditions.

---
