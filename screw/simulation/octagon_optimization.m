model = mccode('LIRA_oct.instr');
fix(model, 'all');
model.L1 = 'free'; model.L1 = [0.1 20 80];
model.L2 = 'free'; model.L2 = [0.1 20 80];
model.L3 = 'free'; model.L3 = [0.1 20 80];
model.a = 'free'; model.a = [0.01 0.05 0.2];
model.b = 'free'; model.b = [0.01 0.05 0.2];
model.lambda = lambda;
model.guide_m = m;
model.w = w;
model.h = h;
geks_ps_3L(model.a,model.b,model.w,model.h,model.L1,model.L2,model.L3)
model.linh = 'free'; model.linh = [];
[parameters, fval, status, output]=fmax(model,[], ...
'optimizer=fminpso; OutputFcn=fminplot;TolFun =5%;TolX=5%;ncount=1e5;MaxFunEvals=100', nan);
