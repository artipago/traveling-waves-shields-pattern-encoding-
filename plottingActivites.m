function plottingActivites(d_H_norm,activityGridStatic,activityGridTraveling)

figure
colors = [240,128,128;
         178,34,34;
         173,216,230;
         65,105,225]/255;
subplot(4,2,[1 3])
colororder([178,34,34;65,105,225]/255)
yyaxis left
hold on
meanStatic = squeeze(mean(d_H_norm(1,:,:,1),3));
meanTraveling = squeeze(mean(d_H_norm(2,:,:,1),3));
seStatic = squeeze(std(d_H_norm(1,:,:,1),0,3))/sqrt(size(d_H_norm,3));
seTraveling = squeeze(std(d_H_norm(2,:,:,1),0,3))/sqrt(size(d_H_norm,3));

xValues = 1:length(meanStatic);
patch([xValues fliplr(xValues)], ...
      [(meanStatic + seStatic) fliplr((meanStatic - seStatic))], ...
      colors(1,:), ...
      'FaceAlpha',0.6, ...
      'EdgeColor','none')
patch([xValues fliplr(xValues)], ...
      [(meanTraveling + seTraveling) fliplr((meanTraveling - seTraveling))], ...
      colors(2,:), ...
      'FaceAlpha',0.6, ...
      'EdgeColor','none')
plot(meanStatic,'Color',colors(1,:),'LineWidth',2,'LineStyle','-')
plot(meanTraveling,'Color',colors(2,:),'LineWidth',2,'LineStyle','-')
plot([100 100],[-0.2 1],'--k')
plot([0 200],[0 0],'--k')
title('Low Learning Rate')

ylabel('Hamming distance from ground truth')
xlabel('timesteps')

yyaxis right
hold on
plot(squeeze(sum(sum(activityGridStatic(:,:,:,1),1),2)),'Color',colors(3,:),'LineStyle','-','LineWidth',2)
plot(squeeze(sum(sum(activityGridTraveling(:,:,:,1),1),2)),'Color',colors(4,:),'LineStyle','-','LineWidth',2)
ylim([20,160])
xlabel('time steps')
ylabel('# spikes')
legend('','','Distance: static ','Distance: traveling','','', '#Spike: static', '#Spike: traveling')

subplot(4,2,[2 4])
colororder([178,34,34;65,105,225]/255)
yyaxis left
hold on
meanStatic = squeeze(mean(d_H_norm(1,:,:,2),3));
meanTraveling = squeeze(mean(d_H_norm(2,:,:,2),3));
seStatic = squeeze(std(d_H_norm(1,:,:,2),0,3))/sqrt(size(d_H_norm,3));
seTraveling = squeeze(std(d_H_norm(2,:,:,2),0,3))/sqrt(size(d_H_norm,3));

xValues = 1:length(meanStatic);
patch([xValues fliplr(xValues)], ...
      [(meanStatic + seStatic) fliplr((meanStatic - seStatic))], ...
      colors(1,:), ...
      'FaceAlpha',0.6, ...
      'EdgeColor','none')
patch([xValues fliplr(xValues)], ...
      [(meanTraveling + seTraveling) fliplr((meanTraveling - seTraveling))], ...
      colors(2,:), ...
      'FaceAlpha',0.6, ...
      'EdgeColor','none')
plot(meanStatic,'Color',colors(1,:),'LineWidth',2,'LineStyle','-')
plot(meanTraveling,'Color',colors(2,:),'LineWidth',2,'LineStyle','-')
plot([100 100],[-0.2 1],'--k')
plot([0 200],[0 0],'--k')
title('High Learning Rate')

ylabel('Hamming distance from ground truth')
xlabel('timesteps')

yyaxis right
hold on
plot(squeeze(sum(sum(activityGridStatic(:,:,:,2),1),2)),'Color',colors(3,:),'LineStyle','-','LineWidth',2)
plot(squeeze(sum(sum(activityGridTraveling(:,:,:,2),1),2)),'Color',colors(4,:),'LineStyle','-','LineWidth',2)
ylim([20,160])
xlabel('time steps')
ylabel('# spikes')
legend('','','Distance: static ','Distance: traveling','','', '#Spike: static', '#Spike: traveling')
%%%

subplot(4,2,5)
imagesc(squeeze(d_H_norm(1,:,:,1))')
clim([0 max(d_H_norm(:,:,:,1),[],"all")])
ylabel('iterations')
xlabel('timesteps')
c=colorbar;
c.Label.String = 'Hamming distance Static';

subplot(4,2,7)
imagesc(squeeze(d_H_norm(2,:,:,1))')
clim([0 max(d_H_norm(:,:,:,1),[],"all")])
ylabel('iterations')
xlabel('timesteps')
c=colorbar;
c.Label.String = 'Hamming distance Traveling';

subplot(4,2,6)
imagesc(squeeze(d_H_norm(1,:,:,2))')
clim([0 max(d_H_norm(:,:,:,2),[],"all")])
ylabel('iterations')
xlabel('timesteps')
c=colorbar;
c.Label.String = 'Hamming distance Static';

subplot(4,2,8)
imagesc(squeeze(d_H_norm(2,:,:,2))')
clim([0 max(d_H_norm(:,:,:,2),[],"all")])
ylabel('iterations')
xlabel('timesteps')
c=colorbar;
c.Label.String = 'Hamming distance Traveling';

end
