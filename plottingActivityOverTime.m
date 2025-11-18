function plottingActivityOverTime(activityGridStatic,activityGridTraveling)

    figure
    hold on
    plot(squeeze(sum(sum(activityGridTraveling,1),2)),'r')
    plot(squeeze(sum(sum(activityGridStatic,1),2)),'b')
    ylim([0,160])
    xlabel('time steps')
    ylabel('# spikes')
    legend('traveling','static')
    de=1;

end