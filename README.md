# FT-SRL-Quadcopter

<!-- # Repository for "Finite-time Safe Reinforcement Learning Control of Multi-player Nonzero-sum Game for Quadcopter Systems" -->

This repository contains the code and experimental data for our paper: ["Finite-time Safe Reinforcement Learning Control of Multi-player Nonzero-sum Game for Quadcopter Systems"](https://www.sciencedirect.com/science/article/pii/S002002552500249X) published in the *Information Sciences* journal (March 2025).

+ Details of the paper can be found at: [Junkai Tan's Publications](https://tanjunkai2001.github.io/publications/)
+ Download the paper at: [Download pdf](https://tanjunkai2001.github.io/assets/Finite-time%20Safe%20Reinforcement%20Learning%20Control%20of%20Multi-player%20Nonzero-Sum%20Game%20for%20Quadcopter%20Systems.pdf)

## Citation

If you use this code or find our research helpful, please cite our paper:

```bibtex
@article{Tan2025,
    author = {Tan, Junkai and Xue, Shuangsi and Guan, Qingshan and Qu, Kai and Cao, Hui},
    title = {Finite-time Safe Reinforcement Learning Control of Multi-player Nonzero-sum Game for Quadcopter Systems},
    journal = {Information Sciences},
    year = {2025},
    month = {March},
    doi = {10.1016/j.ins.2025.122117},
    url = {https://doi.org/10.1016/j.ins.2025.122117}
}
```

## Overview

This project implements a finite-time safe reinforcement learning approach for quadcopter control systems in a multi-player nonzero-sum game framework. The implementation includes both hardware experiments and simulation code.

![structure](unmanned_systems_control2.png)
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