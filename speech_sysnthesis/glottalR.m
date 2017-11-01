%%ECES 631-FALL 2014
%%RAGHAVENDRA MG
function [gR,GR,W] = glottalR(N1,N2,Nfreq)
%   function to find waveform vector and 
%   frequency response of rosenberg
%   glottal model
%           [gR, GR, W] = glottalR((N1, N2, Nfreq)
%           N1, N2 = sample points in rosenberg glottal waveform vector
%           Nfreq = number of frequencies
%           W = Nfreq frequencies in frequency response between 0 and pi
%           gR = rosenberg glottal waveform vector
%           GR = frequency response of rosenberg glottal model at W
%           frequencies
for i=1:Nfreq
    W(i)=(i-1)*(pi/Nfreq)*(pi/180);
end
for n=1:N1+N2+1
    if(n < N1)
        gR(n)=0.5*(1-cos(pi*n/N1));
    elseif n < N1 + N2
        gR(n)=cos(pi*(n-N1)/(2*N2));
    else 
        gR(n)=0;
    end
end
for i = 1:Nfreq
    temp = 0;
    for j=N1+N2+1
        temp = gR(j)*exp(-1*1i*pi*W(i))+temp;
    end
    GR(i)=temp;
end
[GR,W]=freqz(gR,Nfreq);
        

