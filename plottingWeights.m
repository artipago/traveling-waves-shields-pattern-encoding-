function plottingWeights(weightTravelingFinal,weightStaticFinal)

xx = linspace(0,1.1,50);
timeSteps=1:size(weightTravelingFinal,2);
for kk=1:size(weightTravelingFinal,3)
    for tt=1:size(weightTravelingFinal,2)
        yyTraveling(:,tt,kk)=hist(weightTravelingFinal(:,tt,kk),xx);
        yyStatic(:,tt,kk)=hist(weightStaticFinal(:,tt,kk),xx);
    end
end

figure
subplot(1,2,1)
surf(timeSteps,xx,median(yyTraveling,3))
shading interp; view(0,90); axis tight; colorbar; caxis([0 500])
title('traveling weights histogram')
ylabel('weight value')
xlabel('timestep')

subplot(1,2,2)
surf(timeSteps,xx,median(yyStatic,3))
shading interp; view(0,90); axis tight; colorbar; caxis([0 500])
title('static weights histogram')
ylabel('weight value')
xlabel('timestep')

de=1;




end