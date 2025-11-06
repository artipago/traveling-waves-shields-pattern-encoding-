function [maintainActivity] = updatingWeightLessActivity(activity,travelingFlag)
    %maintaing activity
    if travelingFlag==1
        maintainActivity = movingPatternOneStep(activity);
    elseif travelingFlag==0
        maintainActivity = activity;
    end
end


