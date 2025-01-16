% Load configuration settings
config;
cd ..;

% Załadowanie plików -------------------------------------------
[imdsTrain, imdsTest] = preprocessData(datasetPath, 0.8);

% Sieć neurownowa -------------------------------------------
numClasses = numel(unique(imdsTrain.Labels));
layers = defineModel(numClasses);

% Define the path to save the trained network
networkFile = 'trainedNet.mat';

% Check if the network already exists
if isfile(networkFile)
    % Load the trained network
    loadedData = load(networkFile);
    trainedNet = loadedData.trainedNet;
else
    % Set training options
    options = trainingOptions('adam', ...
        'InitialLearnRate', learningRate, ...
        'MaxEpochs', maxEpochs, ...
        'MiniBatchSize', batchSize, ...
        'Plots', 'training-progress', ...
        'ValidationData', imdsTest);

    % Train the model
    trainedNet = trainModel(imdsTrain, layers, options);
    
    % Save the trained network
    save(networkFile, 'trainedNet');
end

% Evaluate the model
accuracy = testModel(trainedNet, imdsTest);
disp(['Model accuracy: ', num2str(accuracy * 100), '%']);



% Przewidywanie marki -------------------------------------------
folderPath = 'loaded';

% Pobierz informacje o pliku w folderze
files = dir(fullfile(folderPath, '*.*')); % Wyszukaj wszystkie pliki (z rozszerzeniem)

% Filtruj, aby znaleźć plik (w folderze powinien być tylko jeden plik)
imageFile = files(~[files.isdir]); % Usuń katalogi z listy

if isempty(imageFile)
    error('Brak pliku w folderze.');
else
    % Zmienna imageFile przechowuje dane o pliku
    newImagePath = fullfile(imageFile(1).folder, imageFile(1).name);  % Pełna ścieżka do pliku
end

label = predictCarBrand(newImagePath, trainedNet);
app.MarkaLabel.Text = char(label);
