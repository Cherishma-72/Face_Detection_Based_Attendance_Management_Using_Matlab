function monthlyReport(name)

file = fullfile(pwd,'AttendanceSystem','attendance.csv');

data = readtable(file,'TextType','string');
data.Properties.VariableNames = {'Name','Date','Time','Status'};

name = lower(string(name));
data.Name = lower(string(data.Name));

studentData = data(strcmp(data.Name,name),:);

dates = datetime(studentData.Date,'InputFormat','yyyy-MM-dd');
dates = dates(~isnat(dates));

currentMonth = month(datetime('today'));
currentYear  = year(datetime('today'));

monthlyDates = dates( ...
    month(dates)==currentMonth & ...
    year(dates)==currentYear );

daysPresent = length(unique(monthlyDates));

totalDays = eomday(currentYear, currentMonth);
percentage = (daysPresent / totalDays) * 100;

fprintf('\n📊 MONTHLY REPORT\n');
fprintf('Student : %s\n', name);
fprintf('Days Present : %d\n', daysPresent);
fprintf('Attendance %% : %.2f%%\n', percentage);

end