function output = contacttracer(inflist,agentstat)

    contactdata = contactorganizer(inflist);

    maxday = contactdata{end,3};
    
    averagear = zeros(maxday+1,1);
    maxar = zeros(maxday+1,1);

    AgentStat = statreadprocfun(agentstat);

    tracer = traceinit(AgentStat);

    for i = 0 : maxday
    
        index = indexarcreator(contactdata,i);

        tracer = addnewinf(index,contactdata,tracer);

        tracer = addinfevents(index,contactdata,tracer);

        av = mean(tracer(:,2));
        maxinf = max(tracer(:,2));
        
        averagear(i+1) = av;
        maxar(i+1) = maxinf;

        tracer(:,2) = 0;

        if i ~= maxday
            tracer = deletehealed(AgentStat,tracer,i+1);
        end
    
    end

    output.average = averagear;
    output.maximuminfections = maxar;
    
end