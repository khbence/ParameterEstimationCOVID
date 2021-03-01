function fun_plotter_std(txtnames,scenarionames,Title,Measures,StartDate,flag,rdata_flag,Path,yax_string)

    if flag == 1
        
        if strcmp(yax_string,'No. of Agents')
            nepesseg = 1;
            nop = 'count';
        elseif strcmp(yax_string,'Ratio to Total Population (%)')
            nepesseg = 179500/100;
            nop = 'ratio';
        end
        
        if rdata_flag
            fprintf('Getting Hungarian data (korona_hun)...')
            hundata = GetGoogleSpreadsheet('1e4VEZL1xvsALoOIq9V2SQuICeQrT5MtWfBm32ad7i8Q');
            %col 20: number of ppl in hospital
            %col 21: number of ppl on ventilators
            numAgents = 179530;
            hunPopulation = 9770000;
            dates = datetime(hundata(2:end,1),'InputFormat','yyyy-MM-dd');
            startdate = find(dates==datestr('2020-09-23'))+1;
            %Cumulative dead in Szeged, starting sept 23
            szdead = [1,1,3,3,3,4,4,4,4,5,6,6,7,8,8,8,8,10,10,10,11,11,11,12,12,12,14,14,16,16,16,17,17,18,19,20,21,22,23,23,23,26,27,28,28,30,31,32,32,33,33,34,35,37,38,40,40,40,41,41,43,45,47,52,56,59,62,65,68,70,71,73,75,76,79,82,85,88,89,91,93,94,96,98,99,103,104,108,112,117,118,123,126,127,129,131,134,140,142,144,148,149,150,152,155,157,158,160,166,168,169,172,174,174,176,178,180,181,183,184,185,185,186,186,191,192,193,193,193,193,195,196,196,197,197,198,200,202,202];
            fprintf('Done.\n')
        end
        
        fprintf('Standard input data processing started!\n');
        
        measdim = size(Measures);
        measdim = measdim(1);
        
        w = 1.5; % line width
        angle = 60;

        colors = [[1 0 0];[0 1 0];[0 0 1];[0 0 0];[1 0 1];[0 1 1];[0 0.4470 0.7410];[0.9290 0.6940 0.1250];[0.4490 0.9240 0.1250]];

        [mean,standev] = fun_std_organize(txtnames);

        data_av = mean;
        
        dps = 15;
        divnum = mod(length(data_av(1).s),dps);
        newmax = length(data_av(1).s)-divnum;
        xlim_def = 0:dps:newmax;
        
        mkdir(Path)
        
        detfl = rdata_flag;
        
        if detfl == 1
        deterdata = readmatrix('data/Szeged_data_20200923.csv');
        % 1->infected 2->newexposed 3->I56(Rh) 4->R 5->D 6->newD 7->S 8->exposed 9->R0 10->Rc
        end
        
        
        fprintf('Standard input data processed!\n');
        FIGH = figure('Name','Plots1_std','NumberTitle','off','Position',get(0,'Screensize'));

        subplot(3,3,1)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).s/nepesseg,standev(i).s/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if detfl == 1
        plot(deterdata(:,7)/nepesseg,'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5,'DisplayName','Deterministic')
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        ylim([(186000/2)/nepesseg 186000/nepesseg])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(yax_string)
        title('Susceptible')
        legend('Location','best')

        subplot(3,3,2)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).e/nepesseg,standev(i).e/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if detfl == 1
        plot(deterdata(:,8)/nepesseg,'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5,'DisplayName','Deterministic')
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(yax_string)
        title('Exposed')
        legend('Location','best')

        subplot(3,3,3)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).i/nepesseg,standev(i).i/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        %data = readmatrix('data_long.txt');
        %plot(data,'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5,'DisplayName','Data')
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(yax_string)
        title('Infectious')
        legend('Location','best')

        subplot(3,3,4)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).ei/nepesseg,standev(i).ei/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if detfl == 1
        plot(deterdata(:,1)/nepesseg,'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5,'DisplayName','Deterministic')
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(yax_string)
        title('Infected')
        legend('Location','best')

        subplot(3,3,5)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).r/nepesseg,standev(i).r/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if detfl == 1
        plot(deterdata(:,4)/nepesseg,'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5,'DisplayName','Deterministic')
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(yax_string)
        title('Recovered')
        legend('Location','best')

        subplot(3,3,6)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).d/nepesseg,standev(i).d/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if rdata_flag
            rdata = str2double(hundata(startdate:end,4))-str2double(hundata(startdate,4));
            funplot_realdata(rdata/nepesseg,numAgents,hunPopulation,w);
            szdead_len = numel(szdead);
            plot(0:szdead_len-1,szdead/nepesseg,'Color',[255/255,69/255,50/255],'LineWidth',w,'DisplayName','Szeged data');
        end
        if detfl == 1
        plot(deterdata(:,5)/nepesseg,'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5,'DisplayName','Deterministic')
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(yax_string)
        title('Deaths')
        legend('Location','best')

        subplot(3,3,7)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).ne/nepesseg,standev(i).ne/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if detfl == 1
        plot(deterdata(:,2)/nepesseg,'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5,'DisplayName','Deterministic')
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(yax_string)
        title('New exposed')
        legend('Location','best')

        subplot(3,3,8)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).didc/nepesseg,standev(i).didc/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if detfl == 1
        plot(deterdata(:,6)/nepesseg,'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5,'DisplayName','Deterministic')
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(yax_string)
        title('New deaths')
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
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel('Ratio (%)')
        title('Ratio of the mutant virus')
        legend('Location','best')

        sgtitle(append('SEIRD-related (',Title,')'))
        
        F = getframe(FIGH);
        mkdir(append(Path,'/std_',nop))
        imwrite(F.cdata,append(Path,'/std_',nop,'/std-1.jpg'),'jpg')
        savefig(append(Path,'/std_',nop,'/z_std-1.fig'))

        FIGH = figure('Name','Plots2_std','NumberTitle','off','Position',get(0,'Screensize'));

        subplot(2,3,1)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).nat/nepesseg,standev(i).nat/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if rdata_flag
            rdata = str2double(hundata(startdate:end,16));
            funplot_realdata(rdata/nepesseg,numAgents,hunPopulation,w);
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(yax_string)
        title('Number of new tests')
        legend('Location','best')

        subplot(2,3,4)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).npt/nepesseg,standev(i).npt/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if rdata_flag
            rdata = str2double(hundata(startdate:end,3));
            funplot_realdata(rdata/nepesseg,numAgents,hunPopulation,w);
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(yax_string)
        title('Number of new, positive tests, diagnoses')
        legend('Location','best')

        subplot(2,3,[2 3])
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).rpt,standev(i).rpt,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if rdata_flag
            rdata = str2double(hundata(startdate:end,3))./str2double(hundata(startdate:end,16));
            funplot_realdata(rdata/nepesseg,1,1,w);
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel('Ratio')
        title('Ratio of new, positive tests')
        legend('Location','best')
        
        subplot(2,3,5)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).sat/nepesseg,standev(i).sat/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if rdata_flag
            rdata = cumsum(str2double(hundata(startdate:end,16)));
            funplot_realdata(rdata/nepesseg,numAgents,hunPopulation,w);
        end
        
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(append('Cumulative ',yax_string))
        title('Number of tests')
        legend('Location','best')

        subplot(2,3,6)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).spt/nepesseg,standev(i).spt/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if rdata_flag
            rdata = cumsum(str2double(hundata(startdate:end,3)));
            funplot_realdata(rdata/nepesseg,numAgents,hunPopulation,w);
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(append('Cumulative ',yax_string))
        title('Number of positive tests')
        legend('Location','best')

        sgtitle(append('Testing (',Title,')'))
        
        F = getframe(FIGH);
        imwrite(F.cdata,append(Path,'/std_',nop,'/std-2.jpg'),'jpg')
        savefig(append(Path,'/std_',nop,'/z_std-2.fig'))

        FIGH = figure('Name','Plots3_std','NumberTitle','off','Position',get(0,'Screensize'));

        subplot(2,2,4)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).ktnc/nepesseg,standev(i).ktnc/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(yax_string)
        title('Total number of people in hospital')
        legend('Location','best')

        subplot(2,2,3)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).kt/nepesseg,standev(i).kt/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if rdata_flag
            rdata = str2double(hundata(startdate:end,20));
            funplot_realdata(rdata/nepesseg,numAgents,hunPopulation,w);
        end
        if detfl == 1
        plot(deterdata(:,3)/nepesseg,'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5,'DisplayName','Deterministic')
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(yax_string)
        title('Number of people in hospital due to COVID-19')
        legend('Location','best')

        subplot(2,2,2)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).k/nepesseg,standev(i).k/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(yax_string)
        title('Number of infectious people in hospital due to COVID-19')
        legend('Location','best')

        subplot(2,2,1)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).i6/nepesseg,standev(i).i6/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(yax_string)
        title('Number of people in intensive care due to COVID-19')
        legend('Location','best')

        sgtitle(append('Hospitalization (',Title,')'))
        
        F = getframe(FIGH);
        imwrite(F.cdata,append(Path,'/std_',nop,'/std-3.jpg'),'jpg')
        savefig(append(Path,'/std_',nop,'/z_std-3.fig'))

        FIGH = figure('Name','Plots4_std','NumberTitle','off','Position',get(0,'Screensize'));

        subplot(2,3,1)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).q/nepesseg,standev(i).q/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(yax_string)
        title('Quarantined')
        legend('Location','best')

        subplot(2,3,2)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).nq/nepesseg,standev(i).nq/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(yax_string)
        title('NOT Quarantined AND infected')
        legend('Location','best')

        subplot(2,3,3)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).qni/nepesseg,standev(i).qni/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(yax_string)
        title('Quarantined AND NOT infected')
        legend('Location','best')

        subplot(2,3,4)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).qt/nepesseg,standev(i).qt/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(yax_string)
        title('Quarantined AND infected')
        legend('Location','best')
        
        subplot(2,3,5)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).qii/nepesseg,standev(i).qii/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel('Ratio')
        title('Quarantined and infected to Infected ratio')
        legend('Location','best')
        
        subplot(2,3,6)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).qiq/nepesseg,standev(i).qiq/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel('Ratio')
        title('Quarantined and infected to Quarantined ratio')
        legend('Location','best')

        sgtitle(append('Quarantine (',Title,')'))
        
        F = getframe(FIGH);
        imwrite(F.cdata,append(Path,'/std_',nop,'/std-4.jpg'),'jpg')
        savefig(append(Path,'/std_',nop,'/z_std-4.fig'))
        
        FIGH = figure('Name','Plots5_std','NumberTitle','off','Position',get(0,'Screensize'));
        
        subplot(1,2,1)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).disu/nepesseg,standev(i).disu/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(yax_string)
        title('Susceptible (derivative)')
        legend('Location','best')
        
        subplot(1,2,2)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).dirt/nepesseg,standev(i).dirt/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(yax_string)
        title('Recovered (derivative)')
        legend('Location','best')
        
        sgtitle(append('Susceptible and recovered change rate (',Title,')'))
        
        F = getframe(FIGH);
        imwrite(F.cdata,append(Path,'/std_',nop,'/std-5.jpg'),'jpg')
        savefig(append(Path,'/std_',nop,'/z_std-5.fig'))
        
        FIGH = figure('Name','Plots6_std','NumberTitle','off','Position',get(0,'Screensize'));
        
        subplot(2,2,1)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).do/nepesseg,standev(i).do/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(yax_string)
        title('Deaths')
        legend('Location','best')
        
        subplot(2,2,2)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).dido/nepesseg,standev(i).dido/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(yax_string)
        title('New deaths')
        legend('Location','best')
        
        subplot(2,2,[3 4])
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).h/nepesseg,standev(i).h/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(yax_string)
        title('Hospitalization')
        legend('Location','best')
        
        sgtitle(append('Not COVID-related results (',Title,')'))
        
        F = getframe(FIGH);
        imwrite(F.cdata,append(Path,'/std_',nop,'/std-6.jpg'),'jpg')
        savefig(append(Path,'/std_',nop,'/z_std-6.fig'))
        
        FIGH = figure('Name','Plots7_std','NumberTitle','off','Position',get(0,'Screensize'));
        
        subplot(2,2,1)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).vac/nepesseg,standev(i).vac/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if rdata_flag
            start = str2double(hundata(startdate,34));
            start(isnan(start)) = 0;
            full = str2double(hundata(startdate:end,34));
            full(isnan(full)) = 0;
            rdata = full-start;
            funplot_realdata(rdata,numAgents,hunPopulation,w);
        end    
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(yax_string)
        title('Daily vaccinations (first shot)')
        legend('Location','best')
        
        subplot(2,2,2)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).cvac/nepesseg,standev(i).cvac/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if rdata_flag
            start = str2double(hundata(startdate,33));
            start(isnan(start)) = 0;
            full = str2double(hundata(startdate:end,33));
            full(isnan(full)) = 0;
            rdata = (full-start)./hunPopulation*100;
            funplot_realdata(rdata,1,1,w);
        end  
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(yax_string)
        title('Cumulative vaccinations')
        legend('Location','best')
        
        subplot(2,2,[3 4])
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).immu/nepesseg,standev(i).immu/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(yax_string)
        title('Recovered and immunized')
        legend('Location','best')
        
        sgtitle(append('Immunization progress (',Title,')'))
        
        F = getframe(FIGH);
        imwrite(F.cdata,append(Path,'/std_',nop,'/std-7.jpg'),'jpg')
        savefig(append(Path,'/std_',nop,'/z_std-7.fig'))
        
        
        FIGH = figure('Name','Plots8_std','NumberTitle','off','Position',get(0,'Screensize'));

        hold on
        for i = 1 : length(data_av)
            funplot(smoothdata(mean(i).re,'movmedian',14),smoothdata(standev(i).re,'movmedian',14),colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if detfl == 1
        plot(deterdata(:,10)/nepesseg,'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5,'DisplayName','Deterministic')
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel('Ratio')
        title('New exposed and current infected ratio')
        legend('Location','best')
        
        F = getframe(FIGH);
        imwrite(F.cdata,append(Path,'/std_',nop,'/std-8.jpg'),'jpg')
        savefig(append(Path,'/std_',nop,'/z_std-8.fig'))
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Publication figures below this line %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        FIGH = figure('Name','Publication_figure_1','NumberTitle','off','Position',get(0,'Screensize'));
        
        subplot(2,2,1)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).s/nepesseg,standev(i).s/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if detfl == 1
        plot(deterdata(:,7)/nepesseg,'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5,'DisplayName','Deterministic')
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        ylim([(186000/2)/nepesseg 186000/nepesseg])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(yax_string)
        title('Susceptible')
        legend('Location','best')
        
        subplot(2,2,2)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).e/nepesseg,standev(i).e/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if detfl == 1
        plot(deterdata(:,8)/nepesseg,'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5,'DisplayName','Deterministic')
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(yax_string)
        title('Exposed')
        legend('Location','best')
        
        subplot(2,2,3)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).i/nepesseg,standev(i).i/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(yax_string)
        title('Infectious')
        legend('Location','best')
        
        subplot(2,2,4)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).r/nepesseg,standev(i).r/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if detfl == 1
        plot(deterdata(:,4)/nepesseg,'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5,'DisplayName','Deterministic')
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(yax_string)
        title('Recovered')
        legend('Location','best')
        
        sgtitle(append('SEIR-figures (',Title,')'))
        
        F = getframe(FIGH);
        mkdir(append(Path,'/pub_',nop))
        imwrite(F.cdata,append(Path,'/pub_',nop,'/pub-1.jpg'),'jpg')
        savefig(append(Path,'/pub_',nop,'/z_pub-1.fig'))
        
        FIGH = figure('Name','Publication_figure_2','NumberTitle','off','Position',get(0,'Screensize'));
        
        subplot(2,3,1)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).ne/nepesseg,standev(i).ne/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if detfl == 1
        plot(deterdata(:,2)/nepesseg,'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5,'DisplayName','Deterministic')
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(yax_string)
        title('New exposed')
        legend('Location','best')
        
        subplot(2,3,2)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).didc/nepesseg,standev(i).didc/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if detfl == 1
        plot(deterdata(:,6)/nepesseg,'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5,'DisplayName','Deterministic')
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(yax_string)
        title('New deaths')
        legend('Location','best')
        
        subplot(2,3,3)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).k/nepesseg,standev(i).k/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(yax_string)
        title('Number of infectious people in hospital due to COVID-19')
        legend('Location','best')
        
        subplot(2,3,4)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).nat/nepesseg,standev(i).nat/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(yax_string)
        title('Number of new tests')
        legend('Location','best')
        
        subplot(2,3,5)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).npt/nepesseg,standev(i).npt/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(yax_string)
        title('Number of new, positive tests, diagnoses')
        legend('Location','best')
        
        subplot(2,3,6)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).rpt,standev(i).rpt,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel('Ratio')
        title('Ratio of new, positive tests')
        legend('Location','best')
        
        sgtitle(append('2^n^d set of figures (',Title,')'))
        
        F = getframe(FIGH);
        imwrite(F.cdata,append(Path,'/pub_',nop,'/pub-2.jpg'),'jpg')
        savefig(append(Path,'/pub_',nop,'/z_pub-2.fig'))
        
        FIGH = figure('Name','Publication_figure_3','NumberTitle','off','Position',get(0,'Screensize'));
        
        subplot(2,3,1)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).ktnc/nepesseg,standev(i).ktnc/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(yax_string)
        title('Total number of people in hospital')
        legend('Location','best')
        
        subplot(2,3,2)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).kt/nepesseg,standev(i).kt/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if detfl == 1
        plot(deterdata(:,3)/nepesseg,'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5,'DisplayName','Deterministic')
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(yax_string)
        title('Number of people in hospital due to COVID-19')
        legend('Location','best')
        
        subplot(2,3,3)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).i6/nepesseg,standev(i).i6/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(yax_string)
        title('Number of people in intensive care due to COVID-19')
        legend('Location','best')
        
        subplot(2,3,4)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).q/nepesseg,standev(i).q/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(yax_string)
        title('Quarantined')
        legend('Location','best')
        
        subplot(2,3,5)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).nq/nepesseg,standev(i).nq/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(yax_string)
        title('NOT Quarantined AND infected')
        legend('Location','best')
        
        subplot(2,3,6)
        hold on
        for i = 1 : length(data_av)
            funplot(mean(i).qt/nepesseg,standev(i).qt/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        grid on
        grid minor
        xlim([0 length(data_av(1).s)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel(yax_string)
        title('Quarantined AND infected')
        legend('Location','best')
        
        sgtitle(append('3^r^d set of figures (',Title,')'))
        
        F = getframe(FIGH);
        imwrite(F.cdata,append(Path,'/pub_',nop,'/pub-3.jpg'),'jpg')
        savefig(append(Path,'/pub_',nop,'/z_pub-3.fig'))
    
        fprintf("Standard input successfully processed!\n")
    elseif flag == 0
        fprintf("Standard input processing was not requested!\n")
    else
        fprintf("You used something other than 0 or 1 for a binary flag!\n")
    end
    
end
