function accuracy = testModel(trainedNet, imdsTest)
    predictedLabels = classify(trainedNet, imdsTest);
    accuracy = sum(predictedLabels == imdsTest.Labels) / numel(imdsTest.Labels);
end
