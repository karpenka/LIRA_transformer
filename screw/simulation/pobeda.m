filename = 'w_5_h_15.stl';
fid=fopen(filename, 'r'); %Open the file, assumes STL ASCII format.

%fmt = '%*s %*s %f32 %f32 %f32 \r\n %*s %*s \r\n %*s %f32 %f32 %f32 \r\n %*s %f32 %f32 %f32 \r\n %*s %f32 %f32 %f32 \r\n %*s \r\n %*s \r\n';
tmp = textscan(fid,'%s','Delimiter',{'\n',' '});
fclose(fid);
vert = []; fac = [];
i = 1;
while i<=length(tmp{1,1})
    if strcmp(tmp{1,1}{i},'vertex') == 1
        vert = [vert;str2num(tmp{1,1}{i+1}) str2num(tmp{1,1}{i+2}) str2num(tmp{1,1}{i+3})];
        i = i + 4;
    else
        i = i + 1;
    end
end

k = 0;
while k<= length(vert)
    fac = [fac;3 k k+1 k+2];
    k = k + 3;
end
x0=['OFF'];
x1=[length(vert) length(fac) 0];
x2 = vert;
x3 = fac;
dlmwrite('test.off',x0,'')
dlmwrite('test.off',x1,'-append','delimiter',' ')
dlmwrite('test.off',x2,'-append','delimiter',' ')
dlmwrite('test.off',x3,'-append','delimiter',' ')
