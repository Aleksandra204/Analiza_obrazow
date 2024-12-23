function [imdsTrain, imdsTest, augimdsTrain, augimdsTest] = preprocessData(datasetPath, trainSplit)
    imds = imageDatastore(datasetPath, ...
        'IncludeSubfolders', true, ...
        'LabelSource', 'foldernames');

    [imdsTrain, imdsTest] = splitEachLabel(imds, trainSplit, 'randomized');

    augmenter = imageDataAugmenter( ...
        'RandRotation', [-20, 20], ...
        'RandXReflection', true, ...
        'RandScale', [0.8, 1.2]);

    augimdsTrain = augmentedImageDatastore([224, 224], imdsTrain, ...
        'DataAugmentation', augmenter);

    augimdsTest = augmentedImageDatastore([224, 224], imdsTest);
end
