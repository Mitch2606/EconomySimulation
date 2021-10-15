function formattedTimeSeries  = splitter(currentPrices, reset)
%Variables useful for observation stuff
timeSteps = 10;
numFeatures = length(currentPrices);

%Setup Persistent Variables
persistent oldPrices; 

if(isempty(oldPrices) || (reset == 1))
     oldPrices = zeros(numFeatures, timeSteps);
end

%MakeSure the array is pointed the right way
currentPrices = fixDirection(currentPrices, 1); %Important that the new ones are a column vector

%Concatinate all but one of the old prices
formattedTimeSeries = [oldPrices(:, 2:end), currentPrices];

oldPrices = formattedTimeSeries;



