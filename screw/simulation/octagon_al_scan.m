fname = 'Octagon_aL_scan_lambda_5A';
lambda = 5;
w = 0.03;
h = 0.15;
m = 6;
a_min = 0.01;
a_step = 0.01;
a_max = 0.21;
L_min=1;
L_max=81;
L_step=10;

lr=1;
for L = L_min:L_step:L_max
    rect(w,h,2*L);
    [p0,m0]=mcstas('screw_str.instr',struct('lambda',lambda,'L',2*L,'guide_m',m,'w',w,'h',h),struct('ncount',1e5));
    p0l=p0(1,:,:).Signal;
    p0m=p0(2,:,:).Signal;
    p0s=p0(3,:,:).Signal;
    I0l(lr) = p0l;
    I0m(lr) = p0m;
    I0s(lr) = p0s;
    lr=lr+1;
end

k=1;
progressbar('a','L');
for a = a_min:a_step:a_max
    b = a/sqrt(2);
    l=1;
    for L = L_min:L_step:L_max
        pause(0.0001)
        geks_ps(a,b,w,h,L,0.05);
        [p1,m1]=mcstas('LIRA_oct.instr',struct('L0',L,'L1',0.05,'guide_m',m,'w',w,'h',h),struct('ncount',1e5));
        p1l=p1(1,:,:).Signal;
        p1m=p1(2,:,:).Signal;
        p1s=p1(3,:,:).Signal;
        Il(l,k)=p1l/I0l(l);
        Im(l,k)=p1m/I0m(l);
        Is(l,k)=p1s/I0s(l);
        frac1 = ((a-a_min)/a_step+1)/((a_max-a_min)/a_step+1);
        frac2 = ((L-L_min)/L_step+1)/((L_max-L_min)/L_step+1);
        progressbar(frac1, frac2);
        l=l+1;
    end
    k=k+1;
end
dlmwrite([fname '_l.dat'],Il,' ');
dlmwrite([fname '_m.dat'],Im,' ');
dlmwrite([fname '_s.dat'],Is,' ');
aa=a_min:a_step:a_max;
LL=L_min:L_step:L_max;
[X,Y]=meshgrid(aa,LL);
figure;
surf(X,Y,Il)
savefig([fname '_l.fig']);
figure;
surf(X,Y,Im)
savefig([fname '_m.fig']);
figure;
surf(X,Y,Is)
savefig([fname '_s.fig']);
