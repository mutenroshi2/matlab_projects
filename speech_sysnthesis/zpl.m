%%ECES 631-FALL 2014
%%RAGHAVENDRA MG
function  zplane(z,p)
%ZPLANE        z-plane plot of poles and zeros
%       zplane(z,p)
%              z = vector of zeros
%              p = vector of poles
%
clf
axis('square')
axis([-2 2 -2 2])
plot((-2:1:2),zeros(5,1),'-r',zeros(5,1),(-2:1:2),'-r')
hold on
if(nargin == 1)
        plot(real(z),imag(z),'ok',sin(0:.01:2*pi),cos(0:.01:2*pi),'-b')
else
        plot(real(z),imag(z),'ok',real(p),imag(p),'xk',sin(0:.01:2*pi),cos(0:.01:2*pi),'-b')
end
axis('square')
hold off
