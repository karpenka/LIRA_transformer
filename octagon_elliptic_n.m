function octagon_elliptic_n(n)
dlmwrite('octa_ell_n.instr',' ')
fid = fopen('octa_ell_n1.instr','r');
tmp = textscan(fid,'%s','Delimiter','\n');
fclose(fid);
for i=1:length(tmp{1,1})
    if isempty(char(tmp{1,1}(i))) == 1
        dlmwrite('octa_ell_n.instr',' ','-append','delimiter','')
    else
        dlmwrite('octa_ell_n.instr',char(tmp{1,1}(i)),'-append','delimiter','')
    end
end
for j = 2:n
    dlmwrite('octa_ell_n.instr',' ','-append','delimiter','\n')
    fid = fopen('octa_ell_n21.instr','rt');
    tmp = textscan(fid,'%s','Delimiter','\n');
    fclose(fid);
    for i=1:length(tmp{1,1})
        if isempty(char(tmp{1,1}(i))) == 1
            1;
        else
            dlmwrite('octa_ell_n.instr',char(tmp{1,1}(i)),'-append','delimiter','')
        end
    end
    
    a = 'geometry = "';
    b = string(j);
    c = '.off",';
    z = char(join([a b c],""));
    file = fopen('octa_ell_n.instr','a');
    fprintf(file,z);
    fclose(file);
    
    dlmwrite('octa_ell_n.instr',' ','-append','delimiter','\n')
    fid = fopen('octa_ell_n22.instr','rt');
    tmp = textscan(fid,'%s','Delimiter','\n');
    fclose(fid);
    for i=1:length(tmp{1,1})
        if isempty(char(tmp{1,1}(i))) == 1
            1;
        else
            dlmwrite('octa_ell_n.instr',char(tmp{1,1}(i)),'-append','delimiter','')
        end
    end
end

dlmwrite('octa_ell_n.instr',' ','-append','delimiter','\n')
fid = fopen('octa_ell_n3.instr','rt');
tmp = textscan(fid,'%s','Delimiter','\n');
fclose(fid);
for i=1:length(tmp{1,1})
    if isempty(char(tmp{1,1}(i))) == 1
        1;
    else
        dlmwrite('octa_ell_n.instr',char(tmp{1,1}(i)),'-append','delimiter','')
    end
end

end