function businessObs = makeBusinessObs(itemChoice, buyerChoice, currentPrices)

timeSteps = 5;

persistent oldbusinessObs

currentObs = [currentPrices, itemChoice, buyerChoice]';

if(isempty(oldbusinessObs))
    oldbusinessObs = zeros(5, timeSteps); 
end

if(size(currentObs, 2) > 1)
    businessObs = [oldbusinessObs(:, 2:end), currentObs'];
else
    businessObs = [oldbusinessObs(:, 2:end), currentObs];
end

oldbusinessObs = businessObs;