# AgriSense: Comprehensive Master Presentation Script
**Duration:** 30 - 40 Minutes | **Speakers:** 6 People | **Word Count:** ~800+ words per speaker

---

## **Speaker 1: The AgriSense Vision, Hardware Context, and Project Scope**

**[CUE: Show the AgriSense "Home" and "All Fields" screenshots from your hackathon app]**

"Good morning, esteemed professor, colleagues, and guests. Today, our team is incredibly proud to introduce you to our capstone project: **AgriSense: A High-Precision Signal Monitoring and Control System for Smart Agriculture**. 

Before we dive into the mathematics, MATLAB code, and system architecture, I want to set the stage by discussing the real-world crisis that AgriSense is designed to solve. Globally, agriculture consumes about 70% of the world’s freshwater resources. In arid and semi-arid regions—such as the Absheron Peninsula and the broader agricultural zones of Azerbaijan—water scarcity is an imminent threat to food security and economic stability. To combat this, the agricultural sector is undergoing a massive paradigm shift known as 'Precision Agriculture' or 'Smart Farming.' This involves deploying hundreds of Internet of Things (IoT) sensors across greenhouses and open fields to monitor environmental variables like soil moisture, ambient temperature, humidity, and chemical nutrient levels. 

However, transitioning from traditional farming to a digital, sensor-driven ecosystem introduces a critical engineering hurdle: **Signal Integrity.** In a modern, industrial-scale greenhouse, sensors do not operate in a vacuum. A typical soil moisture sensor—often a capacitive or resistive probe buried in the dirt—is surrounded by a highly hostile electromagnetic environment. Right next to these sensitive analog-to-digital converters, you have massive, high-voltage industrial equipment. You have ventilation fans spinning at thousands of RPMs, heavy-duty water pumps pushing hundreds of gallons per minute, and unshielded power lines carrying alternating current throughout the facility. 

All of this machinery generates severe electromagnetic interference (EMI) and mechanical vibrations. When a moisture sensor attempts to read the dielectric permittivity of the soil to determine its water content, that delicate analog voltage is corrupted by the surrounding electrical noise. 

Let’s imagine a specific, catastrophic scenario. A farmer’s central control computer is programmed to open the irrigation valves whenever the soil moisture drops below 38%. The actual physical moisture of the soil is perfectly fine, hovering comfortably at 42%. However, an exhaust fan turns on nearby, inducing a high-frequency alternating current into the sensor's unshielded wiring. The sensor's signal begins to fluctuate wildly, experiencing spikes that drop the registered value down to 35% for a fraction of a second. The automated system reads this corrupted data, assumes the field is experiencing a severe drought, and triggers the massive irrigation pumps. Over the next hour, thousands of gallons of precious water are wasted, the crop's root systems are drowned, leading to root rot, and the farmer incurs massive financial losses. 

This is not a software engineering problem that can be solved with a simple 'if/else' statement. This is fundamentally a **Signals and Systems** problem. We cannot simply trust the raw output of a sensor. We must treat the sensor's output as a continuous-time signal that has been corrupted by additive noise, and we must apply rigorous mathematical filtering to recover the true state of the physical world.

This is exactly what AgriSense does. We have built an end-to-end mathematical engine in MATLAB that serves as the brain of a smart greenhouse. Our presentation today will take you through the entire lifecycle of an agricultural signal within our architecture, perfectly aligning with the core modules of our IGS2137 course.

First, [Speaker 2] will walk you through the mathematical modeling and simulation of our sensor signals, breaking down the exact MATLAB code we used to generate realistic baseline data superimposed with deterministic and stochastic noise. 
Second, [Speaker 3] will delve into Time-Domain processing, explaining how we defined an Impulse Response and utilized Linear Time-Invariant (LTI) systems—specifically the mathematical operation of convolution—to clean our corrupted signal.
Third, [Speaker 4] will take us out of the Time Domain and into the Frequency Domain. They will explain the underlying calculus of the Fast Fourier Transform (FFT) and demonstrate how we use spectral analysis to visually prove that our filter is targeting the correct interference harmonics.
Fourth, [Speaker 5] will transition us into Control Theory. Using Laplace Transforms and Transfer Functions, they will explain how we modeled the physical water pumps and soil dynamics to ensure that our automated system remains mathematically and physically stable, preventing catastrophic oscillations.
Finally, [Speaker 6] will tie all these complex mathematical domains together in a live, real-time demonstration of our custom-built MATLAB App Designer dashboard, showing how these theoretical concepts operate concurrently in a user-friendly interface.

