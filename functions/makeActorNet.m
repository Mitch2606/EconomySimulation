function [net] = makeActorNet(numObs, numActions, Name)
%MAKENET Summary of this function goes here
%   Detailed explanation goes here

layers = [
    sequenceInputLayer(numObs,"Name",Name)
    flattenLayer
    lstmLayer(60,"Name","lstm_1")
    lstmLayer(60,"Name","lstm_2","OutputMode","sequence")
    fullyConnectedLayer(numActions,"Name","Action")];

net = layers;

end

