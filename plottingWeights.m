function plottingWeights(weightTravelingFinal,weightStaticFinal)

xx = linspace(0,1.1,50);
timeSteps=1:size(weightTravelingFinal,2);
for kk=1:size(weightTravelingFinal,3)
    for tt=1:size(weightTravelingFinal,2)
        for dd = 1:size(weightStaticFinal,4)
            yyTraveling(:,tt,kk,dd)=hist(weightTravelingFinal(:,tt,kk,dd),xx);
            yyStatic(:,tt,kk,dd)=hist(weightStaticFinal(:,tt,kk,dd),xx);
        end
    end
end

figure
subplot(2,2,3)
surf(timeSteps,xx,median(yyTraveling(:,:,:,1),3))
shading interp; view(0,90); axis tight; colorbar; caxis([0 500])
title('traveling weights histogram: low learning rate)')
ylabel('weight value')
xlabel('timestep')

subplot(2,2,1)
surf(timeSteps,xx,median(yyStatic(:,:,:,1),3))
shading interp; view(0,90); axis tight; colorbar; caxis([0 500])
title('static weights histogram: low learning rate')
ylabel('weight value')
xlabel('timestep')

subplot(2,2,4)
surf(timeSteps,xx,median(yyTraveling(:,:,:,2),3))
shading interp; view(0,90); axis tight; colorbar; caxis([0 500])
title('traveling weights histogram: high learning rate)')
ylabel('weight value')
xlabel('timestep')

subplot(2,2,2)
surf(timeSteps,xx,median(yyStatic(:,:,:,2),3))
shading interp; view(0,90); axis tight; colorbar; caxis([0 500])
title('static weights histogram: high learning rate')
ylabel('weight value')
xlabel('timestep')




end