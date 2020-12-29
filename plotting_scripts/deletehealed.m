function output = deletehealed(AgentStat,tracer,day)

    vartracer = tracer(:,1);
    
    var = zeros(length(AgentStat),3);
    for i = 1 : length(AgentStat)
        var(i,1) = AgentStat(i).ID;
        var(i,2) = AgentStat(i).infectionTime;
        var(i,3) = AgentStat(i).worstState_end;
    end
    
    for i = 1 : length(vartracer)
        
        seged = find(vartracer(i) == var(:,1));
        
        if var(seged,3) == day
            
            seged2 = find(vartracer(i) == tracer(:,1));
            tracer(seged2,:) = [];
            
        end
        
    end
    
    output = tracer;

end