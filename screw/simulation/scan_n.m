function scan_n(lambda)
name = 'scan_n';
i = 1;
for n = 1:12
    screw_n(n);
    model = mccode('screw_n.instr');
    parameters.lambda=lambda;
    parameters.guide_m = 6;
    parameters.L = 10;
    results = iData(model,parameters);
    sum_Lb(i) = sum(results, 0);
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