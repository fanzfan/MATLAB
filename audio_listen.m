

fs=48000;
dt = 1/fs;
time = (1:30000)*dt;
sine = sin(200*2*pi*time);
sound(sine,fs);