clear all
path = '/home/nerde/JOB/Projects/PIK/LIRA/LIRA_transformer/';
ncount = 1e6;
m = 6;
w = 0.03; h = 0.15;

aa = [0.03]; bb = 0.08;% bb = a/sqrt(2);%
LL0 = [1 5 7 12 15 20 30 50]; LL1 = [20]; 
llambda = 2;

for i = 1:length(aa)
    for j = 1:length(bb)
        for k = 1:length(LL0)
            for l = 1:length(LL1)
                for u = 1:length(llambda)
                    a = aa(i); b = bb(j); L0 = LL0(k); L1 = LL1(l); lambda = llambda(u);
                    x1=[-w/2 -h/2 0;...
                    -w/2 h/2 0;...
                    w/2 h/2 0;...
                    w/2 -h/2 0;...
                    -a/2 -a/2-b L0;...
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
                    x3=[3 2 8 9;...
                    3 3 10 11;...
                    3 0 4 5;...
                    3 1 6 7;...
                    3 20 12 13;...
                    3 21 14 15;...
                    3 22 16 17;...
                    3 23 18 19];

                    vert = x1;
                    faces = [triangulateFaces(x2(:,2:5));x3(:,2:4)]+1;

                    stlwrite('oct.stl',faces,vert)
                    mesh_transf_comsol(path);
                    stl_to_off_oct_fp('oct_comsol.stl',path);


                    model = mccode('LIRA_oct.instr',['ncount=' num2str(ncount)]);
                    parameters.L0 = L0;
                    parameters.L1 = L1;
                    parameters.guide_m = m;
                    parameters.w = w;
                    parameters.h = h;
                    parameters.lambda = lambda;

                    results = iData(model,parameters);

                    plot(results.UserData.monitors(1))
                    figname = [num2str(lambda) '_' num2str(a) '_' num2str(b) '_' num2str(L0) '_' num2str(L1)];
                    savefig([figname '.fig']);
                    saveas(gcf,[figname '.png'])
                end
            end
        end
    end
end

%results.UserData.monitors(1).Data.values(1);