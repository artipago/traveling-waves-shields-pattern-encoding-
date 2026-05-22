function startingFunction()
    rng(100)
    %% defining parameters
    nNodesY = 15;
    nNodesX = 10;
    nTimeSteps = 200;
    
    epsilon = 0.1;

    deltaIncrease = [0.05 0.1]; % learning rate

    sparsityThreshold = 0.25; %determines the number of 1 in the activity grid. The more the 1, the more the synaptic connections get strengthen
    
    numberOfNewItem = 8;
    
    %% modeling
    for dd = 1:length(deltaIncrease)
        for kk=1:30 % several iterations
            %% initializing
            activityGridTraveling = zeros(nNodesX,nNodesY,nTimeSteps); % space x space x time
            activityGridTraveling(:,:,1) = round(rand(nNodesX,nNodesY)-sparsityThreshold); %initializing the first time step of the activityGridTravelling
            activityGridTraveling(activityGridTraveling<0)=0;
            cleanTraveling=activityGridTraveling;
            weightVectorTraveling = zeros(size(activityGridTraveling,1),size(activityGridTraveling,1)); %neuron x neuron x space(column) x time
            weightVectorTraveling = repmat(weightVectorTraveling,[1 1 nNodesY nTimeSteps]); %neuron x neuron x space(column) x time
            weightVectorTraveling = weightVectorTraveling + epsilon*rand(size(weightVectorTraveling));
        
        
            activityGridStatic = zeros(nNodesX,nNodesY,nTimeSteps); % space x space x time
            activityGridStatic(:,:,1) = round(rand(nNodesX,nNodesY)-sparsityThreshold); %initializing the first time step of the activityGridTravelling
            activityGridStatic(activityGridStatic<0)=0;
            cleanStatic=activityGridStatic;
            weightVectorStatic = zeros(size(activityGridStatic,1),size(activityGridStatic,1)); %neuron x neuron x space(column) x time
            weightVectorStatic = repmat(weightVectorStatic,[1 1 nNodesY nTimeSteps]); %neuron x neuron x space(column) x time
            weightVectorStatic = weightVectorStatic + epsilon*rand(size(weightVectorStatic));
        
        
            %% running through time steps
            for tt=1:nTimeSteps-1
        
                if tt==100 %changing the memory item
                    
                    newRandomItems = round(rand(nNodesX,numberOfNewItem)-sparsityThreshold); %initializing the first time step of the activityGridTravelling
                    newRandomItems(newRandomItems<0)=0;
        
                    positionRandomItems = randi(nNodesY,[1 numberOfNewItem]);
        
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
                    weightVectorTraveling(:,:,xx,tt+1) = updatingTheWeights(weightVectorTraveling(:,:,xx,tt),activityGridTraveling(:,xx,tt),activityGridTraveling(:,xx+1,tt),deltaIncrease(dd));
                    weightVectorStatic(:,:,xx,tt+1) = updatingTheWeights(weightVectorStatic(:,:,xx,tt),activityGridStatic(:,xx,tt),activityGridStatic(:,xx+1,tt),deltaIncrease(dd));
                end
                weightVectorTraveling(:,:,end,tt+1) = updatingTheWeights(weightVectorTraveling(:,:,end,tt),activityGridTraveling(:,end,tt),activityGridTraveling(:,1,tt),deltaIncrease(dd));
                weightVectorStatic(:,:,end,tt+1) = updatingTheWeights(weightVectorStatic(:,:,end,tt),activityGridStatic(:,end,tt),activityGridStatic(:,1,tt),deltaIncrease(dd));
        
            end
        
            [d_H_norm(:,:,kk,dd),~]=checkingCorrelations(activityGridStatic,activityGridTraveling,cleanStatic,cleanTraveling);
            
            weightTravelingFinal(:,:,kk,dd)=reshape(weightVectorTraveling,[size(weightVectorTraveling,1)*size(weightVectorTraveling,2)*size(weightVectorTraveling,3) size(weightVectorTraveling,4)]);
            weightStaticFinal(:,:,kk,dd)=reshape(weightVectorStatic,[size(weightVectorStatic,1)*size(weightVectorStatic,2)*size(weightVectorStatic,3) size(weightVectorStatic,4)]);
        end

        activityGridTravelingALL(:,:,:,dd) = activityGridTraveling;
        activityGridStaticALL(:,:,:,dd) = activityGridStatic;
        
        
    end
        %% plotting 
        plottingActivites(d_H_norm,activityGridStaticALL,activityGridTravelingALL)
        plottingWeights(weightTravelingFinal,weightStaticFinal)
end