By the end of this presentation, we hope to demonstrate not just our proficiency with MATLAB and Signals and Systems theory, but our ability to apply these profound mathematical concepts to solve real, pressing challenges in global food production. With that, I will now hand the floor over to [Speaker 2] to begin our technical deep dive into Signal Modeling."

---

## **Speaker 2: Mathematical Modeling, Nyquist Theory, & Sensor Simulation**

**[CUE: Open AgriSense_Live_Dashboard.m and highlight the 'update_dashboard' function where the signal is generated]**

"Thank you, [Speaker 1], for that excellent contextual overview. Before we can design filters and control systems, we need data. But because we are developing a software prototype, we couldn't simply go out and bury a sensor in a field. We had to rely on mathematical modeling to simulate a highly realistic, challenging signal environment. 

Let's look at the MATLAB code, specifically inside our core engine function where we generate the time-domain data. The very first thing we must establish is our time vector. In our code, you will see the line: `t = linspace(0, 10, 1000);`. 
This single line of code is loaded with signal processing theory. We are simulating 10 seconds of continuous time, but we are capturing it as 1000 discrete samples. This gives us a sampling frequency, $F_s$, of 100 Hertz (100 samples per second). Why did we choose 100 Hz? This brings us directly to the **Nyquist-Shannon Sampling Theorem**. The theorem states that in order to perfectly reconstruct a signal without aliasing, our sampling frequency must be at least twice the highest frequency component present in the signal ($F_s \geq 2 \cdot F_{max}$). As I will explain shortly, our highest noise frequency is 30 Hertz. Therefore, a sampling rate of 100 Hertz comfortably exceeds the Nyquist rate of 60 Hertz, ensuring our digital representation is a mathematically faithful reproduction of the analog world.

Now, let's look at the actual soil moisture model. We define our 'true' or 'clean' signal with the equation: `base = 40 + 5*sin(2*pi*0.1*t);`. 
What does this represent physically? The `40` is our DC offset; it means the baseline moisture of the soil is at 40%. The `5*sin(...)` component represents a very slow oscillation with an amplitude of 5% and a frequency of 0.1 Hertz. In a real greenhouse, moisture doesn't drop instantly; it evaporates slowly as the sun rises and increases slowly as the drip irrigation runs. This low-frequency sine wave perfectly mimics the smooth, physical reality of water moving through soil thermodynamics.

But as [Speaker 1] mentioned, the real world is never this clean. We must introduce **Additive Noise**. In signal processing, we deal with two primary types of noise: deterministic and stochastic. We modeled both.
First, we look at the deterministic interference: `noise_amp * sin(2*pi*30*t)`. This is a high-frequency periodic signal oscillating exactly at 30 Hertz. In our scenario, this represents electromagnetic interference from an unshielded ventilation fan motor operating nearby. Because it is tied to the physical rotation of a motor, its frequency is highly predictable, but its amplitude—controlled by our `noise_amp` variable—fluctuates based on how close the fan is to the sensor.
Second, we modeled stochastic, or random, noise using the code: `(noise_amp/3)*randn(size(t))`. The `randn` function in MATLAB generates normally distributed, Gaussian white noise. This represents the unpredictable thermal noise inherent in all electronic circuits, the random resistance changes in the soil, and minor atmospheric fluctuations. 

Finally, we apply the principle of **Superposition**. We create our final raw sensor reading by simply adding these components together: `noisy = base + noise;`. 
If you look at the top red graph on our dashboard, you are seeing the visual result of this equation. The underlying 0.1 Hertz sine wave is completely buried under the chaotic, high-frequency spikes of the 30 Hertz fan interference and the Gaussian static. The signal is incredibly volatile, varying by as much as 10% in a fraction of a second. 

If we feed this red line into a computer, it is useless. The computer will see a localized spike, assume the soil is dry, and turn on the water, only to see a spike in the opposite direction a millisecond later. We have successfully modeled a worst-case scenario for an IoT agriculture system. 

The question now becomes: how do we mathematically extract our 0.1 Hertz truth from this 30 Hertz garbage? The answer lies in the theory of Linear Time-Invariant systems. I will now hand it over to [Speaker 3], who will explain the calculus of Convolution and how we designed our time-domain filter."

---

## **Speaker 3: Time-Domain Processing, Convolution, & LTI Filtering**

