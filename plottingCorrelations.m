function plottingCorrelations(d_H_norm,d_cosine)

%plotting correlations
figure
subplot(1,2,1)
hold on
% plot(mean(d_H_norm(1,:,:),3),'r')
% plot(mean(d_H_norm(2,:,:),3),'b')

plot(mean(d_H_norm(1,:,:),3),'r','LineWidth',2)
plot(mean(d_H_norm(2,:,:),3),'b','LineWidth',2)
plot(mean(d_H_norm(1,:,:),3)+std(d_H_norm(1,:,:),0,3)/sqrt(size(d_H_norm,3)),'r')
plot(mean(d_H_norm(2,:,:),3)+std(d_H_norm(2,:,:),0,3)/sqrt(size(d_H_norm,3)),'b')
plot(mean(d_H_norm(1,:,:),3)-std(d_H_norm(1,:,:),0,3)/sqrt(size(d_H_norm,3)),'r')
plot(mean(d_H_norm(2,:,:),3)-std(d_H_norm(2,:,:),0,3)/sqrt(size(d_H_norm,3)),'b')
plot([100 100],[-0.2 1],'--k')
plot([0 200],[0 0],'k')
title('Hamming distance mean+/- std')
legend('static','traveling')
ylabel('distance from ground truth')
xlabel('timesteps')

% errorbar(mean(d_H_norm(1,:,:),3),std(d_H_norm(1,:,:),0,3),'r')
% errorbar(mean(d_H_norm(2,:,:),3),std(d_H_norm(2,:,:),0,3),'b')
subplot(1,2,2)
hold on
% plot(mean(d_cosine(1,:,:),3),'r')
% plot(mean(d_cosine(2,:,:),3),'b')

plot(mean(d_cosine(1,:,:),3),'r','LineWidth',2)
plot(mean(d_cosine(2,:,:),3),'b','LineWidth',2)
plot(mean(d_cosine(1,:,:),3)+std(d_cosine(1,:,:),0,3)/sqrt(size(d_H_norm,3)),'r')
plot(mean(d_cosine(2,:,:),3)+std(d_cosine(2,:,:),0,3)/sqrt(size(d_H_norm,3)),'b')
plot(mean(d_cosine(1,:,:),3)-std(d_cosine(1,:,:),0,3)/sqrt(size(d_H_norm,3)),'r')
plot(mean(d_cosine(2,:,:),3)-std(d_cosine(2,:,:),0,3)/sqrt(size(d_H_norm,3)),'b')
plot([100 100],[-0.2 1],'--k')
plot([0 200],[0 0],'k')
legend('static','traveling')
title('Cosine distance mean+/- std')
ylabel('distance from ground truth')
xlabel('timesteps')

% errorbar(mean(d_cosine(1,:,:),3),std(d_cosine(1,:,:),0,3),'r')
% errorbar(mean(d_cosine(2,:,:),3),std(d_cosine(2,:,:),0,3),'b')

figure
subplot(2,2,1)
hold on
plot(median(d_H_norm(1,:,:),3),'r','LineWidth',2)
plot(median(d_H_norm(2,:,:),3),'b','LineWidth',2)
plot(mean(d_H_norm(1,:,:),3),'--r','LineWidth',2)
plot(mean(d_H_norm(2,:,:),3),'--b','LineWidth',2)
plot([100 100],[-0.2 1],'--k')
plot([0 200],[0 0],'k')
title('Hamming distance mean+/- std')
legend('mean static','mean traveling','median static','median traveling')
ylabel('distance from ground truth')
xlabel('timesteps')
subplot(2,2,2)
hold on
plot(median(d_cosine(1,:,:),3),'r','LineWidth',2)
plot(median(d_cosine(2,:,:),3),'b','LineWidth',2)
plot(mean(d_cosine(1,:,:),3),'--r','LineWidth',2)
plot(mean(d_cosine(2,:,:),3),'--b','LineWidth',2)
plot([100 100],[-0.2 1],'--k')
plot([0 200],[0 0],'k')
legend('mean static','mean traveling','median static','median traveling')
title('Cosine distance mean+/- std')
ylabel('distance from ground truth')
xlabel('timesteps')

subplot(2,2,3)
imagesc(squeeze(d_H_norm(1,:,:)))
title('Hamming distance Static')
xlabel('iterations')
ylabel('timesteps')
colorbar
subplot(2,2,4)
imagesc(squeeze(d_H_norm(2,:,:)))
title('Hamming distance Traveling')
xlabel('iterations')
ylabel('timesteps')
colorbar

end