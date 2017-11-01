%%ECES 631-FALL 2014
%%RAGHAVENDRA MG
function [gE, GE, W] = glottalE(a,Npts,Nfreq)
%   function to find waveform vector and 
%   frequency response of exponential
%   glottal model
%           [gE, GE, WE] = glottalE(a, Npts, Nfreq)
%           a = coefficient of glottal model
%           Npts = number of samples
%           Nfreq = number of frequencies
%           W = Nfreq frequencies in frequency response between 0 and pi
%           gE = exponential glottal waveform vector
%           GE = frequency response of exponential glottal model at W
%           frequencies
for n=1:Npts
gE(n) = n*(a^n);
end
b = [0 a];
c = [1 -2*a a^2];
[GE,W] = freqz(b, c, Nfreq);

