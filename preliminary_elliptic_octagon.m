%fixed parameters
w1=0.03;
w2=0.15;
h1=w2;
h2=w1;
L=40;

%parameters to scan
x0=1;
l0=1;

%scan step l

omega = (w2-w1)/(L^2-2*l0*L)*l^2 + 2*(w1-w2)/(L^2-2*l0*L)*l0*l + w1;

eta = (h2-h1)/(L^2-2*(L-l0)*L)*l^2 + 2*(h1-h2)/(L^2-2*(L-l0)*L)*(L-l0)*l + h1;

w = sqrt((x0^2*w2^2 - (L-x0)^2*w1^2)/(x0^2 - (L-x0)^2)*(1 - (l-x0)^2*(w2^2-w1^2)/(x0^2*w1^2-(L-x0)^2*w1^2)));

h = sqrt(((L-x0)^2*h2^2 - x0^2*h1^2)/((L-x0)^2 - x0^2)*(1 - (l-L+x0)^2*(h2^2-h1^2)/((L-x0)^2*h1^2 - x0^2*h1^2)));