**[CUE: Highlight the 'Filter Signal (LTI Convolution)' section in the MATLAB code]**

"Thank you, [Speaker 2]. We have our corrupted, noisy signal. Now we must clean it. To do this, we rely on the cornerstone of this entire course: the **Linear Time-Invariant (LTI) System**. 

Before we look at the code, let's establish what an LTI system actually is and why it is so powerful. A system is **Linear** if it obeys the principles of scaling and superposition. If an input of $x_1(t)$ yields $y_1(t)$, and $x_2(t)$ yields $y_2(t)$, then an input of $A \cdot x_1(t) + B \cdot x_2(t)$ must yield exactly $A \cdot y_1(t) + B \cdot y_2(t)$. This is crucial for AgriSense because our signal is literally an addition of a base signal and a noise signal. Linearity guarantees that our filter will treat these components predictably.
A system is **Time-Invariant** if a time shift in the input causes an identical time shift in the output. If we shift the input by $t_0$, the output is simply delayed by $t_0$, but its shape remains entirely unchanged. This is vital for a greenhouse: our filter must process a moisture reading at 2:00 PM exactly the same way it processes a reading at 4:00 AM. 

Because our digital filter is both Linear and Time-Invariant, we can mathematically completely characterize its behavior using a single function: its **Impulse Response**, denoted as $h[n]$. 

In our MATLAB code, we define our impulse response with two lines:
`window = 30;`
`h = (1/window)*ones(1, window);`
What is this doing? We are defining a **Moving Average Filter**. We create a vector of 30 elements, all of which are the number 1, and then we divide the entire vector by 30. This creates an impulse response where each of the 30 points has a weight of exactly $1/30$. 

To apply this filter to our noisy signal, we use the most important mathematical operation in LTI theory: **Convolution**. 
The discrete-time convolution sum is defined as:
$$y[n] = \sum_{k=-\infty}^{\infty} x[k] \cdot h[n-k]$$
In plain English, we take our impulse response $h$, flip it backwards, and slide it across our noisy input signal $x$, one sample at a time. At every step, we multiply the overlapping values and sum them up. Because our $h[n]$ is just a block of $1/30$ weights, the convolution operation is literally taking a 30-sample 'window' of the noisy signal, calculating the average, plotting a single point, and then sliding the window forward.

In MATLAB, this incredibly complex calculus is achieved in a single, elegant line of code:
`clean = conv(noisy, h, 'same');`
We use the `'same'` parameter to tell MATLAB to truncate the edges of the convolution so that our output array is the exact same length as our input array, allowing us to plot them directly on top of each other.

If you direct your attention to the Time Domain plot on our dashboard, look at the thick blue line. This is the output of our convolution, $y[n]$. It is astonishingly smooth. The high-frequency jagged edges of the red noise have been completely averaged out. Because the 30-Hertz fan noise oscillates up and down so rapidly, when we take an average over 30 samples, the positive spikes perfectly cancel out the negative spikes, resulting in zero net impact. Meanwhile, our slow 0.1-Hertz base moisture signal barely changes over 30 samples, so it passes through the filter completely unharmed. 

We have designed a highly effective **Low-Pass Filter**. We successfully blocked the high frequencies and passed the low frequencies. But seeing a smooth line isn't enough proof for rigorous engineering. We need to mathematically verify *why* this worked, and to do that, we must leave the realm of time and enter the realm of frequencies. I will now pass the presentation to [Speaker 4] to discuss the Fourier Transform."

---

## **Speaker 4: Fourier Analysis, Spectral Fingerprinting, & The FFT**

**[CUE: Point to the 'Fourier Analysis' section in the code and the bottom-left Frequency plot]**

"Thank you, [Speaker 3]. The time-domain convolution is impressive, but time-domain graphs can be deceiving. A smooth line looks nice, but how do we know we didn't accidentally filter out important physical data? How do we prove that our noise was actually caused by a fan, and not just random sensor errors? To answer these questions, we must transition into the **Frequency Domain** using **Fourier Analysis**.

The fundamental theorem of Joseph Fourier states that any complex, continuous, periodic waveform can be decomposed into an infinite sum of simple sine and cosine waves, each with a specific amplitude and phase. We use the Fourier Transform to take our noisy time-domain signal and 'unravel' it, plotting the amplitude of every single frequency that exists within it.

Because we are working with discrete digital samples in a computer, we use the **Discrete Fourier Transform (DFT)**, which is calculated using an incredibly optimized algorithm known as the **Fast Fourier Transform (FFT)**.

