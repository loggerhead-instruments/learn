% fircoeff
% calculate FIR taps to use in frequency response correction filter
ntaps = 2000; %frequency resolution of filter is srate/ntaps; so more taps, better resolution
srate = 10000.0;
nyquist = srate / 2;

cal_level = -150; %after use filter this will be calibration sensitivity

% f is a vector of pairs of normalized frequency points, 
% specified in the range between 0 and 1, where 1 corresponds to the 
% Nyquist frequency. The frequencies must be in increasing order.

%freq = [0 5000]; 
freq = [0.0 10.0 20.0 30.0 50.0 100.0 200.0 400.0 800.0 1000.0 [1200.0:25:5000.0]]'; %every 25 Hz from 1200 on
f = freq / nyquist;
% a is a vector containing the desired amplitudes at the points specified in f.
% this is for cos axis from calibration sheet
% 1.0 -210.2
% 10.0 -190.2
a_dB = [ 
-210.2
-190.2
-184.2
-180.7
-176.3
-170.2
-164.2
-158.2
-152.1
-150.2
-146.4
-145.9
-144.9
-144.1
-143.2
-142.3
-141.5
-140.8
-140.1
-139.5
-139.0
-138.6
-138.3
-138.0
-137.7
-137.4
-137.0
-136.7
-136.4
-136.1
-135.7
-135.4
-135.0
-134.6
-134.3
-134.0
-133.6
-133.2
-133.0
-132.6
-132.3
-132.0
-131.8
-131.6
-131.3
-131.1
-130.9
-130.8
-130.7
-130.5
-130.4
-130.2
-130.1
-130.0
-129.9
-129.9
-130.0
-129.9
-129.9
-130.0
-130.0
-130.1
-130.3
-130.4
-130.5
-130.7
-130.8
-131.0
-131.1
-131.4
-131.6
-131.8
-132.1
-132.4
-132.6
-133.0
-133.3
-133.6
-134.0
-134.3
-134.7
-135.1
-135.5
-135.9
-136.4
-136.8
-137.3
-137.8
-138.3
-138.8
-139.4
-139.9
-140.5
-141.0
-141.6
-142.2
-142.8
-143.4
-143.9
-144.4
-144.8
-145.2
-145.4
-145.6
-145.7
-145.7
-145.6
-145.5
-145.3
-145.1
-144.9
-144.7
-144.5
-144.2
-144.0
-143.8
-143.7
-143.5
-143.4
-143.3
-143.2
-143.1
-143.0
-143.0
-142.9
-142.9
-142.8
-142.8
-142.8
-142.8
-142.8
-142.8
-142.9
-142.9
-142.9
-142.9
-143.0
-143.1
-143.2
-143.3
-143.4
-143.5
-143.7
-143.8
-143.9
-144.1
-144.3
-144.4
-144.6
-144.8
-145.0
-145.1
-145.4
-145.5
-145.8
-146.1
-146.3
-146.6
-147.0
-147.3
-147.7
-147.9
-148.1];
a_dBcorrection = cal_level - a_dB;
a = power(10, a_dBcorrection/20); % linearized gain at each frequency

%b = firpm(ntaps,f,a); %minimum phase implementation; blowing up with large
%range
b_cos = fir2(ntaps, f, a); % calculate coefficients
[h,w] = freqz(b_cos,1,512); % measure frequency response of b FIR taps

figure(1)
plot(freq, a_dB);
hold all
plot([0 nyquist],[cal_level cal_level])
plot(freq, a_dBcorrection);
ylabel('dB');
xlabel('Frequency (Hz)');
plot(nyquist * w/pi, 20*log10(abs(h)));
hold off;
legend('Frequency Response', 'Cal Level' ,'Correction', 'Filter Response');
title('cos');
% % linear view
% figure(2)
% plot(f,a,w/pi,abs(h))
% legend('Ideal','firpm Design')

