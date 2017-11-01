%%ECES 631-FALL 2014
%%RAGHAVENDRA MG
%%Exercise 3
clear all;
clc;
close all;

%Exercise 3.1 (a): Exponential Glottal Model
%Calling the glottalE function
[gE, GE, W]=glottalE(0.91,51,6);

%Exercise 3.2 (b): Rosenberg Glottal Model
%Calling the glottalR function
[gR,GR,WR] = glottalR(40,10,6);

gR_flip = fliplr(gR);  %using fliplr to flip the rosenberg waveform vector
[GR_flip,W_flip]=freqz(gR_flip,6);

%Exercise 3.3 (c): Plotting 
str_pulses = sprintf( 'Glottal Pulse Plots');
str_responses = sprintf('Frequency Responses');
n = 1:51;

figure('Name',str_pulses,'NumberTitle','off');
plot(n,gE/max(gE),'b',n,gR/max(gR),'r',n,gR_flip/max(gR_flip),'g');
grid;
xlabel('Samples');
ylabel('Magnitude');
legend('gE(n)','gR(n)','gR_ flip(n)');


figure('Name',str_responses,'NumberTitle','off');
plot(W/pi,20*log(abs(GE)),'b',WR/pi,20*log(abs(GR)),'g',...
    W_flip/pi,20*log(abs(GR_flip)),'--r');
grid;
xlabel('Frequency');
ylabel('Magnitude(dB)');
legend('GE','GR','GR_ flip');

%Exercise 3.3 (d): Zeros of Rosenberg Glottal Model
figure('Name', 'Z-plane plot of Rosenberg Glottal Model',...
    'NumberTitle', 'off');
zpl(roots(gR)); %plotting zeros of rosenberg model
title('Z-plane plot of Rosenberg Glottal Model');
figure('Name', 'Z-plane plot of Flipped Rosenberg Glottal Model',...
    'NumberTitle', 'off');
zpl(roots(gR_flip));%plotting zeros of flipped rosenberg model
title('Z-plane plot of Flipped Rosenberg Glottal Model');

%Function AtoV
AA = [1.6, 2.6, 0.65, 1.6, 2.6, 4, 6.5,8 ,7,5];
IY = [2.6 8 10.5 10.5 8 4 .65 .65 1.3 3.2];
A = AA;
[r_loss,D_loss,G_loss]=atov(A,0.71);
[r_lossless,D_lossless,G_lossless]=atov(A,1);
[V1,W]=freqz(G_loss,D_loss);
[V2,W1]=freqz(G_lossless,D_lossless);
figure('Name','Frequency response of reflection coefficients',...
    'Numbertitle','off')
plot(W/pi,20*log(abs(V1)),'b',W1/pi,20*log(abs(V2)),'r')
grid;
xlabel('Frequency');
ylabel('Magnitude(dB)');
[v, t_v] = impz(G_loss, D_loss);
v = v(1 : 500);
t_v = t_v(1 : 500);

%Exercise 4.1 (b)
figure('Name','Pole-Zero plots for rN = 0.71','Numbertitle','off')
zplane(roots(G_loss),roots(D_loss));
title('Zeros of Rosenberg Glottal Model with rN = 0.71');
figure('Name','Pole-Zero plots for rN = 1','Numbertitle','off')
zplane(roots(G_lossless),roots(D_lossless));
title('Zeros of Rosenberg Glottal Model with rN = 1');
fa = angle(roots(V1)) * 1000;

%%
%%
%%Exercise 5
%Exercise 5.1
%impulse train
f = 100;                    %frequency of trigger pulse in Hertz
fs = 10000;                 %sampling frequency in Hertz
t = 0 : 1/fs : 9999/fs;     %time vector for trigger pulse
e = zeros(size(t));         %initialising trigger pulse
e(1:fs/f:end) = 1;          %allocating ones wherever necessary

%radiation system
r = impz([1 -1]);           %impulse response of radiation system

%AtoV for AA and IY
[V_AA, D_AA, G_AA] = atov(AA, 0.71);
[V_IY, D_IY, G_IY] = atov(IY, 0.71);

