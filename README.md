# FT-SRL-Quadcopter

This is a temporary repository for the reviewing process of paper: Junkai Tan, Shuangsi Xue, et al. ``Finite-time Safe Reinforcement Learning Control of Multi-player Nonzero-sum Game for Quadcopter Systems``(Submitted to Information Sciences)

![structure](hardware_V2.png)
## Implementation

Hardware experiments were conducted using an X150 quadcopter with:
- RK3566 processor (1.80 GHz)
- 4 GB RAM
- Position tracking via 8-camera OptiTrack system

The experimental setup includes:
- Two-player nonzero-sum game for 3D trajectory tracking
- FT safe optimal controllers computed on workstation (Intel i7-12700 CPU, 32 GB RAM)
- 30 Hz control frequency (Δt ≈ 0.033s)
- Control inputs as velocity commands via 5GHz WiFi

## Structure
The data folder contains the experimental data used in the paper. The code folder contains the Matlab code for the FT-SRL algorithm and the quadcopter control.

![structure](data.jpg)


![structure](code.jpg)