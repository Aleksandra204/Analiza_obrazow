function trainedNet = trainModel(augimdsTrain, layers, options)
    trainedNet = trainNetwork(augimdsTrain, layers, options);
    save('trainedNet.mat', 'trainedNet');
end
