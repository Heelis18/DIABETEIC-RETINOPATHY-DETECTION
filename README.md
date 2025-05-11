# DIABETEIC-RETINOPATHY-DETECTION
Diabetic Retinopathy & Macular Hole Detection using Image Processing

 Project Overview

This final year engineering project focuses on the **automated detection of Diabetic Retinopathy (DR)** and **Macular Hole** using **retinal fundus images**. The system employs advanced **image processing techniques** and **embedded integration** to identify disease presence and its severity. The innovation lies in combining traditional image enhancement algorithms with embedded hardware for real-time disease analysis.

 Objective

To develop a system that:
- Detects Diabetic Retinopathy and Macular Hole from retinal images.
- Determines the **severity** of DR.
- Integrates **image processing** with **embedded systems** for enhanced medical diagnostics.

 Key Features

- ✅ Automated fundus image preprocessing and enhancement.
- ✅ Disease identification using Haar Wavelet Transform and morphological operations.
- ✅ Classification of severity levels.
- ✅ Real-time embedded hardware alert system using Arduino UNO, GSM, LCD, and buzzer.

 Tech Stack

Software
- MATLAB 2013(a) – Image processing and disease prediction algorithms.
- Embedded C – Integration with hardware components.

Hardware
- Arduino UNO
- GSM Module
- LCD Display
- Buzzer
- Power Supply Unit

 Methodology

Proposed Image Processing Steps
- Normalization
- Contrast Enhancement
- Haar Wavelet Transform
- Morphological Operations

Embedded System Block
- Sensor Input → Arduino UNO → GSM + Alert Mechanism (LCD + Buzzer)

 How to Run the Project

 MATLAB:
1. Open the `.m` file in MATLAB 2013(a).
2. Load the fundus image dataset.
3. Run the preprocessing and classification scripts.
4. View the detection output (Normal / Moderate / High Severity).

 Arduino:
1. Upload the Embedded C program to Arduino UNO.
2. Connect the hardware (GSM, LCD, Buzzer).
3. Trigger alerts based on image analysis outcome from MATLAB.

 Sample Outputs

> Add screenshots of:
> - Fundus image input
> - Disease detected output
> - Hardware setup
> - LCD/GSM alert

References

- Waleed Nazih et al. (IEEE 2023), *Vision Transformer for DR Severity Prediction*
- Mohammad Z. Atwany et al. (IEEE 2022), *Deep Learning for DR Classification*
- Archana Senapati et al. (Elsevier 2020), *AI for DR Detection – Systematic Review*
- Marwan D. Saleh et al. (2012), *Automated Decision Support for NPDR*


 License

This project is for academic and educational purposes only.