% sin values
a_dB = [ 
-210.2   
-191.0
-185.0
-181.5
-177.1
-171.0
-165.0
-159.0
-152.9
-151.0
-145.6
-144.9
-143.9
-143.0
-142.0
-141.2
-140.3
-139.5
-138.8
-138.3
-137.9
-137.6
-137.3
-136.8
-136.5
-136.1
-135.8
-135.6
-135.4
-135.2
-134.9
-134.7
-134.4
-134.1
-133.8
-133.5
-133.3
-132.9
-132.6
-132.4
-132.1
-131.8
-131.7
-131.5
-131.4
-131.2
-131.1
-130.9
-130.8
-130.6
-130.5
-130.3
-130.2
-130.1
-130.0
-130.0
-130.1
-130.0
-130.0
-130.1
-130.1
-130.2
-130.4
-130.6
-130.7
-130.9
-131.0
-131.2
-131.4
-131.6
-131.9
-132.1
-132.4
-132.8
-133.1
-133.5
-133.8
-134.2
-134.6
-135.0
-135.4
-135.8
-136.2
-136.7
-137.1
-137.6
-138.0
-138.5
-139.0
-139.6
-140.2
-140.7
-141.3
-141.9
-142.4
-143.0
-143.5
-144.0
-144.5
-144.8
-145.1
-145.3
-145.4
-145.4
-145.3
-145.2
-145.1
-144.9
-144.8
-144.6
-144.4
-144.3
-144.0
-143.8
-143.6
-143.4
-143.2
-143.1
-143.0
-142.9
-142.8
-142.7
-142.6
-142.5
-142.4
-142.4
-142.3
-142.3
-142.3
-142.2
-142.3
-142.3
-142.4
-142.4
-142.5
-142.6
-142.7
-142.8
-143.0
-143.2
-143.4
-143.6
-143.8
-144.0
-144.2
-144.5
-144.7
-145.0
-145.2
-145.4
-145.7
-146.0
-146.3
-146.6
-147.0
-147.3
-147.7
-148.1
-148.6
-149.1
-149.7
-150.0
-150.3
]

a_dBcorrection = cal_level - a_dB;
a = power(10, a_dBcorrection/20); % linearized gain at each frequency
b_sin = fir2(ntaps, f, a); % calculate coefficients

figure(2)
[h,w] = freqz(b_sin,1,512); % measure frequency response of b FIR taps
plot(freq, a_dB);
hold all
plot([0 nyquist],[cal_level cal_level])
plot(freq, a_dBcorrection);
ylabel('dB');
xlabel('Frequency (Hz)');
plot(nyquist * w/pi, 20*log10(abs(h)));
hold off;
legend('Frequency Response', 'Cal Level' ,'Correction', 'Filter Response');
title('sin');
% vert
a = [
-210
-193.0
-187.0
-183.5
-179.1
-173.0
-167.0
-161.0
-154.9
-153.0
-148.5
-148.1
-147.2
-146.3
-146.1
-145.6
-145.1
-144.6
-144.3
-143.9
-143.7
-143.3
-142.9
-142.3
-141.7
-140.9
-140.2
-139.5
-138.9
-138.1
-137.4
-136.7
-136.0
-135.3
-134.7
-134.2
-133.7
-133.2
-132.9
-132.7
-132.4
-132.2
-132.0
-131.8
-131.6
-131.4
-131.3
-131.1
-131.0
-130.8
-130.7
-130.4
-130.3
-130.2
-130.1
-130.1
-130.1
-129.9
-129.9
-129.8
-129.8
-129.8
-129.9
-129.9
-129.9
-130.0
-130.0
-130.0
-130.1
-130.2
-130.3
-130.4
-130.6
-130.7
-130.9
-131.1
-131.3
-131.6
-131.8
-132.1
-132.4
-132.7
-133.1
-133.5
-133.9
-134.4
-134.8
-135.4
-136.0
-136.6
-137.2
-137.9
-138.6
-139.4
-140.3
-141.2
-142.1
-143.1
-144.0
-144.8
-145.5
-146.1
-146.5
-146.6
-146.6
-146.4
-146.0
-145.6
-145.2
-144.8
-144.4
-144.1
-143.7
-143.4
-143.2
-143.0
-142.9
-142.9
-143.0
-143.0
-143.1
-143.2
-143.3
-143.5
-143.7
-143.9
-144.1
-144.3
-144.5
-144.7
-144.9
-145.0
-145.1
-145.1
-145.0
-144.9
-144.7
-144.5
-144.3
-144.0
-143.7
-143.4
-143.1
-142.8
-142.6
-142.3
-142.1
-141.9
-141.7
-141.5
-141.4
-141.3
-141.2
-141.2
-141.2
-141.2
-141.2
-141.3
-141.4
-141.5
-141.7
-141.8
-141.9
]
a_dBcorrection = cal_level - a_dB;
a = power(10, a_dBcorrection/20); % linearized gain at each frequency
b_vert = fir2(ntaps, f, a); % calculate coefficients

figure(3)
[h,w] = freqz(b_vert,1,512); % measure frequency response of b FIR taps
plot(freq, a_dB);
hold all
plot([0 nyquist],[cal_level cal_level])
plot(freq, a_dBcorrection);
ylabel('dB');
xlabel('Frequency (Hz)');
plot(nyquist * w/pi, 20*log10(abs(h)));
hold off;
legend('Frequency Response', 'Cal Level' ,'Correction', 'Filter Response');
title('Z');