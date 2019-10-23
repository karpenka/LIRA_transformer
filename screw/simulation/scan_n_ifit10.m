function scan_n_ifit10(lambda)
name = 'scan_n';
i = 1;
L = 10; m = 6; ncount = 1e5;
for n = 1:12
    screw_n2(n);
    [p,m] = mcstas('screw_n.instr',struct('L',L,'lambda',lambda,'guide_m',m),struct('ncount',ncount,'compile',1)); 
    sum_Lb(i) = p.Signal;
    i = i+1;
end
figure
plot(1:12,sum_Lb,'LineWidth',2);
title(name)
grid on
xlabel('n')
ylabel('I, arb. u.')
print(gcf,name,'-dpng','-r300')
saveas(gcf,[name '_.fig']);