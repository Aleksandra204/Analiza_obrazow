clc; clear; close all;

config;

[imdsTrain, imdsTest, augimdsTrain, augimdsTest] = preprocessData(datasetPath, 0.8);

numClasses = numel(unique(imdsTrain.Labels));
layers = defineModel(numClasses);

options = trainingOptions('adam', ...
    'InitialLearnRate', learningRate, ...
    'MaxEpochs', maxEpochs, ...
    'MiniBatchSize', batchSize, ...
    'Plots', 'training-progress', ...
    'ValidationData', augimdsTest);

trainedNet = trainModel(augimdsTrain, layers, options);

accuracy = testModel(trainedNet, imdsTest);
disp(['Dokładność modelu: ', num2str(accuracy * 100), '%']);

newImagePath = 'path_to_new_image.jpg';
label = predictCarBrand(newImagePath, trainedNet);
disp(['Rozpoznana marka samochodu: ', char(label)]);
