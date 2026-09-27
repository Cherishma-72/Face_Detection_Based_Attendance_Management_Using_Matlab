function monthlyAttendance(name)

data = readtable('attendance.csv');

% Convert date
data.Date = datetime(data.Date);

% Filter student
studentData = data(strcmp(data.Name,name),:);

% Filter current month
currentMonth = month(datetime('today'));
currentYear = year(datetime('today'));

monthlyData = studentData( ...
    month(studentData.Date)==currentMonth & ...
    year(studentData.Date)==currentYear , :);

% Count attendance
daysPresent = height(monthlyData);

disp(['Monthly Attendance for ' name ': ' num2str(daysPresent) ' days']);

disp(monthlyData);

end