% Maximilian Salén 970105-1576
clear all;close all;clc


% Initialization
dimensions = [2 3 4 5];
nTrials = 1e4;
nEpochs = 20;
eta = 0.05;
counter = 0;

booleanInputs = [0 1 0 1;0 0 1 1]';

usedBool = [];
for n = 1:length(dimensions)
    for trial = 1:nTrials
        booleanOutputs = randi([0, 1], 2^n, 1);
        booleanOutputs(booleanOutputs==0) = -1;
    
        if booleanOutputs 
           w = randn(n) * 1/sqrt(n);
           theta = 0;
        end
    end

    for epoch = 1:nEpochs
        totalError = 0;
        for i = 2^n
            y = sign();
            error = booleanOutputs(i) - y;
            
            % update w and theta
            

        end
        if totalError == 0
            counter = counter + 1;
            break
        end
    end
    % add booleanOutputs to usedBool
    
end