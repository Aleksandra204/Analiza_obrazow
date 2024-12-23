function accuracy = testModel(trainedNet, imdsTest)
    predictedLabels = classify(trainedNet, imdsTest);
    accuracy = mean(predictedLabels == imdsTest.Labels);
    confusionchart(imdsTest.Labels, predictedLabels);
end
