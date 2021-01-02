

fs=60000;
dt = 1/fs;
time = (1:100000)*dt;
sine = sin(16000*2*pi*time);
sound(sine,fs);