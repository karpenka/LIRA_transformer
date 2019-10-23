function stl_to_off_oct_fp_output_file(filename,filename_out,path)
ppath = path;

[p,t,tnorm] = stlread(filename,1);
x0=['OFF'];
x1=[num2str(length(p)) ' ' num2str(length(t)) ' 0'];
x2 = p;
bb = zeros(length(t),1);
for i = 1:length(bb)
    bb(i) = 3;
end
x3 = [bb t-1];
dlmwrite([filename_out '.off'],x0,'')
dlmwrite([filename_out '.off'],x1,'-append','delimiter','')
dlmwrite([filename_out '.off'],x2,'-append','delimiter',' ')
if length(p)>=1e5
dlmwrite([filename_out '.off'],x3,'precision','%10.0f','-append','delimiter','')
else
    dlmwrite([filename_out '.off'],x3,'-append','delimiter',' ')
end
end