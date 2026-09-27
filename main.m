function main()

clc;

% Load dataset
imds = imageDatastore('dataset', ...
    'IncludeSubfolders', true, ...
    'LabelSource', 'foldernames');

% Start camera
cam = webcam;

% Capture image
img = snapshot(cam);

% Face detector
faceDetector = vision.CascadeObjectDetector('FrontalFaceCART', ...
    'MinSize',[60 60], ...
    'MergeThreshold',4);

% Detect face
bbox = faceDetector(img);

imshow(img);
title('Captured Image');
hold on;

if ~isempty(bbox)
    
    % Draw rectangle
    for i = 1:size(bbox,1)
        rectangle('Position',bbox(i,:), ...
            'EdgeColor','g','LineWidth',2);
    end
    
    hold off;
    
    % Extract first face
    face = imcrop(img, bbox(1,:));
    
    % Preprocess (optional display)
    processed = preprocessFace(face);
    
    figure;
    subplot(1,2,1);
    imshow(face);
    title('Original Face');
    
    subplot(1,2,2);
    imshow(processed);
    title('Preprocessed Face');
    
    % ---------- RECOGNITION ----------
    label = recognizeFace(face);
    
    % Show result on image
    img = insertObjectAnnotation(img,'rectangle',bbox(1,:),char(label));
    figure;
    imshow(img);
    title('Recognition Result');
    
    % ---------- ATTENDANCE ----------
    if ~strcmp(label, "Unknown")

        fprintf('Recognized: %s\n', char(label));

        % Play sound
        load handel.mat
        sound(y, Fs)

        % 🔥 Save image in folder
        folder = 'CapturedImages';
        if ~exist(folder,'dir')
            mkdir(folder);
        end

        filename = fullfile(folder, ...
            [char(label) '_' datestr(now,'yyyymmdd_HHMMSS') '.jpg']);

        imwrite(img, filename);

        % Mark attendance
        markAttendance(label);

    else
        disp('❌ Face not recognized');
    end

else
    hold off;
    disp('❌ No face detected');
end

clear cam;

end