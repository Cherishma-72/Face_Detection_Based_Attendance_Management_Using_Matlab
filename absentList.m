function absentList()

% ---------- LOAD STUDENTS ----------
imds = imageDatastore('dataset', ...
    'IncludeSubfolders', true, ...
    'LabelSource', 'foldernames');

allNames = lower(string(unique(imds.Labels)));

% ---------- FILE PATH ----------
file = fullfile(pwd,'AttendanceSystem','attendance.csv');

% ---------- READ DATA ----------
if isfile(file)
    data = readtable(file,'TextType','string');
    data.Properties.VariableNames = {'Name','Date','Time','Status'};
else
    data = table();
end

% ---------- CLEAN DATA ----------
if ~isempty(data)
    
    % 🔥 FORCE STRING FIRST (IMPORTANT)
    data.Name = string(data.Name);
    data.Date = string(data.Date);

    % 🔥 REMOVE INVALID DATES
    data = data(~contains(data.Date,'00'), :);

    % 🔥 NORMALIZE
    data.Name = lower(strtrim(data.Name));
    data.Date = strtrim(data.Date);
end

% ---------- TODAY ----------
today = string(datetime('now','Format','yyyy-MM-dd'));

present = strings(0);

% ---------- FIND PRESENT ----------
if ~isempty(data)
    present = unique(data.Name(strcmp(data.Date, today)));
end

% ---------- FIND ABSENT ----------
absent = setdiff(allNames, present);

% ---------- TABLE OUTPUT ----------
T = table(absent, 'VariableNames', {'AbsentStudents'});

disp('❌ ABSENT STUDENTS TODAY');
disp(T);

end