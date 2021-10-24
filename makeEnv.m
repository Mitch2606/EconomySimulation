numTimeSteps = 10;

%StoreChooserObs
numObsStoreChooser = 7;
ObservationInfo = rlNumericSpec([numObsStoreChooser numTimeSteps 1]);
ObservationInfo.Name = 'Agent Actions';

numActStoreChooser = 2;
ActionInfo = rlFiniteSetSpec([1 2]);
ActionInfo.Name = 'Direction';

actorNet = makeActorNet([ObservationInfo.Dimension, 1], numActStoreChooser, ObservationInfo.Name);
criticNet = makeCriticNet([ObservationInfo.Dimension, 1], ObservationInfo.Name);

repOpts = rlRepresentationOptions('LearnRate',5e-2,'GradientThreshold',1);

discActor = rlStochasticActorRepresentation(actorNet,ObservationInfo, ActionInfo,'Observation',ObservationInfo.Name);
critic = rlValueRepresentation(criticNet,ObservationInfo,'Observation',ObservationInfo.Name,repOpts);

%StoreChooser
StoreChooser = rlPPOAgent(discActor, critic);

% StoreChooser.AgentOptions.MiniBatchSize = 5;
% StoreChooser.AgentOptions.ExperienceHorizon = 10;
% StoreChooser.AgentOptions.NumEpoch = 5;

%Item Chooser and Buyer
numObsStoreChooser = 11;
ObservationInfo = rlNumericSpec([numObsStoreChooser numTimeSteps 1]);
ObservationInfo.Name = 'Agent Actions';

numActStoreChooser = 3;
ActionInfo = rlFiniteSetSpec([1 2 3]);
ActionInfo.Name = 'Direction';

actorNet = makeActorNet([ObservationInfo.Dimension, 1], numActStoreChooser, ObservationInfo.Name);
criticNet = makeCriticNet([ObservationInfo.Dimension, 1], ObservationInfo.Name);

repOpts = rlRepresentationOptions('LearnRate',5e-2,'GradientThreshold',1);

discActor = rlStochasticActorRepresentation(actorNet,ObservationInfo, ActionInfo,'Observation',ObservationInfo.Name);
critic = rlValueRepresentation(criticNet,ObservationInfo,'Observation',ObservationInfo.Name,repOpts);

%Choooser
ItemChooser = rlPPOAgent(discActor, critic);

% ItemChooser.AgentOptions.MiniBatchSize = 5;
% ItemChooser.AgentOptions.ExperienceHorizon = 10;
% ItemChooser.AgentOptions.NumEpoch = 5;

numActStoreChooser = 2;
ActionInfo = rlFiniteSetSpec([1 2]);
ActionInfo.Name = 'Direction';

actorNet = makeActorNet([ObservationInfo.Dimension, 1], numActStoreChooser, ObservationInfo.Name);
criticNet = makeCriticNet([ObservationInfo.Dimension, 1], ObservationInfo.Name);

repOpts = rlRepresentationOptions('LearnRate',5e-2,'GradientThreshold',1);

discActor = rlStochasticActorRepresentation(actorNet,ObservationInfo, ActionInfo,'Observation',ObservationInfo.Name);
critic = rlValueRepresentation(criticNet,ObservationInfo,'Observation',ObservationInfo.Name,repOpts);

%Buyer
Buyer = rlPPOAgent(discActor, critic);

% Buyer.AgentOptions.MiniBatchSize = 5;
% Buyer.AgentOptions.ExperienceHorizon = 10;
% Buyer.AgentOptions.NumEpoch = 5;

%Business Nets
numObsStoreChooser = 6;
ObservationInfo = rlNumericSpec([numObsStoreChooser numTimeSteps 1]);
ObservationInfo.Name = 'Agent Actions';

numActStoreChooser = 2;
ActionInfo = rlFiniteSetSpec([1 2]);
ActionInfo.Name = 'Direction';

actorNet = makeActorNet([ObservationInfo.Dimension, 1], numActStoreChooser, ObservationInfo.Name);
criticNet = makeCriticNet([ObservationInfo.Dimension, 1], ObservationInfo.Name);

repOpts = rlRepresentationOptions('LearnRate',5e-2,'GradientThreshold',1);

discActor = rlStochasticActorRepresentation(actorNet,ObservationInfo, ActionInfo,'Observation',ObservationInfo.Name);
critic = rlValueRepresentation(criticNet,ObservationInfo,'Observation',ObservationInfo.Name,repOpts);

FoodAgent = rlPPOAgent(discActor, critic);
WeedAgent = rlPPOAgent(discActor, critic);
EnergyAgent = rlPPOAgent(discActor, critic);

% FoodAgent.AgentOptions.MiniBatchSize = 5;
% FoodAgent.AgentOptions.ExperienceHorizon = 10;
% FoodAgent.AgentOptions.NumEpoch = 5;
% 
% WeedAgent.AgentOptions.MiniBatchSize = 5;
% WeedAgent.AgentOptions.ExperienceHorizon = 10;
% WeedAgent.AgentOptions.NumEpoch = 5;
% 
% EnergyAgent.AgentOptions.MiniBatchSize = 5;
% EnergyAgent.AgentOptions.ExperienceHorizon = 10;
% EnergyAgent.AgentOptions.NumEpoch = 5;


save("Agents.mat", 'ItemChooser', 'StoreChooser', 'Buyer', "FoodAgent", "WeedAgent", "EnergyAgent")

%Initialize Environment
envName = "rlModel";
customerSide = "/CustomerLogic";
businessSide = "/BusinessLogic";

env = rlSimulinkEnv(envName, [envName + customerSide + "/ItemChooser",...
    envName + customerSide + "/Buyer", envName + customerSide + "/StoreChooser",...
    envName + businessSide + "/FoodAgent", envName + businessSide + "/WeedAgent",...
    envName + businessSide + "/EnergyAgent"]);

save("environment.mat", 'env')