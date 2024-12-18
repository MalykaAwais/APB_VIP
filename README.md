# APB_VIP
## Verification of APB VIP

---

## Overview
This project focuses on the verification of the Advanced Peripheral Bus (APB) using the Universal Verification Methodology (UVM). It aims to ensure effective communication between low-bandwidth peripherals in complex System-on-Chip (SoC) architectures.

---

## Team Members
- Malyka Awais (Team Leader)  
- Muhammad Waqar (Team Member)  
- Malik Nauman (Team Member)  

**Supervised By:** Muhammad Bilal

---

## Problem Statement
The project targets the verification of master and slave Universal Verification Components (UVCs) for the AMBA APB protocol. The challenge is to confirm adherence to the protocol amidst increasing complexity in designs.

## Aims and Objectives
- **Aim:** Create a comprehensive verification environment for the AMBA APB protocol.
- **Objectives:**
  - Develop a robust UVM-based verification environment.
  - Design comprehensive test cases covering various scenarios.
  - Verify both master and slave components for protocol compliance.
  - Enhance reusability of verification components.

## Verification Plan
The verification plan consists of a series of tests, including:
1. Reset Test
2. Write Test
3. Read Test
4. Read After Write
5. Idle Cycle Insertion
6. Address Misalignment
7. Data Corruption Test
8. Burst Transfers

---

## Technologies & Tools
![SystemVerilog](https://img.shields.io/badge/-SystemVerilog-3776AB?style=flat-square&logo=systemverilog&logoColor=white)
![UVM](https://img.shields.io/badge/-UVM-3776AB?style=flat-square&logo=uvm&logoColor=white)
![Cadence Xcelium](https://img.shields.io/badge/-Cadence_Xcelium-00599C?style=flat-square&logo=cadence&logoColor=white)

---

## Results
All assertions passed successfully. The coverage report indicates:
- Overall Average Grade: 76.72%
- Overall Covered: 9040 / 23698 (38.15%)
- Functional Coverage Grade: 59.5%

## Conclusion
The project successfully verified the master and slave UVCs of the APB protocol, demonstrating a flexible and reusable VIP design. The integration of optional features enhances the capabilities of the verification environment.
