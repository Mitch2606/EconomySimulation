numTimeSteps = 5;




%StoreChooserObs
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

StoreChooser = rlPPOAgent(discActor, critic);

%Item Chooser and Buyer
numObsStoreChooser = 10;
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

ItemChooser = rlPPOAgent(discActor, critic);

numActStoreChooser = 2;
ActionInfo = rlFiniteSetSpec([1 2]);
ActionInfo.Name = 'Direction';

actorNet = makeActorNet([ObservationInfo.Dimension, 1], numActStoreChooser, ObservationInfo.Name);
criticNet = makeCriticNet([ObservationInfo.Dimension, 1], ObservationInfo.Name);

repOpts = rlRepresentationOptions('LearnRate',5e-2,'GradientThreshold',1);

discActor = rlStochasticActorRepresentation(actorNet,ObservationInfo, ActionInfo,'Observation',ObservationInfo.Name);
critic = rlValueRepresentation(criticNet,ObservationInfo,'Observation',ObservationInfo.Name,repOpts);

Buyer = rlPPOAgent(discActor, critic);

%Business Nets
numObsStoreChooser = 5;
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