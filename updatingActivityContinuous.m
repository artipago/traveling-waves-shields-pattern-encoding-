function newActivity = updatingActivityContinuous(activity,weights,travelingFlag)

    %previous one
    if travelingFlag==1
        maintainActivity = movingPatternOneStep(activity);
    elseif travelingFlag==0
        maintainActivity = activity;
    end
    tauDecay = 0.9;
%     tauDecay = 1;
    maintainActivity = maintainActivity*tauDecay;

    %activity due to the weights
    for xx=1:size(activity,2)
        weightActivity(:,xx) = activity(:,xx)'*weights(:,:,xx);
    end

    % weightActivity = 0;
    newActivity = maintainActivity + weightActivity;
    % newActivity = sigmoidFunction(maintainActivity + weightActivity);
    
    %normalizing not to make it explode
%     newActivity = newActivity-mean(mean(newActivity))+mean(mean(activity));
    newActivity(newActivity>=.5)=1;
    newActivity(newActivity<.5)=0;
%     newActivity(newActivity>1)=1;
%     newActivity(newActivity<0)=0;

end