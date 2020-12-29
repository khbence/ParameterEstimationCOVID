function output = contactr0fun(inflist,agentstat)

    contactdata = contactorganizer(inflist);
    AgentStat = statreadprocfun(agentstat);
    
    var = zeros(length(AgentStat),1);
    for i = 1 : length(AgentStat)
        
        var(i) = AgentStat(i).ID;
        
    end
    
    var(:,2) = 0;
    
    for i = 1 : length(contactdata)
        
        seged = contactdata{i,2}{1,3};
        hossz = length(seged);
        
        for j = 1 : hossz
            
            var(find(var(:,1) == seged(j)),2) = var(find(var(:,1) == seged(j)),2) + (1/hossz);
            
        end
        
    end

    output.eloszlas = var;
    output.r0 = mean(var(:,2));
    
end