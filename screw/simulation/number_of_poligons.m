poligons =[];
for i=[1 3 5 7 10 15 20 40]
    fid = fopen(['D:\JOB\github\Octagon-guide\simulation\data\length\extra_fine\' num2str(i) '.off'],'r');
    tmp = textscan(fid,'%s','Delimiter','\n');
    fclose(fid);
    dat = tmp{1,1}{2};
    dd = str2num(dat);
    dd = dd(1);
    poligons(i) = dd;
end
    