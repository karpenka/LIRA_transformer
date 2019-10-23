function screw_mcstas_n(lambda)
%постороение графика для конкретной конфигурации для разных значений частей n, из которых делается винт
L = 45;
m = 6;
w = 0.03;
h = 0.15;
ncount = 1e7;
lr = 1;
step = 2;
st = 1;
ed = 51;
for i=st:step:ed
    f = -90/i;
    screw(w,h,L/i,f);
	%screw_n - создание винта с нужным кол-вом n
    screw_n(i);
    [p1,m1]=mcstas('screw_n.instr',struct('L',L,'lambda',lambda,'guide_m',m),struct('ncount',ncount,'mpi',16,'compile',1));
    Il(lr)=p1(1,:,:).Signal;
    lr=lr+1;
end
ni = st:step:ed;
figure;
plot(ni,Il)
xlabel('n')
ylabel('I_{screw}')
title(join(['Divergence = \pm1.5\circ, ','lambda = ',string(lambda)]))
grid on
savefig(join(['screw_n_l_45_5e6','lambda',string(lambda),'l'],'_'));
end