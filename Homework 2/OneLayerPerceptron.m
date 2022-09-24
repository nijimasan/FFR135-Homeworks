clear all;close all;clc

% Load input data
trainingSet = load('training_set.csv');
validationSet = load('validation_set.csv');

inputPattern = trainingSet(:,1:2);
targets = trainingSet(:,3);

% Center and std
inputPatternCenter = (inputPattern - mean(inputPattern));
inputPatternStd = std(inputPattern);

% Scaling
inputPattern = inputPatternCenter./inputPatternStd;


% Intialize
N = length(inputPattern);
M1 = 8;     % Number of neurons in hidden layer
pVal = height(validationSet);
eta = 0.01;    % Learning rate
errors = zeros(1,pVal);
maxIterations = 5000;


% Initialize weights and thresholds
W1 = normrnd(0, 1, [M1, 2]);
W2 = normrnd(0, 1, [1, M1]);
thetaOne = zeros(M1,1);
thetaTwo = 0;

for k = 1:maxIterations
%% Train perceptron
    for i = 1:N
        pattern = randi(N);
        t = targets(pattern);
        x = inputPattern(pattern,1:2)';
        
        V = tanh(LocalField(thetaOne,W1,x));
        O = tanh(LocalField(thetaTwo,W2,V));
        
        
        
        % Backpropagate error and update
        delta = gPrime(LocalField(thetaTwo,W2,V)).*(t-O);
        W2 = W2 + eta * delta.*V';
        thetaTwo = thetaTwo - eta * delta;
        
        delta = delta.*W2*gPrime(LocalField(thetaOne,W1,x));
        W1 = W1 + eta * delta.*x';
        thetaOne = thetaOne - eta * delta;
    end
    
    %% Compute error with validation set
    output = zeros(pVal,1);

    for j = 1:pVal
        xValidation = validationSet(j,1:2)';
        vValidation = tanh(LocalField(thetaOne,W1,xValidation));
        output(j) = tanh(LocalField(thetaTwo,W2,vValidation));
    end
    
    validationTargets = validationSet(:,3);
    C = ClassificationError(pVal,output,validationTargets);
    fprintf('Classification error: %.3f Iteration: %.f\n',C,k)
    if C < 0.12
        break
    end

end

