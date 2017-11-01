[gE, GE, W]=glottalE(0.91,51,6);
[gR,GR,W] = glottalR(40,10,6);
gR_flip = fliplr(gR);
[GR_flip,W_flip]=freqz(gR_flip,6);
figure(3)
plot(gR_flip)
A = fft(gR_flip);
figure(4)
plot(abs(A))
figure(5);
plot(W_flip/pi,20*log(abs(GR_flip)))