function attendanceGraph()

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

counts = zeros(length(allNames),1);

for i = 1:length(allNames)
    name = allNames(i);

    if ~isempty(data)
        studentData = data(data.Name == name, :);
        counts(i) = length(unique(studentData.Date));
    end
end

figure;
bar(counts);
set(gca,'XTick',1:length(allNames),'XTickLabel',allNames);
title('Attendance Summary');
xlabel('Students');
ylabel('Days Present');
grid on;

end