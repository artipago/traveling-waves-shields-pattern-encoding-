function [newActivity] = updatingActivity(activity,weights,travelingFlag)

    activationThreshold = .75;
    
    %maintaing activity
    if travelingFlag==1
        maintainActivity = movingPatternOneStep(activity);
    elseif travelingFlag==0
        maintainActivity = activity;
    end
    
    %weights activity
    weightActivity(:,1) = activity(:,end)'*weights(:,:,end);
    for xx=2:size(activity,2)
        weightActivity(:,xx) = activity(:,xx-1)'*weights(:,:,xx-1);
    end

    weightActivity(weightActivity>activationThreshold)=1;
    weightActivity(weightActivity<=activationThreshold)=0;

    
    %normalizing not to make it explode
    newActivity = maintainActivity + weightActivity;
    newActivity(newActivity>1)=1;

end