function layers = defineModel(numClasses)
    layers = [
        imageInputLayer([224 224 3], 'Name', 'input')
        
        convolution2dLayer(3, 16, 'Padding', 'same', 'Name', 'conv_1')
        batchNormalizationLayer('Name', 'batchnorm_1')
        reluLayer('Name', 'relu_1')
        
        maxPooling2dLayer(2, 'Stride', 2, 'Name', 'maxpool_1')
        
        convolution2dLayer(3, 32, 'Padding', 'same', 'Name', 'conv_2')
        batchNormalizationLayer('Name', 'batchnorm_2')
        reluLayer('Name', 'relu_2')
        
        maxPooling2dLayer(2, 'Stride', 2, 'Name', 'maxpool_2')
        
        convolution2dLayer(3, 64, 'Padding', 'same', 'Name', 'conv_3')
        batchNormalizationLayer('Name', 'batchnorm_3')
        reluLayer('Name', 'relu_3')
        
        fullyConnectedLayer(numClasses, 'Name', 'fc')
        softmaxLayer('Name', 'softmax')
        classificationLayer('Name', 'output')
    ];
end
