function fun_plotter_std(txtnames,scenarionames,Title,Measures,StartDate,rdata_flag,Path,yax_string,colors,begintint,agst_ip,ctw_flag)

        saveimg_flag = 1;
        % Mátrix a kimeneti CSV-hez: 1,2->összhalott, 3,4->kórházmax,
        % 5,6->kórházössz, 7,8->intenzívmax, 9,10->intenzívössz, 11,12->kórház>200
        matrix4csv = zeros(length(scenarionames),12);

        begintint = begintint + 1;
        for i = 1 : length(Measures)
            Measures{i,2} = Measures{i,2} - begintint + 1;
        end

        if strcmp(yax_string,'No. of Agents')
            nepesseg = 1;
            nop = 'count';
        elseif strcmp(yax_string,'Ratio to Total Population (%)')
            nepesseg = 179500/100;
            nop = 'ratio';
        end
        
        if rdata_flag
            fprintf('Getting Hungarian data (korona_hun)...')
            hundata = funGetGoogleSpreadsheet('1e4VEZL1xvsALoOIq9V2SQuICeQrT5MtWfBm32ad7i8Q');
            %col 20: number of ppl in hospital
            %col 21: number of ppl on ventilators
            numAgents = 179530;
            hunPopulation = 9770000;
            dates = datetime(hundata(2:end,1),'InputFormat','yyyy-MM-dd');
            startdate = find(dates==datestr('2020-09-23'))+1;
            %Cumulative dead in Szeged, starting sept 23
            szdead = readmatrix('szeged_data/aszh.xlsx')';
            szcase = readmatrix('szeged_data/asze.xlsx')';
            szdead(2,:) = 0;
            szcase(2,:) = 0;
            szdead = (179500/160766)*(szdead(1,:) + szdead(2,:));
            szcase = (179500/160766)*(szcase(1,:) + szcase(2,:));
            szdead = cumsum(szdead);
            %szcase = cumsum(szcase);
            szdead(1:begintint-1) = [];
            szcase(1:begintint-1) = [];
            fprintf('Done.\n')
        end
        
        fprintf('Standard input data processing started!\n');
        
        measdim = size(Measures);
        measdim = measdim(1);
        
        w = 1.5; % line width
        angle = 60;

        [meany,standev] = fun_std_organize(txtnames);
        data_av = meany;

        if strcmp(yax_string,'Ratio to Total Population (%)') && ctw_flag
            
            avdays = zeros(length(data_av(1).s),length(scenarionames));
            
            for it = 1 : length(scenarionames)
                
                samplename = agst_ip{it};
            
                list = dir(append(samplename,'*'));
                list = (extractfield(list,'name'))';
                list = string(list);
                list = split(list,'_');
                list(:,1:end-1) = [];
                list = split(list,'.');
                list(:,2) = [];
                list = str2double(list);

                final_ar = [];

                for i = 1 : length(list)

                    AgentStatseg = fun_agst_statreadprocfun(append(samplename,num2str(list(i)),'.json'));
                    inftimeseg = extractfield(AgentStatseg,'infectionTime')';
                    begtimeseg = extractfield(AgentStatseg,'worstState_begin')';
                    endtimeseg = extractfield(AgentStatseg,'worstState_end')';
                    
                    finagstinf = [inftimeseg begtimeseg endtimeseg];
                    
                    final_ar = [final_ar; finagstinf];

                end
                
                for i = 1 : length(data_av(1).s)
                    
                    avdayvec = [];
                    
                    for j = 1 : length(final_ar)
                        
                        if final_ar(j,1) < 100000
                            
                            if final_ar(j,2) > final_ar(j,3)
                                
                                if ismember(i-1,final_ar(j,1):final_ar(j,3))
                                    avdayvec = [avdayvec final_ar(j,3)-final_ar(j,1)];
                                end
                                
                            elseif final_ar(j,3) == -1
                                
                                if ismember(i-1,final_ar(j,1):final_ar(j,2))
                                    avdayvec = [avdayvec final_ar(j,2)-final_ar(j,1)];
                                end
                                
                            elseif final_ar(j,1) < final_ar(j,2) && final_ar(j,2) < final_ar(j,3)
                                
                                if ismember(i-1,final_ar(j,1):final_ar(j,3))
                                    avdayvec = [avdayvec final_ar(j,3)-final_ar(j,1)];
                                end
                                
                            end
                            
                        end
                        
                    end
                    
                    avdays(i,it) = mean(avdayvec);
                    
                end
                
            end
            
        else
            
            avdays = ones(length(data_av(1).s),length(scenarionames));
            
        end
        
        for i = 1 : length(data_av)
            matrix4csv(i,1) = meany(i).CSVdm;
            matrix4csv(i,2) = standev(i).CSVdm;
            matrix4csv(i,3) = meany(i).CSVkm;
            matrix4csv(i,4) = standev(i).CSVkm;
            matrix4csv(i,5) = meany(i).CSVko;
            matrix4csv(i,6) = standev(i).CSVko;
            matrix4csv(i,7) = meany(i).CSVim;
            matrix4csv(i,8) = standev(i).CSVim;
            matrix4csv(i,9) = meany(i).CSVio;
            matrix4csv(i,10) = standev(i).CSVio;
            matrix4csv(i,11) = meany(i).CSVki;
            matrix4csv(i,12) = standev(i).CSVki;
        end
        
        dps = 15;
        divnum = mod(length(data_av(1).s),dps);
        newmax = length(data_av(1).s)-divnum;
        xlim_def = 0:dps:newmax;
        
        mkdir(Path)
        
        detfl = rdata_flag;
        
        if detfl == 1
        deterdata = readmatrix('szeged_data/Szeged_inversion_20200923.xlsx');
        deterdata(:,1) = [];
        deterdata(1:begintint-1,:) = [];
        % 1->infected 2->newexposed 3->I56(Rh) 4->R 5->D 6->newD 7->S 8->exposed 9->R0 10->Rc
        end
        
        
        fprintf('Standard input data processed!\n');
        FIGH = figure('Name','Plots1_std','NumberTitle','off','Position',get(0,'Screensize'));

        subplot(3,3,1)
        hold on
        for i = 1 : length(data_av)
            funplot(meany(i).s(begintint:end)/nepesseg,standev(i).s(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if detfl == 1
        plot(deterdata(begintint:end,7)/nepesseg,'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5,'DisplayName','Deterministic')
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
            funplot(meany(i).e(begintint:end)/nepesseg,standev(i).e(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if detfl == 1
        plot(deterdata(begintint:end,8)/nepesseg,'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5,'DisplayName','Deterministic')
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
            funplot(meany(i).i(begintint:end)/nepesseg,standev(i).i(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
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
            funplot(meany(i).ei(begintint:end)/nepesseg,standev(i).ei(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if detfl == 1
        plot(deterdata(begintint:end,1)/nepesseg,'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5,'DisplayName','Deterministic')
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
            funplot(meany(i).r(begintint:end)/nepesseg,standev(i).r(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if detfl == 1
        plot(deterdata(begintint:end,4)/nepesseg,'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5,'DisplayName','Deterministic')
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
            funplot(meany(i).d(begintint:end)/nepesseg,standev(i).d(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if rdata_flag
            rdata = str2double(hundata(startdate:end,4))-str2double(hundata(startdate,4));
            funplot_realdata(rdata(begintint:end),numAgents,hunPopulation,w,nepesseg);
            szdead_len = numel(szdead(begintint:end));
            plot(0:szdead_len-1,szdead(begintint:end)/nepesseg,'Color',[255/255,69/255,50/255],'LineWidth',w,'DisplayName','Szeged data');
        end
        if detfl == 1
        plot(deterdata(begintint:end,5)/nepesseg,'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5,'DisplayName','Deterministic')
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
            funplot(meany(i).ne(begintint:end)/nepesseg,standev(i).ne(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if detfl == 1
        plot(deterdata(begintint:end,2)/nepesseg,'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5,'DisplayName','Deterministic')
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
            funplot(meany(i).didc(begintint:end)/nepesseg,standev(i).didc(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if rdata_flag
            rdata = str2double(hundata(startdate:end,18));
            funplot_realdata(rdata,numAgents,hunPopulation,w,nepesseg);
        end
        if detfl == 1
        plot(deterdata(begintint:end,6)/nepesseg,'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5,'DisplayName','Deterministic')
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
            funplot(meany(i).mu(begintint:end),standev(i).mu(begintint:end),colors(i,:),w,scenarionames{i})
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
        if saveimg_flag
            imwrite(F.cdata,append(Path,'/std_',nop,'/std-1.jpg'),'jpg')
            savefig(append(Path,'/std_',nop,'/z_std-1.fig'))
        end

        FIGH = figure('Name','Plots2_std','NumberTitle','off','Position',get(0,'Screensize'));

        subplot(2,3,1)
        hold on
        for i = 1 : length(data_av)
            funplot(meany(i).nat(begintint:end)/nepesseg,standev(i).nat(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if rdata_flag
            rdata = str2double(hundata(startdate:end,16));
            funplot_realdata(rdata(begintint:end),numAgents,hunPopulation,w,nepesseg);
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
            funplot(meany(i).npt(begintint:end)/nepesseg,standev(i).npt(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if rdata_flag
            rdata = str2double(hundata(startdate:end,3));
            funplot_realdata(rdata(begintint:end),numAgents,hunPopulation,w,nepesseg);
            szcase_len = numel(szcase(begintint:end));
            plot(0:szcase_len-1,szcase(begintint:end)/nepesseg,'Color',[255/255,69/255,50/255],'LineWidth',w,'DisplayName','Szeged data');
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
        title('Number of new, positive tests')
        legend('Location','best')

        subplot(2,3,[2 3])
        hold on
        for i = 1 : length(data_av)
            funplot(meany(i).rpt(begintint:end),standev(i).rpt(begintint:end),colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if rdata_flag
            rdata = str2double(hundata(startdate:end,3))./str2double(hundata(startdate:end,16));
            funplot_realdata(rdata(begintint:end),1,1,w,nepesseg);
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
            funplot(meany(i).sat(begintint:end)/nepesseg,standev(i).sat(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if rdata_flag
            rdata = cumsum(str2double(hundata(startdate:end,16)));
            funplot_realdata(rdata(begintint:end),numAgents,hunPopulation,w,nepesseg);
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
            funplot(meany(i).spt(begintint:end)/nepesseg,standev(i).spt(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if rdata_flag
            rdata = cumsum(str2double(hundata(startdate:end,3)));
            funplot_realdata(rdata(begintint:end),numAgents,hunPopulation,w,nepesseg);
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
        if saveimg_flag
        imwrite(F.cdata,append(Path,'/std_',nop,'/std-2.jpg'),'jpg')
        savefig(append(Path,'/std_',nop,'/z_std-2.fig'))
        end

        FIGH = figure('Name','Plots3_std','NumberTitle','off','Position',get(0,'Screensize'));

        subplot(2,2,4)
        hold on
        for i = 1 : length(data_av)
            funplot(meany(i).ktnc(begintint:end)/nepesseg,standev(i).ktnc(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
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
            funplot(meany(i).kt(begintint:end)/nepesseg,standev(i).kt(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if rdata_flag
            rdata = str2double(hundata(startdate:end,20));
            funplot_realdata(rdata(begintint:end),numAgents,hunPopulation,w,nepesseg);
        end
        if detfl == 1
        plot(deterdata(begintint:end,3)/nepesseg,'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5,'DisplayName','Deterministic')
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
            funplot(meany(i).k(begintint:end)/nepesseg,standev(i).k(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
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
            funplot(meany(i).i6(begintint:end)/nepesseg,standev(i).i6(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
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
        if saveimg_flag
        imwrite(F.cdata,append(Path,'/std_',nop,'/std-3.jpg'),'jpg')
        savefig(append(Path,'/std_',nop,'/z_std-3.fig'))
        end

        FIGH = figure('Name','Plots4_std','NumberTitle','off','Position',get(0,'Screensize'));

        subplot(2,3,1)
        hold on
        for i = 1 : length(data_av)
            funplot(meany(i).q(begintint:end)/nepesseg,standev(i).q(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
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
            funplot(meany(i).nq(begintint:end)/nepesseg,standev(i).nq(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
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
            funplot(meany(i).qni(begintint:end)/nepesseg,standev(i).qni(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
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
            funplot(meany(i).qt(begintint:end)/nepesseg,standev(i).qt(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
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
            funplot(meany(i).qii(begintint:end)/nepesseg,standev(i).qii(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
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
            funplot(meany(i).qiq(begintint:end)/nepesseg,standev(i).qiq(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
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
        if saveimg_flag
        imwrite(F.cdata,append(Path,'/std_',nop,'/std-4.jpg'),'jpg')
        savefig(append(Path,'/std_',nop,'/z_std-4.fig'))
        end
        
        FIGH = figure('Name','Plots5_std','NumberTitle','off','Position',get(0,'Screensize'));
        
        subplot(1,2,1)
        hold on
        for i = 1 : length(data_av)
            funplot(meany(i).disu(begintint:end)/nepesseg,standev(i).disu(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
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
            funplot(meany(i).dirt(begintint:end)/nepesseg,standev(i).dirt(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
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
        if saveimg_flag
        imwrite(F.cdata,append(Path,'/std_',nop,'/std-5.jpg'),'jpg')
        savefig(append(Path,'/std_',nop,'/z_std-5.fig'))
        end
        
        FIGH = figure('Name','Plots6_std','NumberTitle','off','Position',get(0,'Screensize'));
        
        subplot(2,2,1)
        hold on
        for i = 1 : length(data_av)
            funplot(meany(i).do(begintint:end)/nepesseg,standev(i).do(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
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
            funplot(meany(i).dido(begintint:end)/nepesseg,standev(i).dido(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
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
            funplot(meany(i).h(begintint:end)/nepesseg,standev(i).h(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
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
        if saveimg_flag
        imwrite(F.cdata,append(Path,'/std_',nop,'/std-6.jpg'),'jpg')
        savefig(append(Path,'/std_',nop,'/z_std-6.fig'))
        end
        
        FIGH = figure('Name','Plots7_std','NumberTitle','off','Position',get(0,'Screensize'));
        
        subplot(2,2,1)
        hold on
        for i = 1 : length(data_av)
            funplot(meany(i).vac(begintint:end)/nepesseg,standev(i).vac(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
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
            funplot_realdata(rdata(begintint:end),numAgents,hunPopulation,w,nepesseg);
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
            funplot(meany(i).cvac(begintint:end)/nepesseg,standev(i).cvac(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if rdata_flag
            start = str2double(hundata(startdate,33));
            start(isnan(start)) = 0;
            full = str2double(hundata(startdate:end,33));
            full(isnan(full)) = 0;
            %rdata = (full-start)./hunPopulation*100;
            rdata = full-start;
            funplot_realdata(rdata(begintint:end),numAgents,hunPopulation,w,nepesseg);
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
            funplot(meany(i).immu(begintint:end)/nepesseg,standev(i).immu(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
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
        if saveimg_flag
        imwrite(F.cdata,append(Path,'/std_',nop,'/std-7.jpg'),'jpg')
        savefig(append(Path,'/std_',nop,'/z_std-7.fig'))
        end
        
        
        FIGH = figure('Name','Plots8_std','NumberTitle','off','Position',get(0,'Screensize'));

        hold on
        for i = 1 : length(data_av)
            funplot(avdays(begintint:end,i).*smoothdata(meany(i).re(begintint:end),'movmedian',14),...
                    avdays(begintint:end,i).*smoothdata(standev(i).re(begintint:end),'movmedian',14),...
                    colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if detfl == 1
        plot(deterdata(begintint:end,10),'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5,'DisplayName','Deterministic')
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
        if saveimg_flag
        imwrite(F.cdata,append(Path,'/std_',nop,'/std-8.jpg'),'jpg')
        savefig(append(Path,'/std_',nop,'/z_std-8.fig'))
        end
        
        FIGH = figure('Name','Plots9_std','NumberTitle','off','Position',get(0,'Screensize'));

        hold on
        for i = 1 : length(data_av)
            %funplot(smoothdata(mean(i).re,'movmedian',14),smoothdata(standev(i).re,'movmedian',14),colors(i,:),w,scenarionames{i})
            plot(meany(i).spec1,meany(i).spec2,'o','Color',colors(i,:),'LineWidth',w,'DisplayName',scenarionames{i},'MarkerFaceColor',[0.5 0.5 0.5]);
        end
        hold off
        grid on
        grid minor
        xlabel('% of population tested daily')
        ylabel('% of infected portion being in quaratine')
        zlabel('Time [days]')
        title('% of infected portion being in quaratine as a function of the % of population tested daily')
        legend('Location','best')
        
        F = getframe(FIGH);
        if saveimg_flag
        imwrite(F.cdata,append(Path,'/std_',nop,'/std-9.jpg'),'jpg')
        savefig(append(Path,'/std_',nop,'/z_std-9.fig'))
        end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Publication figures below this line %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        FIGH = figure('Name','Publication_figure_1','NumberTitle','off','Position',get(0,'Screensize'));
        
        subplot(2,2,1)
        hold on
        for i = 1 : length(data_av)
            funplot(meany(i).s(begintint:end)/nepesseg,standev(i).s(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if detfl == 1
        plot(deterdata(begintint:end,7)/nepesseg,'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5,'DisplayName','Deterministic')
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
            funplot(meany(i).e(begintint:end)/nepesseg,standev(i).e(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if detfl == 1
        plot(deterdata(begintint:end,8)/nepesseg,'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5,'DisplayName','Deterministic')
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
            funplot(meany(i).i(begintint:end)/nepesseg,standev(i).i(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
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
            funplot(meany(i).r(begintint:end)/nepesseg,standev(i).r(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if detfl == 1
        plot(deterdata(begintint:end,4)/nepesseg,'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5,'DisplayName','Deterministic')
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
        if saveimg_flag
        imwrite(F.cdata,append(Path,'/pub_',nop,'/pub-1.jpg'),'jpg')
        savefig(append(Path,'/pub_',nop,'/z_pub-1.fig'))
        end
        
        FIGH = figure('Name','Publication_figure_2','NumberTitle','off','Position',get(0,'Screensize'));
        
        subplot(2,3,1)
        hold on
        for i = 1 : length(data_av)
            funplot(meany(i).ne(begintint:end)/nepesseg,standev(i).ne(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if detfl == 1
        plot(deterdata(begintint:end,2)/nepesseg,'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5,'DisplayName','Deterministic')
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
            funplot(meany(i).didc(begintint:end)/nepesseg,standev(i).didc(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if detfl == 1
        plot(deterdata(begintint:end,6)/nepesseg,'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5,'DisplayName','Deterministic')
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
            funplot(meany(i).k(begintint:end)/nepesseg,standev(i).k(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
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
            funplot(meany(i).nat(begintint:end)/nepesseg,standev(i).nat(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
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
            funplot(meany(i).npt(begintint:end)/nepesseg,standev(i).npt(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
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
        title('Number of new, positive tests')
        legend('Location','best')
        
        subplot(2,3,6)
        hold on
        for i = 1 : length(data_av)
            funplot(meany(i).rpt(begintint:end),standev(i).rpt(begintint:end),colors(i,:),w,scenarionames{i})
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
        if saveimg_flag
        imwrite(F.cdata,append(Path,'/pub_',nop,'/pub-2.jpg'),'jpg')
        savefig(append(Path,'/pub_',nop,'/z_pub-2.fig'))
        end
        
        FIGH = figure('Name','Publication_figure_3','NumberTitle','off','Position',get(0,'Screensize'));
        
        subplot(2,3,1)
        hold on
        for i = 1 : length(data_av)
            funplot(meany(i).ktnc(begintint:end)/nepesseg,standev(i).ktnc(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
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
            funplot(meany(i).kt(begintint:end)/nepesseg,standev(i).kt(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if detfl == 1
        plot(deterdata(begintint:end,3)/nepesseg,'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5,'DisplayName','Deterministic')
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
            funplot(meany(i).i6(begintint:end)/nepesseg,standev(i).i6(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
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
            funplot(meany(i).q(begintint:end)/nepesseg,standev(i).q(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
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
            funplot(meany(i).nq(begintint:end)/nepesseg,standev(i).nq(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
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
            funplot(meany(i).qt(begintint:end)/nepesseg,standev(i).qt(begintint:end)/nepesseg,colors(i,:),w,scenarionames{i})
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
        if saveimg_flag
        imwrite(F.cdata,append(Path,'/pub_',nop,'/pub-3.jpg'),'jpg')
        savefig(append(Path,'/pub_',nop,'/z_pub-3.fig'))
        end
        
        if strcmp(yax_string,'No. of Agents')
            colnames = {'Deceasedsum_av','Deceasedsum_std','Hospitalmax_av','Hospitalmax_std',
                        'Hospitalsum_av','Hospitalsum_std','Intensivmax_av','Intensivmax_std',
                        'Intensivsum_av','Intensivsum_std','Hospitalthr_av','Hospitalthr_std'};
            matrix4csv = array2table(matrix4csv,'VariableNames',colnames);
            matrix4csv = addvars(matrix4csv,scenarionames,'Before','Deceasedsum_av');
            writetable(matrix4csv,append(Path,'/',Title,'.csv'),'Delimiter','|')
        end
    
end
