prices = [11, 15, 5];

overTime = [];
for i = 1: 100000

A = [round(rand(100,1), 0), round(rand(100,1), 0), round(rand(100,1), 0)];

for s = 1: size(prices, 2)

if(A(s) == 0)
   prices(s) = prices(s) + 0.1;
else
   prices(s) = prices(s) - 0.1;
end

end

overTime = [overTime; prices];

end

figure
hold on
plot(overTime(:,1))
plot(overTime(:,2))
plot(overTime(:,3))

legend(["Food" "Weed" "Energy Drink"]);

numFeatures = 3;
numHiddenUnits = 20;
layers = [ ...
    sequenceInputLayer(numFeatures)
    lstmLayer(numHiddenUnits)
    lstmLayer(numHiddenUnits,'OutputMode','last')
    fullyConnectedLayer(1)
    regressionLayer];

options = trainingOptions('adam', ...
    'MaxEpochs',10, ... %From training it looks like this is good since loss gets close to zero after 2 or 3 epochs
    'InitialLearnRate',0.1, ... %This is arbitrary
    'LearnRateSchedule','piecewise', ...
    'LearnRateDropPeriod',2, ... %I like to explore the field for a bit, then find the local minimum, this value is usually around the first few epochs
    'LearnRateDropFactor',0.1, ... %Also arbitrary
    'ExecutionEnvironment', 'gpu', ...
    'Verbose', 1);

SequenceLength = 10;
figure
subplot(3,1,1)
hold on
Feature = 1;
[xTrain, yTrain] = transformForRNN(overTime, SequenceLength, Feature);
% foodNet = trainNetwork(xTrain, yTrain, layers, options);
save("foodNet.mat", 'foodNet')
predictions = predict(foodNet, xTrain);
plot(yTrain)
plot(predictions)
legend(["Original" "yPred"])

layers = [ ...
    sequenceInputLayer(numFeatures)
    lstmLayer(numHiddenUnits)
    lstmLayer(numHiddenUnits,'OutputMode','last')
    fullyConnectedLayer(1)
    regressionLayer];

subplot(3,1,2)
hold on
Feature = 2;
[xTrain, yTrain] = transformForRNN(overTime, SequenceLength, Feature);
% drugsNet = trainNetwork(xTrain, yTrain, layers, options);
predictions = predict(drugsNet, xTrain);
plot(yTrain)
plot(predictions)
legend(["Original" "yPred"])% 
save("drugsNet.mat", 'drugsNet')

layers = [ ...
    sequenceInputLayer(numFeatures)
    lstmLayer(numHiddenUnits)
    lstmLayer(numHiddenUnits,'OutputMode','last')
    fullyConnectedLayer(1)
    regressionLayer];

subplot(3,1,3)
hold on
Feature = 3;
[xTrain, yTrain] = transformForRNN(overTime, SequenceLength, Feature);
% energyDrinkNet = trainNetwork(xTrain, yTrain, layers, options);
predictions = predict(energyDrinkNet, xTrain);
save("energyDrinkNet.mat", 'energyDrinkNet')
plot(yTrain)
plot(predictions)
legend(["Original" "yPred"])% 
% save("drugsNet.mat", 'drugsNet')







