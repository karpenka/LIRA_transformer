function octagon_ps_aL()
%if you want to change something, look for a_max,a_min,a_step(for size of
%octagon) and the same for L - length of the guide and you need change dir
%in mcstas part of the function

%guide parameters for geks function
w = 0.03;
h = 0.15;
L1 = 10;
a = 0.09;
b = 0.035;
a_min = 0.01;
a_step = 0.01;
a_max = 0.21;
i=1;
j=1;
%Screw param
L0_min=1;
L0_max=41;
L1=40;
L0_step=5;
%loop
k=1;
l=1;
lr=1;
lr1=1;
for L0 = L0_min:L0_step:L0_max
    rect(w,h,2*L0+L1);
    [p0,m0]=mcstas('screw_str.instr',struct('lambda',5,'L',2*L0+L1,'guide_m',6,'w',0.03,'h',0.2),struct('ncount',1e6,'mpi',4));
    p0l=p0(1,:,:).Signal;
    p0s=p0(2,:,:).Signal;
    I0l(lr) = p0l;
    I0s(lr) = p0s;
    lr=lr+1;
end
progressbar('a','L');
for a = a_min:a_step:a_max
for L0 = L0_min:L0_step:L0_max
    pause(0.0001)
    geks_ps(a,b,w,h,L0,L1);
    [p1,m1]=mcstas('LIRA_oct.instr',struct('L0',L0,'L1',L1,'guide_m',6,'w',0.03,'h',0.2),struct('ncount',1e6,'mpi',4));
    p1l=p1(1,:,:).Signal;
    p1s=p1(2,:,:).Signal;
    Il(l,k)=p1l/I0l(l);
    Is(l,k)=p1s/I0s(l);
    frac1 = ((a-a_min)/a_step+1)/((a_max-a_min)/a_step+1);
    frac2 = ((L0-L0_min)/L0_step+1)/((L0_max-L0_min)/L0_step+1);
    progressbar(frac1, frac2);
    l=l+1;
end
    k=k+1;
    l=1;
end
dlmwrite('octagon_aLl.dat',Il,' ');
dlmwrite('octagon_aLs.dat',Is,' ');
aa=a_min:a_step:a_max;
LL=L0_min:L0_step:L0_max;
[X,Y]=meshgrid(aa,LL);
figure;
surf(X,Y,Il)
savefig('oct_aLl.fig');
figure;
surf(X,Y,Is)
savefig('oct_aLs.fig');
