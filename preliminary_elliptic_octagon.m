



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

%points

0 (-w; eta)
1 (-omega; h)
2 (omega; h)
3 (w; eta)
4 (w; -eta)
5 (omega; -h)
6 (-omega; -h)
7 (-w; -eta)


x1=[-w -eta lin;...
-omega h 0;...
omega h 0;...
w eta 0;...
w -eta L0;...
-a/2-b -a/2 L0;...
-a/2-b a/2 L0;...
-a/2 a/2+b L0;...
a/2 a/2+b L0;...
a/2+b a/2 L0;...
a/2+b -a/2 L0;...
a/2 -a/2-b L0;...
-a/2 -a/2-b L0+L1;...
-a/2-b -a/2 L0+L1;...
-a/2-b a/2 L0+L1;...
-a/2 a/2+b L0+L1;...
a/2 a/2+b L0+L1;...
a/2+b a/2 L0+L1;...
a/2+b -a/2 L0+L1;...
a/2 -a/2-b L0+L1;...
-h/2 -w/2 2*L0+L1;...
-h/2 w/2 2*L0+L1;...
h/2 w/2 2*L0+L1;...
h/2 -w/2 2*L0+L1];
x2=[4 1 2 8 7;...
4 2 9 10 3;...
4 0 3 11 4;...
4 0 1 6 5;...
4 4 5 13 12;...
4 5 6 14 13;...
4 6 7 15 14;...
4 7 8 16 15;...
4 8 9 17 16;...
4 9 10 18 17;...
4 10 11 19 18;...
4 11 4 12 19;...
4 20 21 14 13;...
4 21 22 16 15;...
4 22 23 18 17;...
4 20 23 19 12];