%vocal tract model in time domain
[v_AA, t_v_AA] = impz(G_AA, D_AA);          %vocal tract waveform for AA          
[v_IY, t_v_IY] = impz(G_IY, D_IY);          %vocal tract waveform for IY

%speech synthesis
sn_AA_gE = conv(e, conv(gE, conv(v_AA, r)));
sn_AA_gR = conv(e, conv(gR, conv(v_AA, r)));
sn_AA_gR_flip = conv(e, conv(gR_flip, conv(v_AA, r)));

sn_IY_gE = conv(e, conv(gE, conv(v_IY, r)));
sn_IY_gR = conv(e, conv(gR, conv(v_IY, r)));
sn_IY_gR_flip = conv(e, conv(gR_flip, conv(v_IY, r)));

str = 'Comparison of Synthesized Speech Waveforms for gE & gR_F';
figure('Name', str, 'NumberTitle', 'off');
subplot 221;
plot(sn_AA_gE(1 : 1001));
xlim([0 1001]);
title('AA using Exponential glottal model');
xlabel('Samples');
ylabel('Magnitude');
subplot 222;
plot(sn_AA_gR_flip(1 : 1001));
xlim([0 1001]);
title('AA using Flipped Rosenberg Glottal Model');
xlabel('Samples');
ylabel('Magnitude');
subplot 223;
plot(sn_IY_gE(1 : 1001));
xlim([0 1001]);
title('IY using Exponential glottal model');
xlabel('Samples');
ylabel('Magnitude');
subplot 224;
plot(sn_IY_gR_flip(1 : 1001));
xlim([0 1001]);
title('IY using Flipped Rosenberg Glottal Model');
xlabel('Samples');
ylabel('Magnitude');

%Comparison between speech synthesized using gR and gR_Flip
str = 'Comparison of Synthesized Speech Waveforms for gR & gR_F';
figure('Name', str, 'NumberTitle', 'off');
subplot 221;
plot(sn_AA_gR(1 : 1001));
xlim([0 1001]);
title('AA using Rosenberg Glottal Model');
xlabel('Samples');
ylabel('Magnitude');
subplot 222;
plot(sn_AA_gR_flip(1 : 1001));
xlim([0 1001]);
title('AA using Flipped Rosenberg Glottal Model');
xlabel('Samples');
ylabel('Magnitude');
subplot 223;
plot(sn_IY_gR(1 : 1001));
xlim([0 1001]);
title('IY using Rosenberg Glottal Model');
xlabel('Samples');
ylabel('Magnitude');
subplot 224;
plot(sn_IY_gR_flip(1 : 1001));
xlim([0 1001]);
title('IY using Flipped Rosenberg Glottal Model');
xlabel('Samples');
ylabel('Magnitude');

%Exercise 5.2
Gsys = tf([27.3531 0], [1 -1], 0.1, 'Variable', 'z');
Vsys = tf(G_IY, D_IY, 0.1, 'Variable', 'z^-1');
Rsys = tf([1 -1], 1, 0.1, 'Variable', 'z^-1');

H = Gsys * Vsys * Rsys;
[n, d] = tfdata(H, 'v');
[Hresp, Wresp] = freqz(n, d, 512);
str = 'Frequency Response of System Transfer Function H(z) = G(z)V(z)R(z)';
figure('Name', str, 'NumberTitle', 'off');
plot(Wresp/pi, 20 * log10(abs(Hresp)));
title(str);
xlabel('Normalized Frequency')
ylabel('Magnitude (dB)')

%Exercise 5.3
soundsc(sn_AA_gE(1 : 5001), fs);
pause(1);
soundsc(sn_AA_gR(1 : 5001), fs);
pause(1);
soundsc(sn_AA_gR_flip(1 : 5001), fs);
pause(1);
soundsc(sn_IY_gE(1 : 5001), fs);
pause(1);
soundsc(sn_IY_gR(1 : 5001), fs);
pause(1);
soundsc(sn_IY_gR_flip(1 : 5001), fs);