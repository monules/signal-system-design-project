R = 1; C = 1;
omega = linspace ( -10 , 10, 1000) ;
H = 1 ./ (1 + 1j* omega *R*C);

% Magnitude and Phase
magnitude = abs(H);
phase = angle (H);
 % Plotting
 subplot (2 ,1 ,1);
 plot (omega , magnitude );
 title ('Magnitude Response ');
 xlabel ('Frequency ( rad /s)');
 ylabel ('|H(j\ omega )|');

 subplot (2 ,1 ,2);
 plot (omega , phase );
 title ('Phase Response ');
 xlabel ('Frequency ( rad /s)');
 ylabel (' H (j\ omega )');