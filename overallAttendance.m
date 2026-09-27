function overallAttendance(name)

file = fullfile(pwd,'AttendanceSystem','attendance.csv');

data = readtable(file,'TextType','string');
data.Properties.VariableNames = {'Name','Date','Time','Status'};

name = lower(string(name));
data.Name = lower(string(data.Name));

studentData = data(strcmp(data.Name,name),:);

dates = datetime(studentData.Date,'InputFormat','yyyy-MM-dd');
dates = dates(~isnat(dates));

daysPresent = length(unique(dates));

fprintf('\n📘 OVERALL ATTENDANCE\n');
fprintf('Student : %s\n', name);
fprintf('Days Present : %d\n', daysPresent);

end