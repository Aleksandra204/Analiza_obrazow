function [imdsTrain, imdsTest] = preprocessData(datasetPath, trainRatio)
    % Load image datastore
    imds = imageDatastore(datasetPath, 'IncludeSubfolders', true, 'LabelSource', 'foldernames');
    
    % Split the data into training and testing sets
    [imdsTrain, imdsTest] = splitEachLabel(imds, trainRatio, 'randomized');
    
    % You can also add image preprocessing here if needed
    imdsTrain.ReadFcn = @(filename)readAndPreprocessImage(filename);
    imdsTest.ReadFcn = @(filename)readAndPreprocessImage(filename);
end

function img = readAndPreprocessImage(filename)
    img = imread(filename);
    % Resize the image if needed (for example, 224x224 for a CNN)
    img = imresize(img, [224, 224]);
end
