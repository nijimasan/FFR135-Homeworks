% Maximilian Salén 970105-1576
clear all;close all;clc


% Initialization
dimension = [2 3 4 5];
nTrials = 1e4;
nEpochs = 20;
eta = 0.05;
counter = 0;

booleanInputs = [0 1 0 1;0 0 1 1]';

usedBool = [1 1 1 1]';
index = 1;

for n = 1:length(dimension)
    for trial = 1:nTrials
        booleanOutputs = randi([0, 1], 2^(dimension(n)), 1);
        booleanOutputs(booleanOutputs==0) = -1;
    
        if ismember(booleanOutputs, usedBool, 'rows') == 0
           w = randn(n) * 1/sqrt(n);
           theta = 0;
        end
    end

    for epoch = 1:nEpochs
        totalError = 0;
        for mu = 2^dimension(n)
            y = w(:,dimenstions(n))*booleanInputs(:,mu)-theta;
            error = booleanOutputs(mu) - y;
            
            % update w and theta
            w = w - eta*(t-y(mu))*booleanOutputs;
            theta = theta - -eta*(t-y(mu));
            totalError = totalError + abs(error);

        end
        if totalError == 0
            counter = counter + 1;
            break
        end
    end
    %add booleanOutputs to usedBool
      usedBool(index) = booleanOutputs;
      index = index + 1;
end