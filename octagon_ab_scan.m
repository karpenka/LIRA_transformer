clear all;
L0 = 10;
L1 = 1;
a_min = 0.01;
a_step = 0.01;
a_max = 0.2;
b_min = 0.01;
b_step = 0.01;
b_max = 0.2;
m = 6;
ncount = 1e5;
w = 0.03;
h = 0.15;
lambda = 2;
pic_name = ['ab_scan_2AA' num2str(L0)];
%path = '/home/nerde/JOB/Projects/PIK/LIRA/Octagon';
path = '/Users/peterkonik/JOB/git_repos/LIRA_transformer';

model = mccode('LIRA_oct.instr',['ncount=' num2str(ncount)]);
parameters.L0 = L0;
parameters.L1 = L1;
parameters.guide_m = m;
parameters.w = w;
parameters.h = h;
parameters.lambda = lambda;

i=1;
for a = a_min:a_step:a_max
    j=1;
    for b = b_min:b_step:b_max
        
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

aa=a_min:a_step:a_max;
bb=b_min:b_step:b_max;
[X,Y]=meshgrid(aa,bb);
X = X';
Y = Y';
figure;
surf(X,Y,sum)
savefig([pic_name '.fig']);
xlabel('a, m')
ylabel('b, m')
zlabel('signal')

