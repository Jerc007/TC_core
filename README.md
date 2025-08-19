#  TC_core

*RTL Low-level micro-architecture description of the datapath of Tensor Cores (Tensor Core Units, or Matrix Cores)*

---

## 🧩 Overview

This repository collects several fundamental blocks used in the Datapath of Tensor Core units (an in-chip hardware accelerator commonly found in GPUs and processors) [ [1] ](https://www.computer.org/csdl/proceedings-article/ispass/2019/08695642/19wBevIF5T2) [ [2] ](https://patents.google.com/patent/US10338919B2/en) [ [3] ](https://ieeexplore.ieee.org/abstract/document/9007413)

A Tensor Core Unit (TCU), also referred to as a Matrix Core, is a Domain-Specific Architecture (DSA) designed to accelerate **mxnxk** matrix multiplications and serves as a fundamental building block in modern AI accelerators, commonly integrated into today’s processors and GPUs. At their core, they execute the fused matrix operation:

![Equation](https://latex.codecogs.com/svg.image?&space;D=A\times&space;B&plus;C)


where A and B are the input matrices with shapes (**mxk**) and (**kxn**), respectively. Moreover, C and D, with (**nxm**) shapes, represent the accumulation and output matrices, respectively.


in single-precision floating point (FP32).


As shown in Figure 10, the TCU under study is composed of 16 Dot-Product Units (DPUs). Each DPU contains a layer of multipliers followed by multiple layers of FP32 adders, forming the pipeline that performs high-throughput matrix multiplications. Importantly, every FP32 adder and multiplier is itself built from lower-level components such as shifters, lead-zero counters (LZCs), and integer adders/multipliers, illustrating the hierarchical design complexity of the accelerator.






The synthesizable VHDL IP cores are designed for ease of integration as a coprocessor or accelerator on Processor-based systems.

Ideal for [your use case: e.g., embedded systems, SoC design, digital signal processing], it offers:

<!--- ✅ Standards-compliant design ([e.g., AXI4-Lite, AMBA, Wishbone]) -->
- 🔧 Configurable parameters
- 🧪 Fully testbenched with simulation support
- 📚 Clean documentation with example integrations

---




# 🎲 Additional documentation


- [Analyzing the Impact of Different Real Number Formats on the Structural Reliability of TCUs in GPUs](https://ieeexplore.ieee.org/document/10321881)

## 📁 Directory Structure


![License](https://img.shields.io/github/license/your-username/your-repo-name)
![Build](https://img.shields.io/github/actions/workflow/status/your-username/your-repo-name/ci.yml)
![Version](https://img.shields.io/github/v/release/your-username/your-repo-name)









