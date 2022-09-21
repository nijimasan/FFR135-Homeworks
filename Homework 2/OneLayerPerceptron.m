clear all;close all;clc

% Datahandling
trainingSet = load('training_set.csv');
validationSet = load('validation_set.csv');

inputPattern = trainingSet(:,1:2);
target = trainingSet(:,3);

% Center and std
inputPatternCenter = (inputPattern - mean(inputPattern));
inputPatternStd = std(inputPattern);


% Scaling
inputPattern = inputPatternCenter./inputPatternStd;


% Intialize
N = 1e4;
M1 = 3; % Number of neurons in hidden layer
pVal = height(validationSet);

% Initialize weights and thresholds
W1 = normrnd(0, 1, [M1, 2]);
thresholds = zeros(M1,1);

% Hidden layer
