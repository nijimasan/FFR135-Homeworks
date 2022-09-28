%Maximilian Salén
%19970105-1576
%Last updated: 2022-09-28

clear all
close all
clc

% Load data

[xTrain, tTrain, xValid, tValid, xTest, tTest] = LoadMNIST(3);
xTest2 = loadmnist2();
xTrain = cast(xTrain,'double');
xValid = cast(xValid,'double');
xTest = cast(xTest,'double');
xTest2 = cast(xTest2,'double');

%Standardize data
xTrain = (xTrain-mean(xTrain,4))./max(max(std(xTrain,1,4)));
xValid = (xValid-mean(xValid,4))./max(max(std(xValid,1,4)));
xTest = (xTest-mean(xTest,4))./max(max(std(xTest,1,4)));
xTest2 = (xTest2-mean(xTest2,4))./max(max(std(xTest2,1,4)));

% Intialize network
layers = [ ...
    imageInputLayer([28 28 1])
    convolution2dLayer(3,10,'Padding','same')
    batchNormalizationLayer
    reluLayer

    maxPooling2dLayer(2,'Stride',2)

    convolution2dLayer(3,10,'Padding','same')
    batchNormalizationLayer
    reluLayer

    fullyConnectedLayer(10)
    softmaxLayer
    classificationLayer];
%%
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

%%
%Classification accuracy
clc
load network.mat
classification = classify(network,xTest2);
classification = grp2idx(classification);
csvwrite('classifications.csv',classification);



