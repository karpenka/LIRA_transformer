ppath = 'd:\JOB\github\Octagon-guide\simulation\new_shit\stl\';
ppath_e = 'd:\JOB\github\Octagon-guide\simulation\new_shit\off\';
files = dir(fullfile(ppath, '*.off'));
filenames = {files.name};
for i = 1:length(filenames)
    fname = filenames{i};
    ss = size(fname);
    for i = 2:ss(2)
        if (strcmp(fname(i),'_') == 0) && (all(ismember(fname(i), '0123456789+-.eEdD')) == 0)
            width = fname(i+2);
            if strcmp(fname(i+7),'.') ==1
                height = fname(i+6);
            else
                height = fname(i+6:i+7);
            end
            break
        end
    end
    folder = [ppath_e 'w' width 'h' height '\'];
    mkdir(folder)
    copyfile([ppath fname], folder);
end