Let’s look at the MATLAB code where we perform this magic:
`L = length(noisy);`
`Y = fft(noisy);`
Here, `Y` is a vector of complex numbers containing the magnitude and phase information for our frequencies. But complex numbers are difficult to plot on a 2D graph, so we must calculate the absolute magnitude.
`P2 = abs(Y/L);`
We divide by `L` (the length of the signal) to normalize the amplitude so it matches the physical scale of our original data. Next, we run into a property of the FFT: it mirrors the frequency spectrum, providing both positive and negative frequencies. Since negative frequencies are just a mathematical mirror for real-world signals, we discard the second half of the array to focus only on the positive frequencies up to the Nyquist limit.
`P1 = P2(1:L/2+1);`
`P1(2:end-1) = 2*P1(2:end-1);`
We multiply the remaining values by 2 (except the DC offset at zero) to account for the energy we discarded from the negative half. Finally, we create our x-axis frequency vector:
`f = Fs*(0:(L/2))/L;`

Now, direct your attention to the **Noise Spectrum** plot on the bottom-left of the dashboard. This is the spectral fingerprint of our greenhouse. Look at the x-axis, which represents Frequency in Hertz. 
At the very left edge, near 0.1 Hertz, you see a solid peak. That represents the actual, physical soil moisture slowly fluctuating. 
But as you scan to the right, traversing across the frequency spectrum, you hit a massive, isolated spike at exactly **30 Hertz**. 

This graph is undeniable, mathematical proof of our scenario. The time-domain graph just looked like a fuzzy red mess, but the Frequency Domain isolates the culprit. We can clearly see the electromagnetic interference from the ventilation fan humming at 30 cycles per second. The shorter, broader elevation at the bottom represents our Gaussian white noise spread across all frequencies.

This Fourier analysis is the ultimate justification for [Speaker 3]’s Moving Average filter. Because we can visually and mathematically prove that our 'truth' is at 0.1 Hz and our 'garbage' is at 30 Hz, we know that a Low-Pass filter is the correct architectural choice. We are aggressively blocking the 30 Hz spike while leaving the 0.1 Hz peak untouched. 

We now have a beautifully clean, mathematically verified signal. But a dashboard that just shows data is only half the battle. A truly smart greenhouse must act on that data to control the physical world. For that, we turn to Control Theory. I will now invite [Speaker 5] to explain how we use Laplace Transforms to govern the stability of our irrigation pumps."

---

## **Speaker 5: Control Theory, Laplace Transforms, and System Stability**

**[CUE: Point to the 'Laplace Stability' code block and the Pole-Zero Map]**

"Thank you, [Speaker 4]. We have cleaned the data. The computer now knows, with high precision, exactly how dry the soil is. The next logical step is for the computer to trigger the irrigation water pump. But this is where physical engineering becomes dangerous. 

Water pumps, pipes, and soil absorption rates are governed by differential equations. If the computer says 'the soil is dry, turn the pump to 100%,' the pump floods the field with water. By the time the water seeps into the soil and the sensor registers the change, the field is already over-watered. The computer then panics, shuts the pump off entirely, the soil eventually dries out rapidly, and the cycle repeats. This violent oscillation is called **System Instability**, and it destroys crops and hardware.

To prevent this, AgriSense incorporates strict Control Theory using the **Laplace Transform**. The Laplace Transform allows us to take complex linear differential equations in the time domain and turn them into simple algebraic equations in the complex 'S-domain'. 

In our code, we model the physical dynamics of the soil and the pump as a second-order LTI system, represented by a **Transfer Function**, $H(s)$.
`num = [K_gain];`
`den = [1 5 K_gain];`
`sys = tf(num, den);`
This creates the mathematical model:
$$H(s) = \frac{K}{s^2 + 5s + K}$$
Here, the numerator `K` represents our 'Irrigation Gain'—essentially, how aggressively we want the pump to respond to a dry signal. The denominator is the **Characteristic Equation** of the physical system, where the '5s' term represents the physical damping (how slowly the soil absorbs the water). 

To determine if our pump will operate safely, we must find the roots of this denominator, which are known as the **Poles** of the system. In MATLAB, we simply use the command `p = pole(sys);`.

If you look at the bottom-right of the dashboard, you will see the **Pole-Zero Map**. The graph represents the complex S-plane. The x-axis is the Real axis ($\sigma$), representing exponential growth or decay. The y-axis is the Imaginary axis ($j\omega$), representing oscillation frequency. 

