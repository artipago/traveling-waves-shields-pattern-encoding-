function newGrid = movingPatternOneStep(activityGrid)

    newGrid = zeros(size(activityGrid));
    newGrid(:,2:end)=activityGrid(:,1:end-1);
    newGrid(:,1)=activityGrid(:,end);

end