function fun_plotter_std(txtnames,scenarionames,Title,Measures,StartDate,flag,rdata_flag)

    if flag == 1
        
        if rdata_flag
            fprintf('Getting Hungarian data (korona_hun)...')
            hundata = GetGoogleSpreadsheet('1e4VEZL1xvsALoOIq9V2SQuICeQrT5MtWfBm32ad7i8Q');
            %col 20: number of ppl in hospital
            %col 21: number of ppl on ventilators
            numAgents = 179530;
            hunPopulation = 9770000;
            dates = datetime(hundata(2:end,1),'InputFormat','yyyy-MM-dd');
            startdate = find(dates==datestr('2020-09-23'))+1;
            fprintf('Done.\n')
        end
        
        fprintf('Standard input data processing started!\n');
        
        measdim = size(Measures);
        measdim = measdim(1);
        
        w = 1.5;

        colors = [[1 0 0];[0 1 0];[0 0 1];[0 0 0];[1 0 1];[0 1 1];[0 0.4470 0.7410];[0.9290 0.6940 0.1250]];

        [mean,standev] = fun_std_organize(txtnames);

        data_av = mean;
        
        fprintf('Standard input data processed!\n');

        figure('Name','Plots1_std','NumberTitle','off')

        subplot(3,3,1)
        hold on
        minvar = min(mean(1).s-standev(1).s);
        for i = 1 : length(data_av)
            funplot(mean(i).s,standev(i).s,colors(i,:),w,scenarionames{i})

            if minvar > min(mean(i).s)
                minvar = min(mean(i).s-standev(i).s);
            end
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        ylim([minvar-1000 inf])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('No. of agents')
        title('Susceptible')
        legend('Location','best')

        subplot(3,3,2)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).e,standev(i).e,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('No. of agents')
        title('Exposed')
        legend('Location','best')

        subplot(3,3,3)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).i,standev(i).i,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        %data = readmatrix('data_long.txt');
        %plot(data,'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5,'DisplayName','Data')
        hold off
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('No. of agents')
        title('Infectious')
        legend('Location','best')

        subplot(3,3,4)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).ei,standev(i).ei,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        %data = readmatrix('data_long.txt');
        %plot(data,'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5,'DisplayName','Data')
        hold off
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('No. of agents')
        title('Infected')
        legend('Location','best')

        subplot(3,3,5)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).r,standev(i).r,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('No. of agents')
        title('Recovered (cumulative)')
        legend('Location','best')

        subplot(3,3,6)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).d,standev(i).d,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if rdata_flag
            rdata = str2double(hundata(startdate:end,4))-str2double(hundata(startdate,4));
            funplot_realdata(rdata,numAgents,hunPopulation,w);
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('No. of agents')
        title('Deaths (cumulative)')
        legend('Location','best')

        subplot(3,3,7)
        hold on
        for i = 1 : length(data_av)
            seg1 = (-1*diff(mean(i).s))-diff(mean(i).do);
            seg2 = (-1*diff(standev(i).s))-diff(standev(i).do);
            funplot(seg1,seg2,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('No. of agents')
        title('New exposed')
        legend('Location','best')

        subplot(3,3,8)
        hold on
        for i = 1 : length(data_av)
            var_av = mean(i).d;
            var_sd = standev(i).d;

            for j = 2 : length(var_av)
                var_av(j) = var_av(j) - mean(i).d(j-1);
                var_sd(j) = var_sd(j) - standev(i).d(j-1);
            end

            funplot(var_av,var_sd,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('No. of agents')
        title('Deaths (new cases)')
        legend('Location','best')
        
        subplot(3,3,9)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).mu,standev(i).mu,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('Ratio (%)')
        title('Ratio of the mutant virus')
        legend('Location','best')

        sgtitle(append('SEIRD-related (',Title,')'))

        figure('Name','Plots2_std','NumberTitle','off')

        subplot(2,3,1)
        hold on
        for i = 1 : length(data_av)
            seg1 = mean(i).t+mean(i).p2;
            seg2 = standev(i).t+standev(i).p2;
            funplot(seg1,seg2,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if rdata_flag
            rdata = str2double(hundata(startdate:end,16));
            funplot_realdata(rdata,numAgents,hunPopulation,w);
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('No. of agents')
        title('Number of new tests')
        legend('Location','best')

        subplot(2,3,4)
        hold on
        for i = 1 : length(data_av)
            seg1 = mean(i).p1+mean(i).p2;
            seg2 = standev(i).p1+standev(i).p2;
            funplot(seg1,seg2,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if rdata_flag
            rdata = str2double(hundata(startdate:end,3));
            funplot_realdata(rdata,numAgents,hunPopulation,w);
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('No. of agents')
        title('Number of new, positive tests')
        legend('Location','best')

        subplot(2,3,[2 3])
        hold on    
        maxvar = max((mean(1).p1+mean(1).p2)./(mean(1).t+mean(1).p2));
        for i = 1 : length(data_av)
            seg1 = (mean(i).p1+mean(i).p2)./(mean(i).t+mean(i).p2);
            seg2 = (standev(i).p1+standev(i).p2)./(standev(i).t+standev(i).p2);
            funplot(seg1,seg2,colors(i,:),w,scenarionames{i})

            if maxvar < max((mean(i).p1+mean(i).p2)./(mean(i).t+mean(i).p2))
                maxvar = max((mean(i).p1+mean(i).p2)./(mean(i).t+mean(i).p2));
            end
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        ylim([0 maxvar+0.01])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('Ratio')
        title('Ratio of new, positive tests')
        legend('Location','best')
        
        subplot(2,3,5)
        hold on
        for i = 1 : length(data_av)
            funplot(cumsum(mean(i).t+mean(i).p2),cumsum(standev(i).t+standev(i).p2),colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('No. of agents')
        title('Number of tests (cumulative)')
        legend('Location','best')

        subplot(2,3,6)
        hold on
        for i = 1 : length(data_av)
            funplot(cumsum(mean(i).p1+mean(i).p2),cumsum(standev(i).p1+standev(i).p2),colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('No. of agents')
        title('Number of positive tests (cumulative)')
        legend('Location','best')

        sgtitle(append('Testing (',Title,')'))

        figure('Name','Plots3_std','NumberTitle','off')

        subplot(2,2,4)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).ktnc,standev(i).ktnc,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('No. of agents')
        title('Total number of people in hospital')
        legend('Location','best')

        subplot(2,2,3)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).kt,standev(i).kt,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if rdata_flag
            rdata = str2double(hundata(startdate:end,20));
            funplot_realdata(rdata,numAgents,hunPopulation,w);
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('No. of agents')
        title('Number of people in hospital due to COVID-19')
        legend('Location','best')

        subplot(2,2,2)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).k,standev(i).k,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('No. of agents')
        title('Number of infectious people in hospital due to COVID-19')
        legend('Location','best')

        subplot(2,2,1)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).i6,standev(i).i6,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('No. of agents')
        title('Number of people in intensive care due to COVID-19')
        legend('Location','best')

        sgtitle(append('Hospitalization (',Title,')'))

        figure('Name','Plots4_std','NumberTitle','off')

        subplot(2,2,1)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).q,standev(i).q,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('No. of agents')
        title('Quarantined')
        legend('Location','best')

        subplot(2,2,2)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).nq,standev(i).nq,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('No. of agents')
        title('NOT Quarantined AND infected')
        legend('Location','best')

        subplot(2,2,3)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).q-mean(i).qt,standev(i).q-standev(i).qt,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('No. of agents')
        title('Quarantined AND NOT infected')
        legend('Location','best')

        subplot(2,2,4)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).qt,standev(i).qt,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('No. of agents')
        title('Quarantined AND infected')
        legend('Location','best')

        sgtitle(append('Quarantine (',Title,')'))
        
        figure('Name','Plots5_std','NumberTitle','off')
        
        subplot(1,2,1)
        hold on
        for i = 1 : length(data_av)
            funplot(diff(mean(i).s),diff(standev(i).s),colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('No. of agents')
        title('Susceptible (derivative)')
        legend('Location','best')
        
        subplot(1,2,2)
        hold on
        for i = 1 : length(data_av)
            funplot(diff(mean(i).r),diff(standev(i).r),colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('No. of agents')
        title('Recovered (derivative)')
        legend('Location','best')
        
        sgtitle(append('Susceptible and recovered change rate (',Title,')'))
        
        figure('Name','Plots6_std','NumberTitle','off')
        
        subplot(2,2,1)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).do,standev(i).do,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('No. of agents')
        title('Deaths (cumulative)')
        legend('Location','best')
        
        subplot(2,2,2)
        hold on
        for i = 1 : length(data_av)
            funplot(diff(mean(i).do),diff(standev(i).do),colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('No. of agents')
        title('Deaths (new cases)')
        legend('Location','best')
        
        subplot(2,2,[3 4])
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).h,standev(i).h,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('No. of agents')
        title('Hospitalization')
        legend('Location','best')
        
        sgtitle(append('Not COVID-related results (',Title,')'))
        
        figure('Name','PlotsX_std','NumberTitle','off')
        hold on
        for i = 1 : length(data_av)
            epxosed1 = (-1*diff(mean(i).s))-diff(mean(i).do);
            epxosed2 = (-1*diff(standev(i).s))-diff(standev(i).do);
            ifnectious1 = mean(i).ei;
            ifnectious2 = standev(i).ei;
            ifnectious1(end) = [];
            ifnectious2(end) = [];
            funplot(epxosed1./ifnectious1,epxosed2./ifnectious2,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('No. of agents')
        title('New exposed and current infectious ratio')
        legend('Location','best')
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Publication figures below this line %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        figure('Name','Publication_figure_1','NumberTitle','off')
        
        subplot(2,2,1)
        hold on
        minvar = min(mean(1).s-standev(1).s);
        for i = 1 : length(data_av)
            funplot(mean(i).s,standev(i).s,colors(i,:),w,scenarionames{i})

            if minvar > min(mean(i).s)
                minvar = min(mean(i).s-standev(i).s);
            end
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        ylim([minvar-1000 inf])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('No. of agents')
        title('Susceptible')
        legend('Location','best')
        
        subplot(2,2,2)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).e,standev(i).e,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('No. of agents')
        title('Exposed')
        legend('Location','best')
        
        subplot(2,2,3)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).i,standev(i).i,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('No. of agents')
        title('Infectious')
        legend('Location','best')
        
        subplot(2,2,4)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).r,standev(i).r,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('No. of agents')
        title('Recovered (cumulative)')
        legend('Location','best')
        
        sgtitle(append('SEIR-figures (',Title,')'))
        
        figure('Name','Publication_figure_2','NumberTitle','off')
        
        subplot(2,3,1)
        hold on
        for i = 1 : length(data_av)
            seg1 = (-1*diff(mean(i).s))-diff(mean(i).do);
            seg2 = (-1*diff(standev(i).s))-diff(standev(i).do);
            funplot(seg1,seg2,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('No. of agents')
        title('New exposed')
        legend('Location','best')
        
        subplot(2,3,2)
        hold on
        for i = 1 : length(data_av)
            var_av = mean(i).d;
            var_sd = standev(i).d;

            for j = 2 : length(var_av)
                var_av(j) = var_av(j) - mean(i).d(j-1);
                var_sd(j) = var_sd(j) - standev(i).d(j-1);
            end

            funplot(var_av,var_sd,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('No. of agents')
        title('Deaths (new cases)')
        legend('Location','best')
        
        subplot(2,3,3)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).k,standev(i).k,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('No. of agents')
        title('Number of infectious people in hospital due to COVID-19')
        legend('Location','best')
        
        subplot(2,3,4)
        hold on
        for i = 1 : length(data_av)
            seg1 = mean(i).t+mean(i).p2;
            seg2 = standev(i).t+standev(i).p2;
            funplot(seg1,seg2,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('No. of agents')
        title('Number of new tests')
        legend('Location','best')
        
        subplot(2,3,5)
        hold on
        for i = 1 : length(data_av)
            seg1 = mean(i).p1+mean(i).p2;
            seg2 = standev(i).p1+standev(i).p2;
            funplot(seg1,seg2,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('No. of agents')
        title('Number of new, positive tests')
        legend('Location','best')
        
        subplot(2,3,6)
        hold on    
        maxvar = max((mean(1).p1+mean(1).p2)./(mean(1).t+mean(1).p2));
        for i = 1 : length(data_av)
            seg1 = (mean(i).p1+mean(i).p2)./(mean(i).t+mean(i).p2);
            seg2 = (standev(i).p1+standev(i).p2)./(standev(i).t+standev(i).p2);
            funplot(seg1,seg2,colors(i,:),w,scenarionames{i})

            if maxvar < max((mean(i).p1+mean(i).p2)./(mean(i).t+mean(i).p2))
                maxvar = max((mean(i).p1+mean(i).p2)./(mean(i).t+mean(i).p2));
            end
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        ylim([0 maxvar+0.01])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('Ratio')
        title('Ratio of new, positive tests')
        legend('Location','best')
        
        sgtitle(append('2^n^d set of figures (',Title,')'))
        
        figure('Name','Publication_figure_3','NumberTitle','off')
        
        subplot(2,3,1)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).ktnc,standev(i).ktnc,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('No. of agents')
        title('Total number of people in hospital')
        legend('Location','best')
        
        subplot(2,3,2)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).kt,standev(i).kt,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('No. of agents')
        title('Number of people in hospital due to COVID-19')
        legend('Location','best')
        
        subplot(2,3,3)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).i6,standev(i).i6,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('No. of agents')
        title('Number of people in intensive care due to COVID-19')
        legend('Location','best')
        
        subplot(2,3,4)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).q,standev(i).q,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('No. of agents')
        title('Quarantined')
        legend('Location','best')
        
        subplot(2,3,5)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).nq,standev(i).nq,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('No. of agents')
        title('NOT Quarantined AND infected')
        legend('Location','best')
        
        subplot(2,3,6)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).qt,standev(i).qt,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        dateaxis('x',2,StartDate)
        ylabel('No. of agents')
        title('Quarantined AND infected')
        legend('Location','best')
        
        sgtitle(append('3^r^d set of figures (',Title,')'))
    
        fprintf("Standard input successfully processed!\n")
    elseif flag == 0
        fprintf("Standard input processing was not requested!\n")
    else
        fprintf("You used something other than 0 or 1 for a binary flag!\n")
    end
    
end