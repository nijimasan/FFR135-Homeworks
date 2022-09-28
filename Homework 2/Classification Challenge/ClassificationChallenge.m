%Maximilian Salén
%19970105-1576
%Last updated: 2022-09-28

clear all
close all
clc

% Load data
[xTrain, tTrain, xValid, tValid, xTest1, tTest1] = LoadMNIST(3);
xTest2 = loadmnist2();
xTrain = cast(xTrain,'double');
xValid = cast(xValid,'double');
xTest1 = cast(xTest1,'double');
xTest2 = cast(xTest2,'double');

%Standardize data
xTrain = (xTrain-mean(xTrain,4))./max(max(std(xTrain,1,4)));
xValid = (xValid-mean(xValid,4))./max(max(std(xValid,1,4)));
xTest1 = (xTest1-mean(xTest1,4))./max(max(std(xTest1,1,4)));
xTest2 = (xTest2-mean(xTest2,4))./max(max(std(xTest2,1,4)));

% Intialize network layers
layers = [ ...
    imageInputLayer([28 28 1])
    convolution2dLayer(5,20,'Padding','same')
    batchNormalizationLayer
    reluLayer

    maxPooling2dLayer(2,'Stride',2)
    fullyConnectedLayer(50,'WeightsInitializer', 'narrow-normal')
    reluLayer

    convolution2dLayer(3,10,'Padding','same')
    batchNormalizationLayer
    reluLayer

    fullyConnectedLayer(10)
    softmaxLayer
    classificationLayer];

% Train network
options = trainingOptions( ...
'sgdm', ...
'Momentum',0.9, ...
'InitialLearnRate',0.01, ...
'MiniBatchSize',8192, ...
'MaxEpochs',30, ...
'ValidationFrequency',30, ...
'ValidationPatience',5, ...
'ValidationData',{xValid,tValid});

network = trainNetwork(xTrain,tTrain,layers,options);
save network

%% Run this if you have saved network.mat

%Classification accuracy for test set 1
clc
load network.mat
testOneClassification = classify(network,xTest1);
classificationAccuracy = sum(testOneClassification==tTest1)/numel(tTest1);
fprintf('\nClassification Accuracy: %4.4f\n',classificationAccuracy)

% Classification of test 2
test2Classification = classify(network,xTest2);
test2Classification = string(test2Classification);
test2Classification = double(test2Classification);
csvwrite('classifications.csv',test2Classification);




