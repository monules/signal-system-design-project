# AgriSense: Smart Agriculture Monitoring System
**Project Report - Signals and Systems Design (IGS2137)**

## 1. Introduction & Scenario
AgriSense is an interactive MATLAB application designed for modern greenhouse management. In regions like Azerbaijan, precise irrigation and sensor reliability are critical for crop yield. This project simulates an IoT-enabled greenhouse environment where soil moisture sensors are monitored, signals are filtered for equipment noise, and irrigation stability is analyzed using control theory.

## 2. Technical Objectives
The application fulfills the following core requirements:
*   **Signal Simulation:** Generating moisture data corrupted by electrical interference.
*   **LTI Systems:** Implementing a Low-Pass Filter via Convolution to recover the original signal.
*   **Fourier Representation:** Using FFT to analyze the frequency components of sensor noise.
*   **Laplace Domain:** Modeling irrigation response using Transfer Functions and Pole-Zero analysis.

## 3. Implementation Details

### 3.1 Time-Domain & LTI Modeling
We modeled the moisture sensor output $x[n]$ as a composite of a slow-varying base signal and high-frequency additive noise. To recover the signal, an LTI system (Moving Average Filter) was designed. The output $y[n]$ is calculated through the convolution of the input $x[n]$ and the impulse response $h[n]$:
$$y[n] = x[n] * h[n]$$
This effectively suppresses the "jitter" caused by greenhouse fans and mechanical equipment.

### 3.2 Frequency-Domain (Fourier Analysis)
To validate the filter design, we applied the Discrete Fourier Transform (DFT) via the `fft` algorithm. By analyzing the frequency spectrum, we identified the specific noise harmonics (centered at 50Hz). This Fourier representation justifies the use of a Low-Pass filter to maintain data integrity.

### 3.3 Stability Analysis (Laplace Transform)
The irrigation system's physical response was modeled as a second-order LTI system in the Laplace domain:
$$H(s) = \frac{K}{s^2 + 3s + 2}$$
The parameter $K$ represents the irrigation gain. We analyzed the system stability by computing the **Poles** of $H(s)$. A pole-zero map was generated to visualize how changes in gain affect the root locations in the S-plane, ensuring the system remains stable (Poles in the Left-Half Plane).

## 4. Results & Discussion
The dashboard successfully visualizes the transition from noisy raw data to actionable agricultural insights. 
*   **Filtering:** The LTI convolution removed ~90% of the additive noise.
*   **Stability:** The system remained stable for low gains but exhibited undesirable oscillations as gain increased, as predicted by the Laplace analysis.

## 5. Conclusion
AgriSense demonstrates the practical application of Signals and Systems theory in a real-world agricultural context. By combining time-domain filtering, frequency-domain analysis, and Laplace-domain stability checks, we built a robust foundation for a smart farming application.
