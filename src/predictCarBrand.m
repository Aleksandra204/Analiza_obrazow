function label = predictCarBrand(imagePath, trainedNet)
    img = imread(imagePath);
    img = imresize(img, [224, 224]);
    label = classify(trainedNet, img);
    imshow(img);
    title(['Rozpoznana marka: ', char(label)]);
end
