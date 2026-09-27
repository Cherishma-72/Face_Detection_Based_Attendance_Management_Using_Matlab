function label = recognizeFace(testFace)

% ---------- INPUT ----------
if nargin == 0
    [file, path] = uigetfile({'*.jpg;*.png'}, 'Select Image');
    
    if isequal(file,0)
        disp('No image selected');
        label = "Unknown";
        return;
    end
    
    testFace = imread(fullfile(path,file));
end

% ---------- LOAD MODEL ----------
if ~isfile('trainedModel.mat')
    error('Run trainModel first!');
end

load('trainedModel.mat','features','labels','meanFace','eigenfaces','threshold');

% ---------- PREPROCESS ----------
if size(testFace,3)==3
    testFace = rgb2gray(testFace);
end

faceDetector = vision.CascadeObjectDetector();
bbox = step(faceDetector, testFace);

if ~isempty(bbox)
    testFace = imcrop(testFace, bbox(1,:));
end

testFace = imresize(testFace,[100 100]);
testFace = adapthisteq(testFace);
testFace = im2double(testFace);

testVector = testFace(:);

% ---------- PROJECT ----------
testFeature = eigenfaces' * (testVector - meanFace);

% ---------- DISTANCE ----------
distances = vecnorm(features - testFeature);

[minDist, idx] = min(distances);
sortedDist = sort(distances);
gap = sortedDist(2) - sortedDist(1);

% ---------- DEBUG ----------
disp("Distances:");
disp(distances);
disp(['MinDist: ' num2str(minDist)]);
disp(['Gap: ' num2str(gap)]);
disp(['Threshold: ' num2str(threshold)]);

% ---------- FINAL DECISION (BALANCED FIX) ----------
if minDist < threshold
    if gap > 1 || minDist < (0.75 * threshold)
        label = labels(idx);
    else
        label = "Unknown";
    end
else
    label = "Unknown";
end

% ---------- OUTPUT ----------
disp(['Recognized: ' char(label)]);

end