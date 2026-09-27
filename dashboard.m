function dashboard()

imds = imageDatastore('dataset', ...
    'IncludeSubfolders', true, ...
    'LabelSource', 'foldernames');

allNames = lower(string(unique(imds.Labels)));

file = fullfile(pwd,'AttendanceSystem','attendance.csv');

if isfile(file)
    data = readtable(file,'TextType','string');
    data.Properties.VariableNames = {'Name','Date','Time','Status'};
else
    data = table();
end

result = {};

for i = 1:length(allNames)

    name = allNames(i);

    if ~isempty(data)
        studentData = data(strcmp(data.Name,name),:);

        dates = datetime(studentData.Date,'InputFormat','yyyy-MM-dd');
        dates = dates(~isnat(dates));

        daysPresent = length(unique(dates));
    else
        daysPresent = 0;
    end

    percentage = (daysPresent/30)*100;

    result = [result; {name, daysPresent, percentage}];
end

T = cell2table(result, ...
    'VariableNames', {'Name','DaysPresent','Percentage'});

disp('📋 ATTENDANCE DASHBOARD');
disp(T);

end