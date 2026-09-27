function processed = preprocessFace(img)

% ---------- HANDLE NO INPUT ----------
if nargin == 0
    [file, path] = uigetfile({'*.jpg;*.png'}, 'Select Image');
    
    if isequal(file,0)
        disp('No image selected');
        processed = [];
        return;
    end
    
    img = imread(fullfile(path,file));
end

% ---------- PREPROCESS ----------
if size(img,3) == 3
    img = rgb2gray(img);
end

img = imresize(img,[100 100]);

% 🔥 better than histeq
img = adapthisteq(img);

processed = medfilt2(img);

end