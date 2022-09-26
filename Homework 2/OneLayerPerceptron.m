clear all;close all;clc

% Load input data
trainingSet = load('training_set.csv');
validationSet = load('validation_set.csv');

inputPattern = trainingSet(:,1:2);
targets = trainingSet(:,3);

validationPattern = validationSet(:,1:2);
validationTargets = validationSet(:,3);

% Center and std
inputPatternCenter = (inputPattern - mean(inputPattern));
inputPatternStd = std(inputPattern);
validationCenter = (validationPattern - mean(validationPattern));
validationSetStd = std(validationPattern);

% Scaling
inputPattern = inputPatternCenter./inputPatternStd;
validationPattern = validationCenter./validationSetStd;


% Intialize
N = length(inputPattern);
pVal = length(validationSet);
M1 = 10;     % Number of neurons in hidden layer
eta = 0.01;    % Learning rate
errors = zeros(1,pVal);
maxEpochs = 2000;


% Initialize weights and thresholds
W1 = normrnd(0, 1, [M1, 2]);
W2 = normrnd(0, 1, [1, M1]);
thetaOne = zeros(M1,1);
thetaTwo = 0;

for k = 1:maxEpochs
%% Train perceptron
    for i = 1:N
        pattern = randi(N);
        x = inputPattern(pattern,1:2)';
        t = targets(pattern);
        
        
        % Propagate
        V = tanh(LocalField(thetaOne,W1,x));
        O = tanh(LocalField(thetaTwo,W2,V));
       
        
        % Compute errors for output layer
        delta = gPrime(LocalField(thetaTwo,W2,V)).*(t-O);
        outputErrorOne = eta * delta;

        % Propagate backwards
        delta = (delta*W2').*gPrime(LocalField(thetaOne,W1,x));
        outputErrorTwo = eta * delta;

        % Update weights and thresholds        
        W1 = W1 + outputErrorTwo.*x';
        W2 = W2 + outputErrorOne.*V';
        thetaOne = thetaOne - outputErrorTwo;
        thetaTwo = thetaTwo - outputErrorOne;
        


    end
    
    %% Compute error with validation set
    output = zeros(pVal,1);

    for j = 1:pVal
        xValidation = validationPattern(j,1:2)';
        vValidation = tanh(LocalField(thetaOne,W1,xValidation));
        output(j) = tanh(LocalField(thetaTwo,W2,vValidation));
    end
    

    C = ClassificationError(pVal,output,validationTargets);
    errors(k) = C;
    fprintf('Classification error: %.3f Epoch %.f\n',C,k)
    if C < 0.12
        csvwrite('w1.csv', W1);
        csvwrite('w2.csv', W2);
        csvwrite('t1.csv', thetaOne);
        csvwrite('t2.csv', thetaTwo);
        break
    end

end



