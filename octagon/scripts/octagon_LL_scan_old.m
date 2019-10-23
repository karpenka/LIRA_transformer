path = '/home/nerde/JOB/comsol/off/';
files = dir(fullfile(path, '*.off'));
filenames = {files.name};

a= 0.07;

i=1;
while i<=length(filenames)
    try
    
    octagon_n(['off/' filenames{i}])
    fname = filenames{i};
% 
%     if strcmp(fname(11),'_') == 1
%         a = str2num(fname(10));
%     else
%         a = str2num(fname(10:11));
%     end
%     a_size(i) = a;
    if strcmp(fname(2),'_') == 1
        L0 = str2num(fname(1));
        if strcmp(fname(4),'_') == 1
            L1 = str2num(fname(3));
        else
            L1 = str2num(fname(3:4));
        end
    else 
        L0 = str2num(fname(1:2));
        if strcmp(fname(5),'_') == 1
            L1 = str2num(fname(4));
        else
            L1 = str2num(fname(4:5));
        end
    end
    
    model = mccode('LIRA_oct_n.instr','ncount=1e6');
    
    parameters.L0 = L0;
    parameters.L1 = L1;
    parameters.lambda = 5;
    parameters.guide_m = 6;
    parameters.w = 0.03;
    parameters.h = 0.15;

    results = iData(model,parameters);
    sum(i) = results.UserData.monitors(1).Data.values(1);
    L0_m(i) = L0;
    L1_m(i) = L1;
    %plot(results.UserData.monitors(1))
    %figure;
    %plot(results.UserData.monitors(1).Data.x,results.UserData.monitors(1).Data.data,'DisplayName',num2str(L1))
    %legend
    i = i+1;
    catch
        i = i+1;
    end
end

%figure;
%plot(L,sum,'o')