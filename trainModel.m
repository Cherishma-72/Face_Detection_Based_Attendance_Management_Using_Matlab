function trainModel()

clc;
disp('📸 Training Model with PCA...');

datasetPath = 'dataset';

imds = imageDatastore(datasetPath, ...
    'IncludeSubfolders', true, ...
    'LabelSource', 'foldernames');

numImages = numel(imds.Files);

dataMatrix = [];
labels = [];

% 🔥 Create detector once
faceDetector = vision.CascadeObjectDetector();

for i = 1:numImages
    
    % ---------- READ IMAGE ----------
    img = readimage(imds, i);

    % ---------- PREPROCESS ----------
    if size(img,3)==3
        img = rgb2gray(img);
    end

    % 🔥 FACE DETECTION
    bbox = step(faceDetector, img);
    if ~isempty(bbox)
        img = imcrop(img, bbox(1,:));
    end

    % 🔥 RESIZE + NORMALIZE
    img = imresize(img,[100 100]);
    img = adapthisteq(img);
    img = im2double(img);

    % ---------- STORE ----------
    dataMatrix(:,i) = img(:);
    labels = [labels; string(imds.Labels(i))];
end

% ---------- PCA ----------
meanFace = mean(dataMatrix,2);
A = dataMatrix - meanFace;

[U,~,~] = svd(A,'econ');

k = 50;
eigenfaces = U(:,1:k);

features = eigenfaces' * A;

% ---------- BETTER THRESHOLD ----------
allDistances = [];

for i = 1:size(features,2)
    for j = i+1:size(features,2)
        if labels(i) == labels(j)  % only SAME person distances
            d = norm(features(:,i) - features(:,j));
            allDistances = [allDistances d];
        end
    end
end

threshold = mean(allDistances) + std(allDistances);  % 🔥 much better

% ---------- SAVE ----------
save('trainedModel.mat','features','labels','meanFace','eigenfaces','threshold');

disp('✅ Training Completed!');
disp(['Threshold set to: ' num2str(threshold)]);

end