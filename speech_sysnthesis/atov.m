%%ECES 631-FALL 2014
%%RAGHAVENDRA MG
function        [r,D,G]=AtoV(A,rN)
%       function to find reflection coefficients
%       and system function denominator for
%       lossless tube models.
%               [r,D,G]=AtoV(A,rN)
%               rN = reflection coefficient at lips (abs value lt 1)
%               A = array of areas
%               D = array of denominator coefficients
%               G = numerator of transfer function
%               r = corresponding reflection coefficients
%       assumes no losses at the glottis end (rG=1).
[M,N]=size(A);
if(M~=1) A=A'; end      %make row vector
N=length(A);
r=[];
for m=1:N-1
        r=[r (A(m+1)-A(m))/(A(m+1)+A(m))];
end
r=[r rN];
D=[1];
G=1;
for m=1:N
        G=G*(1+r(m));
        D=[D 0] + r(m).*[0 fliplr(D)];
end
