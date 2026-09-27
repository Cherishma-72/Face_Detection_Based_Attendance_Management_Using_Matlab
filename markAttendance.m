function markAttendance(name)

if nargin < 1
    error('Usage: markAttendance("StudentName")');
end

name = lower(strtrim(string(name)));

file = fullfile(pwd,'AttendanceSystem','attendance.csv');

if ~isfolder(fileparts(file))
    mkdir(fileparts(file));
end

if ~isfile(file)
    fid = fopen(file,'w');
    fprintf(fid,'Name,Date,Time,Status\n');
    fclose(fid);
end

data = readtable(file,'TextType','string');
data.Properties.VariableNames = {'Name','Date','Time','Status'};

data.Name = lower(strtrim(string(data.Name)));
data.Date = strtrim(string(data.Date));

% ✅ Correct date
today = string(datetime('now','Format','yyyy-MM-dd'));

% ✅ Strong duplicate check
if any(strcmp(data.Name, name) & strcmp(data.Date, today))
    disp(['⚠️ ' char(name) ' already marked today']);
    return;
end

currentTime = datetime('now');

if hour(currentTime) < 10
    status = "On Time";
else
    status = "Late";
end

fid = fopen(file,'a');
fprintf(fid,'%s,%s,%s,%s\n', ...
    name, ...
    today, ...
    string(datetime('now','Format','HH:mm:ss')), ...
    status);
fclose(fid);

disp(['✅ ' char(name) ' marked ' char(status)]);
end