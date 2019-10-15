
clear all;
path = '/home/nerde/JOB/github/LIRA_transformer';
% path = '/Users/peterkonik/JOB/git_repos/LIRA_transformer';
n = 79;
octagon_elliptic_n(n)

w1=0.01/2;
w2=0.075;
h1=w2;
h2=0.01/2;
L=40;

ncount = 1e6;
L0=L;
m=6;
ww = w1*2;
hh = w2*2;
lambda = 2;

%fixed parameters

l=0;
%parameters to scan
l0=12; %l0< L*(w1-sqrt(w1*w2))/(w1-w2)


        %scan step l


        for j = 1:n
            lin=l;
            l = l +L/n;

            omega_in = (w2-w1)/(L^2-2*l0*L)*lin^2 + 2*(w1-w2)/(L^2-2*l0*L)*l0*lin + w1;
            eta_in = (h2-h1)/(L^2-2*(L-l0)*L)*lin^2 + 2*(h1-h2)/(L^2-2*(L-l0)*L)*(L-l0)*lin + h1;

            w_in = w1 + (w2-w1)/L*lin;
            h_in = h1 + (h2-h1)/L*lin;

            omega = (w2-w1)/(L^2-2*l0*L)*l^2 + 2*(w1-w2)/(L^2-2*l0*L)*l0*l + w1;
            eta = (h2-h1)/(L^2-2*(L-l0)*L)*l^2 + 2*(h1-h2)/(L^2-2*(L-l0)*L)*(L-l0)*l + h1;

            w = w1 + (w2-w1)/L*l;
            h = h1 + (h2-h1)/L*l;
            % 
            % 0 (-w; eta)
            % 1 (-omega; h)
            % 2 (omega; h)
            % 3 (w; eta)
            % 4 (w; -eta)
            % 5 (omega; -h)
            % 6 (-omega; -h)
            % 7 (-w; -eta)

            x1=[-w_in eta_in lin;...
            -omega_in h_in lin;...
            omega_in h_in lin;...
            w_in eta_in lin;...
            w_in -eta_in lin;...
            omega_in -h_in lin;...
            -omega_in -h_in lin;...
            -w_in -eta_in lin;...
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
            stl_to_off_oct_fp_output_file('oct_comsol.stl',num2str(j),path);
        end
% 
%         model = mccode('octa_ell_n.instr',['ncount=' num2str(ncount)]);
%         parameters.L0 = L0;
%         parameters.guide_m = m;
%         parameters.w = ww;
%         parameters.h = hh;
%         parameters.lambda = lambda;
%         results = iData(model,parameters);
%         sum1 = results.UserData.monitors(1).Data.values(1);
%         sum2 = results.UserData.monitors(1).Data.values(2);
%         sum3 = results.UserData.monitors(1).Data.values(3);
% 
% figure;
% plot(sum1);
% figure;
% plot(sum2);
% figure;
% plot(sum3);