function output = fun_tr_contacttracer(inflist,agentstat,agents,locations)

    contactdata = fun_tr_contactorganizer(inflist);

    maxday = contactdata{end,3};
    
    averagear = zeros(maxday+1,1);
    maxar = zeros(maxday+1,1);

    AgentStat = fun_agst_statreadprocfun(agentstat,agents,locations);

    tracer = fun_tr_traceinit(AgentStat);

    for i = 0 : maxday
    
        index = fun_tr_indexarcreator(contactdata,i);

        tracer = fun_tr_addnewinf(index,contactdata,tracer);

        tracer = fun_tr_addinfevents(index,contactdata,tracer);

        av = mean(tracer(:,2));
        maxinf = max(tracer(:,2));
        
        averagear(i+1) = av;
        maxar(i+1) = maxinf;

        tracer(:,2) = 0;

        if i ~= maxday
            tracer = fun_tr_deletehealed(AgentStat,tracer,i+1);
        end
    
    end

    output.average = averagear;
    output.maximuminfections = maxar;
    
end