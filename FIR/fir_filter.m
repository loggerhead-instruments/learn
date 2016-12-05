% Example of using FIR filters created in fircoeff.m

% note files MUST be sampled at same rate as FIR filter was generated
srate = 10000.0;

% data = recording

% here we simulate a noise signal on three channels
% these would get replaced with real recordings
data1 = randn(srate, 1); % 1s random signal
data2 = randn(srate, 1); % 1s random signal
data3 = randn(srate, 1); % 1s random signal

% this runs the filter for each channel
% the end result is a signal with a sensitivity of cal_level from
% fircoeff.m
data_cos = filter(b_cos, 1, data1);
data_sin = filter(b_sin, 1, data2);
data_vert = filter(b_vert, 1, data3);


% plots to investigate results
% you will see a delay of ntaps (2000) at the beginning of the filtered
% signal
figure
subplot(3,1,1)
plot(data1, 'b');
hold on
plot(data_cos, 'r');

subplot(3,1,2)
plot(data2, 'b');
hold on
plot(data_sin, 'r');

subplot(3,1,3)
plot(data3, 'b');
hold on
plot(data_vert, 'r');
hold off
