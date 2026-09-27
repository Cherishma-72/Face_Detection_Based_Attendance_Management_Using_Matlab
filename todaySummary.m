function todaySummary()

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

% ---------- CLEAN DATA (VERY IMPORTANT) ----------
if ~isempty(data)
    
    % 🔥 FORCE STRING TYPE
    data.Name = string(data.Name);
    data.Date = string(data.Date);

    % 🔥 REMOVE INVALID DATES LIKE 2026-00-10
    data = data(~contains(data.Date,'00'), :);

    % 🔥 NORMALIZE TEXT
    data.Name = lower(strtrim(data.Name));
    data.Date = strtrim(data.Date);
end

% ---------- GET TODAY ----------
today = string(datetime('now','Format','yyyy-MM-dd'));

present = strings(0);

% ---------- FIND PRESENT ----------
if ~isempty(data)
    present = unique(data.Name(strcmp(data.Date, today)));
end

% ---------- FIND ABSENT ----------
absent = setdiff(allNames, present);

% ---------- TABLE OUTPUT ----------
T1 = table(present, 'VariableNames', {'PresentStudents'});
T2 = table(absent, 'VariableNames', {'AbsentStudents'});

% ---------- DISPLAY ----------
fprintf('\n📅 TODAY SUMMARY\n');
fprintf('-------------------------\n');
fprintf('Total Students : %d\n', length(allNames));
fprintf('Present        : %d\n', length(present));
fprintf('Absent         : %d\n', length(absent));

disp('✅ PRESENT STUDENTS');
disp(T1);

disp('❌ ABSENT STUDENTS');
disp(T2);

end