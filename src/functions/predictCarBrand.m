function label = predictCarBrand(imagePath, trainedNet)
    % Read and preprocess the image
    img = imread(imagePath);
    img = imresize(img, [224, 224]);
    
    % Predict the label
    label = classify(trainedNet, img);
end
