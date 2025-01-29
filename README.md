# FT-SRL-Quadcopter

This is a temporary repository for the reviewing process of paper: Junkai Tan, Shuangsi Xue, et al. ``Finite-time Safe Reinforcement Learning Control of Multi-player Nonzero-sum Game for Quadcopter Systems``(Submitted to Information Sciences)

![structure](hardware_V2.png)
## Implementation
Hardware setup:
- X150 quadcopter with RK3566 (1.80 GHz) processor and 4GB RAM
- OptiTrack system (8 cameras) for position tracking
- Control inputs via 5GHz WiFi at 30 Hz
- Controllers computed on i7-12700 workstation

## Structure
The data folder contains the experimental data used in the paper. The code folder contains the Matlab code for the FT-SRL algorithm and the quadcopter control.

![structure](data.jpg)


![structure](code.jpg)