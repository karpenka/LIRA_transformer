ppath = '/home/nerde/JOB/comsol/octagon_stl/';
ppath2 = '/home/nerde/JOB/comsol/off/';
files = dir(fullfile(ppath, '*.stl'));
filenames = {files.name};
size_filenames = size(filenames);
for j = 1:size_filenames(2)
    [p,t,tnorm] = stlread([ppath filenames{j}],1);
    x0=['OFF'];
    x1=[num2str(length(p)) ' ' num2str(length(t)) ' 0'];
    x2 = p;
    bb = zeros(length(t),1);
    for i = 1:length(bb)
        bb(i) = 3;
    end
    x3 = [bb t-1];
    dlmwrite([ppath2 filenames{j} '.off'],x0,'')
    dlmwrite([ppath2 filenames{j} '.off'],x1,'-append','delimiter','')
    dlmwrite([ppath2 filenames{j} '.off'],x2,'-append','delimiter',' ')
    if length(p)>=1e5
    dlmwrite([ppath2 filenames{j} '.off'],x3,'precision','%10.0f','-append','delimiter','')
    else
        dlmwrite([ppath2 filenames{j} '.off'],x3,'-append','delimiter',' ')
    end
end