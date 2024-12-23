clc;
clear;
close all;

% Load configuration settings
config;

% Preprocess the data
[imdsTrain, imdsTest] = preprocessData(datasetPath, 0.8);

% Define the model
numClasses = numel(unique(imdsTrain.Labels));
layers = defineModel(numClasses);

% Set training options
options = trainingOptions('adam', ...
    'InitialLearnRate', learningRate, ...
    'MaxEpochs', maxEpochs, ...
    'MiniBatchSize', batchSize, ...
    'Plots', 'training-progress', ...
    'ValidationData', imdsTest);

% Train the model
trainedNet = trainModel(imdsTrain, layers, options);

% Evaluate the model
accuracy = testModel(trainedNet, imdsTest);
disp(['Model accuracy: ', num2str(accuracy * 100), '%']);

% Predict the brand of a new car image
newImagePath = 'loaded/test.png';
label = predictCarBrand(newImagePath, trainedNet);
disp(['Predicted car brand: ', char(label)]);
