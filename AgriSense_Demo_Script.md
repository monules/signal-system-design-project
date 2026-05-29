# AgriSense: Balanced Presentation Script
**Duration:** 20-25 Minutes | **Speakers:** 6 People | **Word Count:** ~500-600 words per speaker

---

## **Speaker 1: The Vision & Scenario (Signal Integrity in Smart Farming)**

**[CUE: Show the AgriSense "Home" and "All Fields" screenshots]**

"Good morning everyone. Today, our team is excited to present **AgriSense: A High-Precision Signal Monitoring and Control System**. Our project addresses a critical challenge in modern precision agriculture: ensuring sensor data is accurate enough for automated decision-making.

In smart greenhouses, such as those in the Baku and Bilasuvar regions of Azerbaijan, farmers rely on IoT sensors to monitor soil moisture and temperature. However, these sensors operate in a 'noisy' environment. They are surrounded by high-voltage fans, water pumps, and fluctuating power lines that create severe electromagnetic interference (EMI). If a sensor's reading is corrupted by this noise, an automated system might over-water or under-water the crops, leading to significant loss.

AgriSense is our solution. We have built an end-to-end mathematical engine in MATLAB that cleans, analyzes, and validates agricultural data using the core principles of Signals and Systems: LTI Systems, Fourier Representation, and Laplace Transforms. 

Over the next 20 minutes, we will walk you through the signal's lifecycle. We will show how we simulate these sensors, how we use convolution to scrub away noise, how we use Fourier analysis to identify interference, and how we use Laplace transforms to ensure irrigation stability. I will now hand it over to [Speaker 2] to discuss our signal modeling and the Nyquist theory."

---

## **Speaker 2: Mathematical Modeling & Sensor Simulation**

**[CUE: Open AgriSense_Live_Dashboard.m and highlight the 'get_moisture_data' function]**

"Thank you. To build a robust system, we first had to create a mathematical model of a greenhouse. In our MATLAB code, we defined our moisture signal as a low-frequency sine wave: `base = 40 + 5*sin(2*pi*0.1*t)`. This represents the natural, slow fluctuation of moisture throughout a day.

To make the simulation realistic, we added high-frequency interference. We modeled deterministic noise from a greenhouse fan using `noise_amp * sin(2*pi*30*t)` and random thermal noise using the `randn` function. When we add these together, we get the 'noisy' red line seen on our dashboard.

Crucially, we must follow the **Nyquist-Shannon Sampling Theorem**. In our code, we use `t = linspace(0, 10, 1000)`, giving us a 100 Hz sampling rate. Since our noise is at 30 Hz, we are sampling at more than twice the highest frequency, ensuring we capture the interference without aliasing. If we relied on this raw red signal, our irrigation valves would flicker rapidly, damaging the hardware. [Speaker 3] will now explain how we use LTI systems and convolution to recover the 'Clean' signal you see in blue."

---

## **Speaker 3: Time-Domain Processing & LTI Convolution**

**[CUE: Highlight the 'Filter Signal' section in the code and point to the blue line]**

"Thank you. To clean the signal, we implemented a Linear Time-Invariant (LTI) system. An LTI system is characterized by its **Impulse Response**, $h[n]$. We designed a 'Moving Average Filter' that looks at a window of 30 samples to average out the jitter.

Mathematically, we use the **Convolution** sum: $y[n] = \sum x[k]h[n-k]$. In MATLAB, this is achieved with the command `clean = conv(noisy, h, 'same')`. We convolve our noisy input with the impulse response to produce the smooth blue line you see on the dashboard. 

This system is 'Linear' because it treats signals proportionally, and 'Time-Invariant' because it applies the same filtering logic regardless of when the data is received. As you can see, the convolution successfully averages out the high-frequency spikes while preserving the slow-moving moisture trend. However, to prove *why* this works, we must leave the time domain. [Speaker 4] will now show you our frequency-domain analysis using the Fourier Transform."

---

## **Speaker 4: Fourier Analysis & Spectral Fingerprinting**

**[CUE: Point to the 'Fourier FFT' plot and the 'fft' function in the code]**

"Thanks. While we can see the noise in the time domain, we can only understand its origin in the **Frequency Domain**. We use the **Fast Fourier Transform (FFT)** to decompose our signal into its individual frequency components.

In our code, we use `Y = fft(noisy)` and calculate the magnitude using `abs(Y/L)`. If you look at the bottom-left plot on the dashboard, you can see a massive spike at exactly 30 Hertz. This confirms our theory: the 'noise' is actually a mechanical hum from a nearby fan.

This Fourier analysis justifies our use of a Low-Pass filter. We can see that our actual moisture data is near 0.1 Hertz, while the noise is way up at 30 Hertz. By identifying this 'spectral fingerprint,' we can verify that our LTI filter is removing the interference without destroying the actual agricultural data. Now that we have clean data, we can finally act on it. [Speaker 5] will explain how we control the irrigation pump itself using Laplace transforms."

---

## **Speaker 5: Laplace Transforms & Irrigation Stability**

**[CUE: Point to the 'Pole-Zero Map' and the 'tf' function in the code]**

"Thank you. Once we have a clean signal, we must control the water pump. However, physical systems can become unstable if controlled too aggressively. To analyze this, we use the **Laplace Transform**, which converts differential equations into algebraic ones in the S-domain.

We modeled the pump and soil as a second-order LTI system with the Transfer Function: `sys = tf(num, den)`. To ensure the pump operates safely, we look at the **Poles** of the system. 

On the bottom-right of the dashboard is our **Pole-Zero Map**. For a system to be stable, its poles must lie in the Left-Half Plane. If the user increases the 'Irrigation Gain' too much, the poles move toward the imaginary axis, causing the system to oscillate. Our code monitors these poles using the `pole(sys)` command. If they approach the dangerous Right-Half Plane, AgriSense declares the system 'Unstable' to prevent equipment damage. [Speaker 6] will now wrap up with a live demonstration."

---

## **Speaker 6: Live Interaction & AgriSense Conclusion**

**[CUE: Start moving the Sliders on the Live Dashboard interactively]**

"Thank you. Let’s see all of this theory in action. Notice what happens when I increase the **'Sensor Noise Intensity'** slider. The red line becomes chaotic, and the peak at 30 Hz in our Fourier Spectrum rises. Yet, notice that the blue 'Filtered' line remains steady. This is our LTI Convolution in action, protecting the data in real-time.

Next, look at the **'Irrigation Gain'**. As I push the gain higher, watch the **Status Notification**. Our Laplace engine instantly recalculates the poles, sees the instability, and warns us: 'System Unstable! Adjust Gain.' 

In conclusion, AgriSense demonstrates the power of Signals and Systems in the real world. We used **Signal Simulation** to model the greenhouse, **LTI Convolution** to clean the data, **Fourier Transforms** to analyze interference, and **Laplace Transforms** to ensure stability. We have turned complex math into a robust, life-saving tool for agriculture. Thank you for your time, we are now open for questions."

---
**[END OF BALANCED SCRIPT]**
