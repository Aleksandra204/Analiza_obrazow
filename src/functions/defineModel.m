function layers = defineModel(numClasses)
    net = resnet50;
    layers = net.Layers;
    layers(end-2) = fullyConnectedLayer(numClasses, 'Name', 'fc');
    layers(end) = classificationLayer('Name', 'output');
end
