function [imdsTrain, imdsTest] = preprocessData(datasetPath, trainSplit)
% preprocessData - Wczytuje dane obrazowe i dzieli je na zbiory treningowe i testowe.
% 
% Wejœcia:
%   datasetPath - œcie¿ka do folderu z obrazami (ka¿da marka w osobnym folderze).
%   trainSplit  - Proporcja danych przeznaczona na zbór treningowy (np. 0.8).
% 
% Wyjœcia:
%   imdsTrain   - ImageDatastore ze zbiorem treningowym.
%   imdsTest    - ImageDatastore ze zbiorem testowym.

    % Sprawdzenie, czy katalog danych istnieje
    if ~isfolder(datasetPath)
        error('Podana œcie¿ka do zbioru danych nie istnieje: %s', datasetPath);
    end

    % Tworzenie ImageDatastore z automatycznym przypisaniem etykiet na podstawie nazw folderów
    imds = imageDatastore(datasetPath, ...
        'IncludeSubfolders', true, ...
        'LabelSource', 'foldernames');

    % Wyœwietlenie liczby obrazów w ka¿dej klasie
    disp('Liczba obrazów w ka¿dej klasie:');
    disp(countEachLabel(imds));

    % Podzia³ danych na zbiory treningowy i testowy
    [imdsTrain, imdsTest] = splitEachLabel(imds, trainSplit, 'randomized');

    % Wyœwietlenie liczby obrazów w zbiorach treningowym i testowym
    fprintf('Liczba obrazów w zbiorze treningowym: %d\n', numel(imdsTrain.Files));
    fprintf('Liczba obrazów w zbiorze testowym: %d\n', numel(imdsTest.Files));
end
