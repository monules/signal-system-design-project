# AgriSense: MATLAB App Designer Implementation Guide

This guide explains how to build the interactive **AgriSense Dashboard** using the logic we created in `agrisense_engine.m`.

## Phase 1: Creating the UI Layout
1.  Open MATLAB and type `appdesigner` in the Command Window.
2.  Select **Blank App**.
3.  **Components to Add:**
    *   **3 UIAxes:**
        *   `Axes_Time`: Rename to "Sensor Data (Time Domain)"
        *   `Axes_Freq`: Rename to "Frequency Spectrum (Fourier)"
        *   `Axes_Laplace`: Rename to "System Stability (Laplace)"
    *   **1 Slider:** Label it "Noise Intensity" (Set limits 0 to 5).
    *   **1 Knob/Gauge:** Label it "Irrigation Gain (K)" (Set limits 1 to 50).
    *   **1 Button:** Label it "Update Dashboard".
    *   **1 TextArea:** Label it "Status Notifications".

## Phase 2: Adding the "Math Engine" Functions
1.  In App Designer, click the **Code View** tab.
2.  Right-click on **AgriSense_App** in the Component Browser and select **Functions > Private Function**.
3.  Add the three functions from `agrisense_engine.m` (`get_moisture_data`, `perform_fourier_analysis`, and `check_irrigation_stability`) into this section.

## Phase 3: Writing the Button Callback
1.  Go back to **Design View**.
2.  Right-click the **Update Dashboard** button > **Callbacks > Add ButtonPushedFcn callback**.
3.  Paste the following logic into the function:

```matlab
% 1. Get user inputs from UI
noiseLevel = app.NoiseSlider.Value;
K_gain = app.IrrigationKnob.Value;

% 2. Run the Engine
[t, noisy, clean] = app.get_moisture_data(noiseLevel);
[freq, spec] = app.perform_fourier_analysis(noisy, 100);
[stable, sys] = app.check_irrigation_stability(K_gain);

% 3. Update Time Domain Plot
plot(app.Axes_Time, t, noisy, 'Color', [0.8 0.2 0.2]); % Noisy
hold(app.Axes_Time, 'on');
plot(app.Axes_Time, t, clean, 'Color', [0.2 0.6 0.2], 'LineWidth', 2); % Clean
hold(app.Axes_Time, 'off');
title(app.Axes_Time, 'Soil Moisture Monitoring');

% 4. Update Frequency Plot
plot(app.Axes_Freq, freq, spec, 'LineWidth', 1.5);
title(app.Axes_Freq, 'Fourier Spectrum (Noise Detection)');

% 5. Update Stability Plot
pzmap(app.Axes_Laplace, sys);
title(app.Axes_Laplace, 'Irrigation Stability (Laplace)');

% 6. Notifications
if stable
    app.StatusTextArea.Value = "System Stable. Irrigation active.";
    app.StatusTextArea.FontColor = 'green';
else
    app.StatusTextArea.Value = "WARNING: System Unstable! Adjust Gain.";
    app.StatusTextArea.FontColor = 'red';
end
```

## Phase 4: Styling
To match your hackathon app:
*   Set the **Background Color** of the App to a light grey/blue.
*   Use **Panels** to group the plots.
*   Change the **Font** to 'Arial' or 'Helvetica' for a modern look.
