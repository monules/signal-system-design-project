%% AgriSense: Interactive Live Dashboard
% This script creates an interactive dashboard directly in the MATLAB figure window.
% It works perfectly in MATLAB Online.

function AgriSense_Live_Dashboard()
    % Initialize UI
    fig = uifigure('Name', 'AgriSense: Smart Agriculture Dashboard', 'Position', [100 100 900 600]);
    
    % Create Layout
    grid = uigridlayout(fig, [2, 2]);
    grid.RowHeight = {'1x', '1x'};
    grid.ColumnWidth = {'1.5x', '1x'};

    % 1. Time Domain Plot
    ax_time = uiaxes(grid);
    ax_time.Title.String = 'Soil Moisture (Time Domain)';
    ax_time.XLabel.String = 'Time (s)';
    ax_time.YLabel.String = 'Moisture %';

    % 2. Frequency Domain Plot
    ax_freq = uiaxes(grid);
    ax_freq.Title.String = 'Noise Spectrum (Fourier FFT)';
    ax_freq.XLabel.String = 'Frequency (Hz)';

    % 3. Stability Plot (Pole-Zero)
    ax_stab = uiaxes(grid);
    ax_stab.Title.String = 'System Stability (Laplace Poles)';

    % 4. Control Panel
    panel = uipanel(grid);
    panel.Title = 'Dashboard Controls';
    ctrl_grid = uigridlayout(panel, [4, 1]);

    % Noise Slider
    uilabel(ctrl_grid, 'Text', 'Sensor Noise Intensity:');
    noise_sld = uislider(ctrl_grid, 'Limits', [0 5], 'Value', 1.5);
    
    % Gain Slider
    uilabel(ctrl_grid, 'Text', 'Irrigation Gain (K):');
    gain_sld = uislider(ctrl_grid, 'Limits', [1 100], 'Value', 10);
    
    % Status Label
    status_lbl = uilabel(ctrl_grid, 'Text', 'System Status: Initializing...', 'FontWeight', 'bold');

    % Set Callbacks for real-time updates
    noise_sld.ValueChangedFcn = @(sld, event) update_dashboard(ax_time, ax_freq, ax_stab, status_lbl, noise_sld, gain_sld);
    gain_sld.ValueChangedFcn = @(sld, event) update_dashboard(ax_time, ax_freq, ax_stab, status_lbl, noise_sld, gain_sld);

    % Initial Update
    update_dashboard(ax_time, ax_freq, ax_stab, status_lbl, noise_sld, gain_sld);
end

function update_dashboard(ax_t, ax_f, ax_s, lbl, sld_n, sld_g)
    % 1. Get Parameters
    noise_amp = sld_n.Value;
    K_gain = sld_g.Value;
    Fs = 100;
    
    % 2. Generate Noisy Signal (Time Domain)
    t = linspace(0, 10, 1000);
    base = 40 + 5*sin(2*pi*0.1*t);
    noise = noise_amp * sin(2*pi*30*t) + (noise_amp/3)*randn(size(t));
    noisy = base + noise;
    
    % 3. Filter Signal (LTI Convolution)
    window = 30;
    h = (1/window)*ones(1, window);
    clean = conv(noisy, h, 'same');
    
    % Update Plot
    plot(ax_t, t, noisy, 'r'); hold(ax_t, 'on');
    plot(ax_t, t, clean, 'b', 'LineWidth', 2); hold(ax_t, 'off');
    legend(ax_t, 'Raw Sensor', 'Filtered Data');

    % 4. Fourier Analysis
    L = length(noisy);
    Y = fft(noisy);
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    f = Fs*(0:(L/2))/L;
    
    plot(ax_f, f, P1);
    ylim(ax_f, [0 2.5]);

    % 5. Laplace Stability
    num = [K_gain];
    den = [1 5 K_gain]; % Using a simple spring-mass-damper style model
    sys = tf(num, den);
    pzmap(ax_s, sys);
    
    % 6. Stability Check
    p = pole(sys);
    if all(real(p) < 0)
        lbl.Text = 'System Status: STABLE (Watering OK)';
        lbl.FontColor = [0 0.5 0];
    else
        lbl.Text = 'System Status: UNSTABLE (Flood Risk!)';
        lbl.FontColor = [0.8 0 0];
    end
end
