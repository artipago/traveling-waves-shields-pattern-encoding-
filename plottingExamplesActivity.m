function plottingExamplesActivity(activityGridStatic,activityGridTraveling,cleanStatic,cleanTraveling)


timeSteps = [1 60 140];

figure
for ii=1:size(timeSteps,2)
    subplot(4,length(timeSteps),ii)
    imagesc(activityGridStatic(:,:,timeSteps(ii)))
    title('static real')
    
    subplot(4,length(timeSteps),ii+length(timeSteps))
    imagesc(cleanStatic(:,:,timeSteps(ii)))
    title('static clean')
    
    
    subplot(4,length(timeSteps),ii+length(timeSteps)*2)
    imagesc(activityGridTraveling(:,:,timeSteps(ii)))
    title('traveling real')
    
    subplot(4,length(timeSteps),ii+length(timeSteps)*3)
    imagesc(cleanTraveling(:,:,timeSteps(ii)))
    title('traveling clean')
    
end

figure
for ii=1:size(timeSteps,2)
    subplot(2,length(timeSteps),ii)
    imagesc(activityGridStatic(:,:,timeSteps(ii))-cleanStatic(:,:,timeSteps(ii)))
    title('static')
    
    subplot(2,length(timeSteps),ii+length(timeSteps))
    imagesc(activityGridTraveling(:,:,timeSteps(ii)) - cleanTraveling(:,:,timeSteps(ii)))
    title('traveling')
    
    
    
end







end











