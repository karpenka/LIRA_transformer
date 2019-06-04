function octagon_n(n)
dlmwrite('LIRA_oct_n.instr',' ')
fid = fopen('LIRA_oct_part1.instr','r');
tmp = textscan(fid,'%s','Delimiter','\n');
fclose(fid);
for i=1:length(tmp{1,1})
    if isempty(char(tmp{1,1}(i))) == 1
        dlmwrite('LIRA_oct_n.instr',' ','-append','delimiter','')
    else
        dlmwrite('LIRA_oct_n.instr',char(tmp{1,1}(i)),'-append','delimiter','')
    end
end
a = 'geometry = "';
b = n;
c = '",';
z = char(strjoin([a b c],''));
file = fopen('LIRA_oct_n.instr','a');
fprintf(file,z);
fclose(file);
dlmwrite('LIRA_oct.instr',' ','-append','delimiter','\n')
fid = fopen('LIRA_oct_part2.instr','rt');
tmp = textscan(fid,'%s','Delimiter','\n');
fclose(fid);
for i=1:length(tmp{1,1})
    if isempty(char(tmp{1,1}(i))) == 1
        1+1;
    else
        dlmwrite('LIRA_oct_n.instr',char(tmp{1,1}(i)),'-append','delimiter','')
    end
end
