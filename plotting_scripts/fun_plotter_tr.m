function output = fun_plotter_tr(tr_ip,agst_ip,scenarionames,Title,Measures,StartDate,flag,agents,locations,Path)

    if flag == 1
        
        av_mu = 1;
        
        w = 1.5;
        angle = 60;
        
        measdim = size(Measures);
        measdim = measdim(1);

        colors = [[1 0 0];[0 1 0];[0 0 1];[0 0 0];[1 0 1];[0 1 1];[0 0.4470 0.7410];[0.9290 0.6940 0.1250]];
        
        
        output = fun_tr_postprocess(tr_ip,agst_ip,agents,locations);
        
        dps = 15;
        divnum = mod(length(output(1).tracer.average.av),dps);
        newmax = length(output(1).tracer.average.av)-divnum;
        xlim_def = 0:dps:newmax;
        
        if ~exist(Path, 'dir')
            mkdir(Path)
        end
        
        detfl = 0;
        
        if detfl == 1
        deterdata = readmatrix('data/Szeged_data_determ.csv');
        deterdata(:,end) = []; % 1->infected 2->newexposed 3->I56(Rh) 4->R 5->D 6->newD 7->S 8->exposed  9->R0 10->Rc
        end
        
        FIGH = figure('Name','Plots1_tr','NumberTitle','off','Position',get(0,'Screensize'));
        
        subplot(1,2,1)
        hold on
        for i = 1 : length(output)
            funplot(av_mu*output(i).tracer.average.av,av_mu*output(i).tracer.average.std,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        if detfl == 1
        plot(deterdata(:,10),'Color',[0.6350 0.0780 0.1840],'LineWidth',1.5,'DisplayName','Deterministic')
        end
        hold off
        grid on
        grid minor
        xlim([0 length(output(1).tracer.average.av)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel('No. of infection events')
        title('Average infection tracing time series')
        legend('Location','best')
        
        subplot(1,2,2)
        hold on
        for i = 1 : length(output)
            funplot(av_mu*output(i).tracer.maximum.av,av_mu*output(i).tracer.maximum.std,colors(i,:),w,scenarionames{i})
        end
        for i = 1 : measdim
            xline(Measures{i,2},'--',Measures{i,1},'HandleVisibility','off');
        end
        hold off
        grid on
        grid minor
        xlim([0 length(output(1).tracer.average.av)-1])
        ylim([0 inf])
        xlabel('Time [Days]')
        xticks(xlim_def)
        dateaxis('x',2,StartDate)
        xtickangle(angle)
        ylabel('No. of infection events')
        title('Maximum infection tracing time series')
        legend('Location','best')
        
        sgtitle(append('Infection tracing time series (',Title,')'))
        
        F = getframe(FIGH);
        mkdir(append(Path,'/ctr'))
        imwrite(F.cdata,append(Path,'/ctr/ctr-1.jpg'),'jpg')
        savefig(append(Path,'/ctr/z_ctr-1.fig'))
        
        for i = 1 : length(output)
            FIGH = figure('Name',append('Plots',num2str(i+1),'_tr'),'NumberTitle','off','Position',get(0,'Screensize'));
            histogram('BinCounts',output(i).r0fun.eloszlas,'BinEdges',output(i).r0fun.eloszlasX)
            grid on
            grid minor
            xlabel('No. of infection events')
            ylabel('Counts')
            set(gca,'YScale','log')
            title(append('Mean infection event distribution of the ',scenarionames{i},' scenario'))
            F = getframe(FIGH);
            imwrite(F.cdata,append(Path,'/std/std-',num2str(i+1),'.jpg'),'jpg')
            savefig(append(Path,'/std/z_std-',num2str(i+1),'.fig'))
        end
        
        output = output.r0fun;
        atadas = output;
        output = [];
        output.r0 = atadas.r0;
        output.r0mod = atadas.r0mod;

        fprintf(append("Contact tracing input successfully processed!\n"))
        
    elseif flag == 0
        fprintf("Contact tracing input processing was not requested!\n")
        output = 'Contact tracing input processing was not requested!';
    else
        fprintf("You used something other than 0 or 1 for a binary flag!\n")
        output = 'Contact tracing input processing was not requested!';
    end
    
end