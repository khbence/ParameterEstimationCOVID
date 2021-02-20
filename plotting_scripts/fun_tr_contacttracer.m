function output = fun_tr_contacttracer(inflist,agentstat)

    maxday = inflist{end,3};
    
    averagear = zeros(maxday+1,1);
    maxar = zeros(maxday+1,1);

    tracer = fun_tr_traceinit(agentstat);

    for i = 0 : maxday
    
        index = fun_tr_indexarcreator(inflist,i);

        tracer = fun_tr_addinfevents(index,inflist,tracer);

        av = mean(tracer(:,2));
        maxinf = max(tracer(:,2));
        
        averagear(i+1) = av;
        maxar(i+1) = maxinf;

        tracer(:,2) = 0;
        
        tracer = fun_tr_addnewinf(index,inflist,tracer);

        if i ~= maxday
            tracer = fun_tr_deletehealed(agentstat,tracer,i+1);
        end
    
    end

    output.average = averagear;
    output.maximuminfections = maxar;
    
end