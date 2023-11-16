f_lowpass = 1;
f_s = 100;

[file, path] = uigetfile('*.*');
table = readtable(append(path,file));

[timestamps, acc_x, acc_y, acc_z, acc_m] = load_acc(table);

% Evenly spaced x axis
timestamps_spaced = timestamps(1):1/f_s:timestamps(end);
% Interpolate acceleration
acc_x_spaced = interp1(timestamps, acc_x, timestamps_spaced);
acc_x_filt = lowpass(acc_z_spaced, f_lowpass, f_s, ImpulseResponse="iir", Steepness=0.95);
acc_y_spaced = interp1(timestamps, acc_y, timestamps_spaced);
acc_y_filt = lowpass(acc_z_spaced, f_lowpass, f_s, ImpulseResponse="iir", Steepness=0.95);
acc_z_spaced = interp1(timestamps, acc_z, timestamps_spaced);
acc_z_filt = lowpass(acc_z_spaced, f_lowpass, f_s, ImpulseResponse="iir", Steepness=0.95);
acc_m_spaced = interp1(timestamps, acc_m, timestamps_spaced);
acc_m_filt = lowpass(acc_z_spaced, f_lowpass, f_s, ImpulseResponse="iir", Steepness=0.95);

plot(timestamps_spaced, acc_z_filt);