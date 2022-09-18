% Maximilian Salén 970105-1576
clear all;close all; clc;

% Initialize
p = [12 24 48 70 100 120];
N = 120;
nTrials = 1e5;
errorProbabilities = zeros(1,length(p));

for nPattern = 1:length(p)
    errorCounter = 0;

    for trial = 1:nTrials
        randomPatterns = randi([0, 1], N, p(nPattern));
        randomPatterns(randomPatterns==0) = -1;
        
        % Create weight matrix with Hebb's rule
        w = (1/N) * (randomPatterns * randomPatterns');

        % Uncomment to set diagonal elements to 0
%         for j = 1:N
%             w(j,j) = 0;
%         end

        % Select pattern to input an neuron to update
        randP = randi(p(nPattern));
        randBit = randi(N);

        % Update neuron
        s0 = sign(randomPatterns(randBit,randP));
        wi = w(randBit,:);
        sUpdated = sign(wi*randomPatterns(:,randP));
        
        if s0 == 0
            sUpdated = 1;
        end
        
        if sUpdated ~= s0
            errorCounter = errorCounter + 1;
        end
               
        
    end
    
    errorProbabilities(nPattern) = errorCounter/nTrials;
end