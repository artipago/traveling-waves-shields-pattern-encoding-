function startingFunction()
    rng(110)
    %% defining parameters
    nNodesX = 15;
    nNodesY = 10;
    nTimeSteps = 200;
    
    epsilon = 0.1;
    sparsityThreshold = 0.25; %determines the number of 1 in the activity grid. The more the 1, the more the synaptic connections get strengthen
    
    numberOfNewItem = 8;
    
    %% modeling
    for kk=1:30 % several iterations
        kk
        %% initializing
        activityGridTraveling = zeros(nNodesY,nNodesX,nTimeSteps); % space x space x time
        activityGridTraveling(:,:,1) = round(rand(nNodesY,nNodesX)-sparsityThreshold); %initializing the first time step of the activityGridTravelling
        activityGridTraveling(activityGridTraveling<0)=0;
        cleanTraveling=activityGridTraveling;
        weightVectorTraveling = zeros(size(activityGridTraveling,1),size(activityGridTraveling,1)); %neuron x neuron x space(column) x time
        weightVectorTraveling = repmat(weightVectorTraveling,[1 1 nNodesX nTimeSteps]); %neuron x neuron x space(column) x time
        weightVectorTraveling = weightVectorTraveling + epsilon*rand(size(weightVectorTraveling));
    
    
        activityGridStatic = zeros(nNodesY,nNodesX,nTimeSteps); % space x space x time
        activityGridStatic(:,:,1) = round(rand(nNodesY,nNodesX)-sparsityThreshold); %initializing the first time step of the activityGridTravelling
        activityGridStatic(activityGridStatic<0)=0;
        cleanStatic=activityGridStatic;
        weightVectorStatic = zeros(size(activityGridStatic,1),size(activityGridStatic,1)); %neuron x neuron x space(column) x time
        weightVectorStatic = repmat(weightVectorStatic,[1 1 nNodesX nTimeSteps]); %neuron x neuron x space(column) x time
        weightVectorStatic = weightVectorStatic + epsilon*rand(size(weightVectorStatic));
    
    
        %% running through time steps
        for tt=1:nTimeSteps-1
    
            if tt==100 %changing the memory item
                
                newRandomItems = round(rand(nNodesY,numberOfNewItem)-sparsityThreshold); %initializing the first time step of the activityGridTravelling
                newRandomItems(newRandomItems<0)=0;
    
                positionRandomItems = randi(nNodesX,[1 numberOfNewItem]);
    
                activityGridTraveling(:,positionRandomItems,tt)=newRandomItems;
                activityGridStatic(:,positionRandomItems,tt)=newRandomItems;
                cleanTraveling(:,positionRandomItems,tt)=newRandomItems;
                cleanStatic(:,positionRandomItems,tt)=newRandomItems;
            end
    
            %computing the next activity : it's a combination of moving (or not)
            %the pattern + the activity due to the weights
            [activityGridTraveling(:,:,tt+1)] = updatingActivity(activityGridTraveling(:,:,tt),weightVectorTraveling(:,:,:,tt),1);
            [activityGridStatic(:,:,tt+1)] = updatingActivity(activityGridStatic(:,:,tt),weightVectorStatic(:,:,:,tt),0);
    
            %these are the ones without the influence of the weights - used for the
            %correlation at the end.
            [cleanTraveling(:,:,tt+1)] = updatingWeightLessActivity(cleanTraveling(:,:,tt),1);
            [cleanStatic(:,:,tt+1)] = updatingWeightLessActivity(cleanStatic(:,:,tt),0);
    
            %updating the weights
            for xx = 1:size(activityGridTraveling,2)-1
                weightVectorTraveling(:,:,xx,tt+1) = updatingTheWeights(weightVectorTraveling(:,:,xx,tt),activityGridTraveling(:,xx,tt),activityGridTraveling(:,xx+1,tt));
                weightVectorStatic(:,:,xx,tt+1) = updatingTheWeights(weightVectorStatic(:,:,xx,tt),activityGridStatic(:,xx,tt),activityGridStatic(:,xx+1,tt));
            end
            weightVectorTraveling(:,:,end,tt+1) = updatingTheWeights(weightVectorTraveling(:,:,end,tt),activityGridTraveling(:,end,tt),activityGridTraveling(:,1,tt));
            weightVectorStatic(:,:,end,tt+1) = updatingTheWeights(weightVectorStatic(:,:,end,tt),activityGridStatic(:,end,tt),activityGridStatic(:,1,tt));
    
        end
    
        [d_H_norm(:,:,kk),d_cosine(:,:,kk)]=checkingCorrelations(activityGridStatic,activityGridTraveling,cleanStatic,cleanTraveling);
        
        weightTravelingFinal(:,:,kk)=reshape(weightVectorTraveling,[size(weightVectorTraveling,1)*size(weightVectorTraveling,2)*size(weightVectorTraveling,3) size(weightVectorTraveling,4)]);
        weightStaticFinal(:,:,kk)=reshape(weightVectorStatic,[size(weightVectorStatic,1)*size(weightVectorStatic,2)*size(weightVectorStatic,3) size(weightVectorStatic,4)]);
    end
    
    %% plotting 
    plottingCorrelations(d_H_norm,d_cosine)
    plottingWeights(weightTravelingFinal,weightStaticFinal)
    
    plottingActivityOverTime(activityGridStatic,activityGridTraveling)
    plottingExamplesActivity(activityGridStatic,activityGridTraveling,cleanStatic,cleanTraveling)

end










