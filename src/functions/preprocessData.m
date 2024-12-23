function [imdsTrain, imdsTest] = preprocessData(datasetPath, trainSplit)
% preprocessData - Wczytuje dane obrazowe i dzieli je na zbiory treningowe i testowe.
% 
% Wej�cia:
%   datasetPath - �cie�ka do folderu z obrazami (ka�da marka w osobnym folderze).
%   trainSplit  - Proporcja danych przeznaczona na zb�r treningowy (np. 0.8).
% 
% Wyj�cia:
%   imdsTrain   - ImageDatastore ze zbiorem treningowym.
%   imdsTest    - ImageDatastore ze zbiorem testowym.

    % Sprawdzenie, czy katalog danych istnieje
    if ~isfolder(datasetPath)
        error('Podana �cie�ka do zbioru danych nie istnieje: %s', datasetPath);
    end

    % Tworzenie ImageDatastore z automatycznym przypisaniem etykiet na podstawie nazw folder�w
    imds = imageDatastore(datasetPath, ...
        'IncludeSubfolders', true, ...
        'LabelSource', 'foldernames');

    % Wy�wietlenie liczby obraz�w w ka�dej klasie
    disp('Liczba obraz�w w ka�dej klasie:');
    disp(countEachLabel(imds));

    % Podzia� danych na zbiory treningowy i testowy
    [imdsTrain, imdsTest] = splitEachLabel(imds, trainSplit, 'randomized');

    % Wy�wietlenie liczby obraz�w w zbiorach treningowym i testowym
    fprintf('Liczba obraz�w w zbiorze treningowym: %d\n', numel(imdsTrain.Files));
    fprintf('Liczba obraz�w w zbiorze testowym: %d\n', numel(imdsTest.Files));
end
