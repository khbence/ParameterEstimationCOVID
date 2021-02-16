function output = fun_plotter_tr(tr_ip,agst_ip,scenarionames,Title,Measures,StartDate,flag)

    if flag == 1
        
        av_mu = 1;
        
        w = 1.5;
        
        measdim = size(Measures);
        measdim = measdim(1);

        colors = [[1 0 0];[0 1 0];[0 0 1];[0 0 0];[1 0 1];[0 1 1];[0 0.4470 0.7410];[0.9290 0.6940 0.1250]];
        
        locations = jsondecode(fileread('locations0.json'));
        locations = locations.places;
        agents = jsondecode(fileread('agents0.json'));
        agents = agents.people;
        
        output = fun_tr_postprocess(tr_ip,agst_ip,agents,locations);
        
        figure('Name','Plots1_tr','NumberTitle','off')
        
        subplot(1,2,1)
        hold on
        for i = 1 : length(output)
            funplot(av_mu*output(i).tracer.average.av,av_mu*output(i).tracer.average.std,colors(i,:),w,scenarionames{i})
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
        dateaxis('x',2,StartDate)
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
        dateaxis('x',2,StartDate)
        ylabel('No. of infection events')
        title('Maximum infection tracing time series')
        legend('Location','best')
        
        sgtitle(append('Infection tracing time series (',Title,')'))

        fprintf(append("Contact tracing input successfully processed!\n"))
        
    elseif flag == 0
        fprintf("Contact tracing input processing was not requested!\n")
        output = 'Contact tracing input processing was not requested!';
    else
        fprintf("You used something other than 0 or 1 for a binary flag!\n")
        output = 'Contact tracing input processing was not requested!';
    end
    
end