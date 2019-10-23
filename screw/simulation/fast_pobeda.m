[p,t,tnorm] = import_stl_fast('w_5_h_15.stl',1);
x0=['OFF'];
x1=[length(p) length(t) 0];
x2 = p;
bb = zeros(length(t),1);
for i = 1:length(bb)
    bb(i) = 3;
end
x3 = [bb t-1];
dlmwrite('test2.off',x0,'')
dlmwrite('test2.off',x1,'-append','delimiter',' ')
dlmwrite('test2.off',x2,'-append','delimiter',' ')
dlmwrite('test2.off',x3,'-append','delimiter',' ')