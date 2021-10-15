a = 1;
count = 1;

Agents = [ItemChooser, Buyer, StoreChooser, FoodAgent, WeedAgent, EnergyAgent];

trainOpts = rlTrainingOptions;
trainOpts.MaxStepsPerEpisode = 100;
trainOpts.StopTrainingCriteria = "EpisodeCount";

while((a ~= 0))
    stats = train(Agents, env, trainOpts);
    
    a = input("Train again [1 Y, 0 N]: ");
    count = count + 1;
    
    
end

