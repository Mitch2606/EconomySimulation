% function score = showhowWeightseffectReward(bodyStatus)

bodyStatus = [[1:50]; [50:-1:1]; [1:50]];
weights = [rand(10,1), rand(10,1), rand(10,1)]

score = weights * bodyStatus;



plot(score(1,:))


