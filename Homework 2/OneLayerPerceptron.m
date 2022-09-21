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
N = length(inputPattern);
M1 = 3;     % Number of neurons in hidden layer
pVal = height(validationSet);
eta = 0.001;    % Learning rate

% Initialize weights and thresholds
W1 = normrnd(0, 1, [M1, 2]);
W2 = normrnd(0, 1, [M1, 1]);
thresholds = zeros(M1,1);

%% Loop over epochs
pattern = randi(N);
t = target(pattern,1);
x = inputPattern(mu,1:2)';

V = tanh(LocalField(thresholds,W1,x));
O = tanh(LocalField(thresholds,W2,V));

delta = gPrime(LocalField(thresholds,W2,V)).*(t-O);

% Backpropagate error


