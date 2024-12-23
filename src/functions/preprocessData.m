function [imdsTrain, imdsTest] = preprocessData(datasetPath, trainRatio)
    % Load image datastore
    imds = imageDatastore(datasetPath, 'IncludeSubfolders', true, 'LabelSource', 'foldernames');
    
    % Split the data into training and testing sets
    [imdsTrain, imdsTest] = splitEachLabel(imds, trainRatio, 'randomized');
    
    % Ensure all images are resized to the same size
    imdsTrain.ReadFcn = @(filename)readAndPreprocessImage(filename);
    imdsTest.ReadFcn = @(filename)readAndPreprocessImage(filename);
end

function img = readAndPreprocessImage(filename)
    try
        img = imread(filename);  % Try reading the image
        
        % Check if the image is grayscale and convert to RGB if needed
        if size(img, 3) == 1
            img = cat(3, img, img, img);  % Convert grayscale to RGB
        end
        
        % Resize the image to the fixed input size (e.g., 224x224)
        img = imresize(img, [224, 224]);
    catch ME
        % If there's an error reading the image, display a warning and skip this image
        disp(['Warning: Could not read image ', filename, '. Skipping this image.']);
        img = [];  % Return an empty matrix as a placeholder
    end
end

