clear all;
L1_min = 1;
L1_step = 2.5;
L1_max = 51;
L0_min = 1;
L0_step = 2.5;
L0_max = 51;
m = 6;
ncount = 1e6;
w = 0.03;
h = 0.15;
a = 0.03;
b = 0.09;

lambda = 2;
pic_name = ['L_L_scan_' num2str(a) '_' num2str(b)];
path = '/home/nerde/JOB/Projects/PIK/LIRA/LIRA_transformer';
%path = '/Users/peterkonik/JOB/git_repos/LIRA_transformer/';

model = mccode('LIRA_oct.instr',['ncount=' num2str(ncount)]);


parameters.guide_m = m;
parameters.w = w;
parameters.h = h;
parameters.lambda = lambda;

i=1;
for L0 = L0_min:L0_step:L0_max
    j=1;
    for L1 = L1_min:L1_step:L1_max
        
        try
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
        
        parameters.L0 = L0;
        parameters.L1 = L1;
        results = iData(model,parameters);
        sum(i,j) = results.UserData.monitors(1).Data.values(1);
        j = j + 1;
        catch
            sum(i,j) = -1;
            j = j+1;
        end
    end
    i = i + 1;
end


LL0=L0_min:L0_step:L0_max;
LL1=L1_min:L1_step:L1_max;
[X,Y]=meshgrid(LL0,LL1);
X = X';
Y = Y';
figure;
surf(X,Y,sum)


xlabel('L0, m')
ylabel('L1, m')
zlabel('I')
view(2)
colorbar
savefig([pic_name '.fig']);
saveas(gcf,[pic_name '.png'])

