function plotter(txtnames,scenarionames,Title)

    w = 1.5;
    
    colors = [[1 0 0];[0 1 0];[0 0 1];[0 0 0];[1 0 1];[0 1 1];[0 0.4470 0.7410];[0.9290 0.6940 0.1250]];
    
    [mean,standev] = organize(txtnames);

    data_av = mean;

    figure('Name','Plots1','NumberTitle','off')

    subplot(3,3,1)
    
    hold on
    for i = 1 : length(data_av)
        funplot(mean(i).s,standev(i).s,colors(i,:),w,scenarionames(i,:))
    end
    hold off
    xlim([0 length(data_av(1).s)-1])
    ylim([0 inf])
    xlabel('Time [Days]')
    ylabel('No. of agents')
    title('Susceptible')
    legend('Location','best')
    
    subplot(3,3,2)
    
    hold on
    for i = 1 : length(data_av)
        funplot(mean(i).e,standev(i).e,colors(i,:),w,scenarionames(i,:))
    end
    hold off
    xlim([0 length(data_av(1).s)-1])
    ylim([0 inf])
    xlabel('Time [Days]')
    ylabel('No. of agents')
    title('Exposed')
    legend('Location','best')
    
    subplot(3,3,3)
    
    hold on
    for i = 1 : length(data_av)
        funplot(mean(i).i,standev(i).i,colors(i,:),w,scenarionames(i,:))
    end
    %data = readmatrix('data_long.txt');
    %plot(data,'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5,'DisplayName','Data')
    hold off
    xlim([0 length(data_av(1).s)-1])
    ylim([0 inf])
    xlabel('Time [Days]')
    ylabel('No. of agents')
    title('Infectious')
    legend('Location','best')
    
    subplot(3,3,4)
    
    hold on
    for i = 1 : length(data_av)
        funplot(mean(i).r,standev(i).r,colors(i,:),w,scenarionames(i,:))
    end
    hold off
    xlim([0 length(data_av(1).s)-1])
    ylim([0 inf])
    xlabel('Time [Days]')
    ylabel('No. of agents')
    title('Recovered')
    legend('Location','best')
    
    subplot(3,3,5)
        
    hold on
    for i = 1 : length(data_av)
        funplot(mean(i).d,standev(i).d,colors(i,:),w,scenarionames(i,:))
    end
    hold off
    xlim([0 length(data_av(1).s)-1])
    ylim([0 inf])
    xlabel('Time [Days]')
    ylabel('No. of agents')
    title('Deaths (cumulative)')
    legend('Location','best')
    
    subplot(3,3,6)
    
    hold on
    for i = 1 : length(data_av)
        var_av = mean(i).d;
        var_sd = standev(i).d;
    
        for j = 2 : length(var_av)
            var_av(j) = var_av(j) - mean(i).d(j-1);
            var_sd(j) = var_sd(j) - standev(i).d(j-1);
        end

        funplot(var_av,var_sd,colors(i,:),w,scenarionames(i,:))
    end
    hold off
    xlim([0 length(data_av(1).s)-1])
    ylim([0 inf])
    xlabel('Time [Days]')
    ylabel('No. of agents')
    title('Deaths (new cases)')
    legend('Location','best')
    
    subplot(3,3,7)
        
    hold on
    for i = 1 : length(data_av)
        seg1 = (-1*diff(mean(i).s))-diff(mean(i).do);
        seg2 = (-1*diff(standev(i).s))-diff(standev(i).do);
        funplot(seg1,seg2,colors(i,:),w,scenarionames(i,:))
    end
    hold off
    xlim([0 length(data_av(1).s)-1])
    ylim([0 inf])
    xlabel('Time [Days]')
    ylabel('No. of agents')
    title('New exposed')
    legend('Location','best')
    
    subplot(3,3,8)
        
    hold on
    for i = 1 : length(data_av)
        funplot(mean(i).kt,standev(i).kt,colors(i,:),w,scenarionames(i,:))
    end
    hold off
    xlim([0 length(data_av(1).s)-1])
    ylim([0 inf])
    xlabel('Time [Days]')
    ylabel('No. of agents')
    title('Hospital total')
    legend('Location','best')
    
    subplot(3,3,9)
    
    hold on
    for i = 1 : length(data_av)
        funplot(mean(i).ei,standev(i).ei,colors(i,:),w,scenarionames(i,:))
    end
    %data = readmatrix('data_long.txt');
    %plot(data,'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5,'DisplayName','Data')
    hold off
    xlim([0 length(data_av(1).s)-1])
    ylim([0 inf])
    xlabel('Time [Days]')
    ylabel('No. of agents')
    title('Exposed AND Infected')
    legend('Location','best')
    
    sgtitle(Title)
    
    figure('Name','Plots2','NumberTitle','off')
    
    subplot(3,3,5)
    
    hold on
    for i = 1 : length(data_av)
        funplot(mean(i).k,standev(i).k,colors(i,:),w,scenarionames(i,:))
    end
    hold off
    xlim([0 length(data_av(1).s)-1])
    ylim([0 inf])
    xlabel('Time [Days]')
    ylabel('No. of agents')
    title('Infectious in hospital')
    legend('Location','best')
    
    subplot(3,3,6)
    
    hold on
    for i = 1 : length(data_av)
        funplot(mean(i).i6,standev(i).i6,colors(i,:),w,scenarionames(i,:))
    end
    hold off
    xlim([0 length(data_av(1).s)-1])
    ylim([0 inf])
    xlabel('Time [Days]')
    ylabel('No. of agents')
    title('Intensive care')
    legend('Location','best')
    
    subplot(3,3,1)
    
    hold on
    for i = 1 : length(data_av)
        funplot(mean(i).t,standev(i).t,colors(i,:),w,scenarionames(i,:))
    end
    hold off
    xlim([0 length(data_av(1).s)-1])
    ylim([0 inf])
    xlabel('Time [Days]')
    ylabel('No. of agents')
    title('Testings')
    legend('Location','best')
    
    subplot(3,3,2)
    
    hold on
    for i = 1 : length(data_av)
        funplot(mean(i).p1,standev(i).p1,colors(i,:),w,scenarionames(i,:))
    end
    hold off
    xlim([0 length(data_av(1).s)-1])
    ylim([0 inf])
    xlabel('Time [Days]')
    ylabel('No. of agents')
    title('Positive tests')
    legend('Location','best')
    
    subplot(3,3,3)
    
    hold on
    for i = 1 : length(data_av)
        funplot(mean(i).p2,standev(i).p2,colors(i,:),w,scenarionames(i,:))
    end
    hold off
    xlim([0 length(data_av(1).s)-1])
    ylim([0 inf])
    xlabel('Time [Days]')
    ylabel('No. of agents')
    title('Positive test AND doctor visited')
    legend('Location','best')
    
    subplot(3,3,4)
    
    hold on
    for i = 1 : length(data_av)
        funplot((mean(i).p1)./mean(i).t,(standev(i).p1)./standev(i).t,colors(i,:),w,scenarionames(i,:))
    end
    hold off
    xlim([0 length(data_av(1).s)-1])
    ylim([0 inf])
    xlabel('Time [Days]')
    ylabel('No. of agents')
    title('Ratio of positive tests')
    legend('Location','best')
    
    subplot(3,3,7)
    
    hold on
    for i = 1 : length(data_av)
        funplot(mean(i).q,standev(i).q,colors(i,:),w,scenarionames(i,:))
    end
    hold off
    xlim([0 length(data_av(1).s)-1])
    ylim([0 inf])
    xlabel('Time [Days]')
    ylabel('No. of agents')
    title('Quarantined')
    legend('Location','best')
    
    subplot(3,3,8)
    
    hold on
    for i = 1 : length(data_av)
        funplot(mean(i).qt,standev(i).qt,colors(i,:),w,scenarionames(i,:))
    end
    hold off
    xlim([0 length(data_av(1).s)-1])
    ylim([0 inf])
    xlabel('Time [Days]')
    ylabel('No. of agents')
    title('Quarantined AND infected')
    legend('Location','best')
    
    subplot(3,3,9)
    
    hold on
    for i = 1 : length(data_av)
        funplot(mean(i).nq,standev(i).nq,colors(i,:),w,scenarionames(i,:))
    end
    hold off
    xlim([0 length(data_av(1).s)-1])
    ylim([0 inf])
    xlabel('Time [Days]')
    ylabel('No. of agents')
    title('NOT Quarantined AND infected')
    legend('Location','best')
    
    sgtitle(Title)

end