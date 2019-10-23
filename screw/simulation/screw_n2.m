function screw_n2(n)
dlmwrite('screw_n.instr',' ')
fid = fopen('screw_part1.instr','r');
tmp = textscan(fid,'%s','Delimiter','\n');
fclose(fid);
for i=1:length(tmp{1,1})
    if isempty(char(tmp{1,1}(i))) == 1
        dlmwrite('screw_n.instr',' ','-append','delimiter','')
    else
        dlmwrite('screw_n.instr',char(tmp{1,1}(i)),'-append','delimiter','')
    end
end
a = 'geometry = "data/';
b = num2str(n);
c = '0m.off",';
z = char(strjoin([a b c],''));
file = fopen('screw_n.instr','a');
fprintf(file,z);
fclose(file);
dlmwrite('screw_n.instr',' ','-append','delimiter','\n')
fid = fopen('screw_part2.instr','rt');
tmp = textscan(fid,'%s','Delimiter','\n');
fclose(fid);
for i=1:length(tmp{1,1})
    if isempty(char(tmp{1,1}(i))) == 1
        dlmwrite('scre.w_n.instr',' ','-append','delimiter','')
    else
        dlmwrite('screw_n.instr',char(tmp{1,1}(i)),'-append','delimiter','')
    end
end
