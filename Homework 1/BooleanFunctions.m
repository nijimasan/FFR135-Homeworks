% Maximilian Salén 970105-1576
clear all;close all;clc


% Initialization
n = 2;
nTrials = 1e4;
nEpochs = 20;
eta = 0.05;
counter = 0;

booleanInputs = dec2bin(0:2^n-1)' - '0';
booleanInputs(booleanInputs==0) = -1;
usedBool = [];
index = 1;

%for n = 1:length(dimension)
    for trial = 1:nTrials
        booleanOutputs = randi([0, 1], 2^n, 1);
        booleanOutputs(booleanOutputs==0) = -1;
        o = 0;
        
        for b = 1:size(usedBool,2)
           if isequal(usedBool(:,b),booleanOutputs)
               o = 1;
           end
        end

        if o == 0
               w = randn(1,n) * 1/sqrt(n);
               theta = 0;
    

                for epoch = 1:nEpochs
                    totalError = 0;
                    for mu = 1:2^n
                        b = 0;
                        for i = 1:length(w)
                            b = b + (w(i)*booleanInputs(i,mu)-theta);
                        end
                        y = sign(b);
                        error = booleanOutputs(mu)-y;
                       
                        % update w and theta
                        w = w + eta*(booleanOutputs(mu)-y).*booleanInputs(:,mu);
                        theta = theta + (-eta)*(booleanOutputs(mu)-y);
                        totalError = totalError + abs(error);
            
                    end
                    if totalError == 0
                        counter = counter + 1;
                        break
                    end
                end
              %add booleanOutputs to usedBool
              usedBool(:,index) = booleanOutputs;
              index = index + 1;
        end
    end
%end