The golden rule of Control Theory is this: **For a causal LTI system to be stable, all of its poles must lie strictly in the Left-Half Plane (LHP).** This means the real part of every pole must be negative. If a pole moves to the Right-Half Plane, the system's output will grow exponentially to infinity—in physical terms, an uncontrollable flood. If a pole is on the imaginary axis, the system will oscillate endlessly without settling.

In our code, we implement an automatic safety check: `if all(real(p) < 0)`. We literally check if every single pole is located on the left side of zero. If it is, the system is deemed 'Stable' and the pump is authorized to operate. If the user tries to increase the gain too high, driving the poles toward the dangerous Right-Half Plane, AgriSense will intervene, declare the system 'Unstable', and lock the pump.

This is the absolute pinnacle of our project: using complex abstract mathematics to enforce physical safety constraints in the real world. [Speaker 6] will now guide you through a live demonstration of this entire interconnected ecosystem, showing how time, frequency, and Laplace domains interact in real-time."

---

## **Speaker 6: Live Dashboard Integration and Final Conclusion**

**[CUE: Take control of the mouse, move the Noise and Gain sliders interactively]**

"Thank you, [Speaker 5], for that brilliant breakdown of our control logic. We have spent the last 25 minutes dissecting the deep mathematics underlying AgriSense. Now, let’s see all of these theories come to life concurrently in our interactive MATLAB Dashboard. 

What you are looking at is a custom Graphical User Interface built entirely within MATLAB using the `uifigure` and `uiaxes` component libraries. We programmed callback functions tied to the two sliders on the right. Whenever a slider is moved, MATLAB instantly recalculates the time-domain signal, convolves it with the LTI filter, computes the Fast Fourier Transform, extracts the Laplace poles, and redraws all three plots in a fraction of a second.

Let’s test the extremes of our environment. I am going to grab the **'Sensor Noise Intensity'** slider and drag it all the way up to maximum. 
Watch the Time Domain plot at the top. The red 'Raw Sensor' line has become violently chaotic. The interference is so severe that it is completely masking the underlying data. Now, direct your eyes to the Frequency Domain plot on the bottom left. The FFT instantly registers this change—the peak at 30 Hertz shoots off the chart, proving that our electromagnetic fan interference is dominating the signal energy.
But look back at the top graph. Look at the blue line. Despite the absolute chaos of the red signal, the blue 'Filtered Data' remains a perfectly smooth, accurate representation of the soil moisture. Our moving-average convolution filter is completely unaffected by the noise spike. We have mathematically isolated the truth from the interference. 

Now, let’s test our Control Systems safety protocols. I am going to grab the **'Irrigation Gain'** slider. Let’s assume an inexperienced farmer wants to water the field as fast as possible, so they crank the gain up to maximum. 
Watch the Pole-Zero map on the bottom right. As I increase the gain, the 'X' marks—the poles of our characteristic equation—begin to separate and move up and down along the imaginary axis. Because they are gaining imaginary components, the system is becoming 'underdamped.' Physically, this means the water pump will start to surge and overshoot its target. 
If I push the gain too far, the poles migrate precariously close to the Right-Half Plane. Instantly, our Laplace safety check function evaluates `real(p)`, realizes the system is approaching catastrophic oscillation, and throws the Status text into a red warning: **'System Status: UNSTABLE (Flood Risk!)'**. The software mathematically predicts a physical disaster before a single drop of water is wasted. 

This concludes our demonstration of AgriSense. Over the course of this project, we didn't just write code. We applied the fundamental principles of Signals and Systems to architect a robust, fault-tolerant industrial tool. 
*   We used continuous-time modeling and Nyquist sampling to simulate a hostile IoT environment.
*   We utilized the calculus of Convolution to design a protective Linear Time-Invariant low-pass filter.
*   We leveraged the Fast Fourier Transform to spectrally fingerprint and verify our interference sources.
*   And we applied Laplace Transforms to enforce the physical stability of our irrigation hardware.

AgriSense proves that the abstract mathematics we study in IGS2137 are not just academic exercises—they are the critical tools required to build reliable, sustainable technology that can solve global challenges like water conservation and smart agriculture. 

We are incredibly proud of what we have built here today, and we want to thank you for your time, your instruction, and your attention. We now welcome any questions you may have about our code, our mathematical models, or the future scalable potential of AgriSense. Thank you."

---
**[END OF MASTER SCRIPT]**
