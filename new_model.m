path = '/Users/peterkonik/JOB/git_repos/LIRA_transformer'



%fixed parameters
w1=0.015;
w2=0.075;
h1=w2;
h2=w1;
L=40;
lin = 0.1;
l = 25;

%parameters to scan
x0=30;
l0=12;

%scan step l

a_sqr = (w2^2*x0^2 - (L-x0)^2*w1^2)/(w2^2-w1^2);
b_sqr = w1^2*a_sqr/(a_sqr - x0^2);
a_sqr_h = (h2^2*(L-x0)^2 - x0^2*h1^2)/(h2^2-h1^2);
b_sqr_h = h1^2*a_sqr_h/(a_sqr_h - (L-x0)^2);

omega = (w2-w1)/(L^2-2*l0*L)*l^2 + 2*(w1-w2)/(L^2-2*l0*L)*l0*l + w1;
eta = (h2-h1)/(L^2-2*(L-l0)*L)*l^2 + 2*(h1-h2)/(L^2-2*(L-l0)*L)*(L-l0)*l + h1;

w = sqrt(b_sqr/a_sqr*(a_sqr - (l-x0)^2));
h = sqrt(b_sqr_h/a_sqr_h*(a_sqr_h - (l+x0-L)^2));
% 
% 0 (-w; eta)
% 1 (-omega; h)
% 2 (omega; h)
% 3 (w; eta)
% 4 (w; -eta)
% 5 (omega; -h)
% 6 (-omega; -h)
% 7 (-w; -eta)

x1=[-w eta lin;...
-omega h lin;...
omega h lin;...
w eta lin;...
w -eta lin;...
omega -h lin;...
-omega -h lin;...
-w -eta lin;...
-w eta l;...
-omega h l;...
omega h l;...
w eta l;...
w -eta l;...
omega -h l;...
-omega -h l;...
-w -eta l];
x2=[4 0 1 9 8;...
4 1 2 10 9;...
4 2 3 11 10;...
4 3 4 12 11;...
4 4 5 13 12;...
4 5 6 14 13;...
4 6 7 15 14;...
4 7 0 8 15];

vert = x1;
faces = [triangulateFaces(x2(:,2:5))]+1;

stlwrite('oct.stl',faces,vert)
mesh_transf_comsol(path);
stl_to_off_oct_fp('oct_comsol.stl',path);

a_sqr = (w2^2*x0^2 - (L-x0)^2*w1^2)/(w2^2-w1^2);
b_sqr = w1^2*a_sqr/(a_sqr - x0^2);
a_sqr_h = (h2^2*(L-x0)^2 - x0^2*h1^2)/(h2^2-h1^2);
b_sqr_h = h1^2*a_sqr_h/(a_sqr_h - (L-x0)^2);

for i=1:1:41
    ll(i)=i-1;
    omega(i) = (w2-w1)/(L^2-2*l0*L)*ll(i)^2 + 2*(w1-w2)/(L^2-2*l0*L)*l0*ll(i) + w1;
    eta(i) = (h2-h1)/(L^2-2*(L-l0)*L)*ll(i)^2 + 2*(h1-h2)/(L^2-2*(L-l0)*L)*(L-l0)*ll(i) + h1;
    w(i) = sqrt(b_sqr/a_sqr*(a_sqr - (ll(i)-x0)^2));
    h(i) = sqrt(b_sqr_h/a_sqr_h*(a_sqr_h - (ll(i)+x0-L)^2));
end

plot(ll,omega, ll, eta);
figure;
plot(ll,w,ll,h)