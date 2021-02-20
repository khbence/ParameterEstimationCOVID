function output = fun_tr_contactr0fun(inflist,agentstat)
    
    var = zeros(length(agentstat),1);
    for i = 1 : length(agentstat)
        
        var(i) = agentstat(i).ID;
        
    end
    
    var(:,2) = 0;
    
    for i = 1 : length(inflist)
        
        dim1 = size(inflist{i,2});
        dim1 = dim1(1);
        
        for j = 1 : dim1
            
            seged = inflist{i,2}{j,3};
            hossz = length(seged);
            infnum = length(inflist{i,2}{j,2});

            for k = 1 : hossz

                var(find(var(:,1) == seged(k)),2) = var(find(var(:,1) == seged(k)),2) + (infnum/hossz);

            end
            
        end
        
    end

    output.eloszlas = var;
    output.r0 = mean(var(:,2));
    
    summer = 0;
    iterer = 0;
    
    for i = 1 : length(var)
        if var(i,2) ~= 0
            summer = summer + var(i,2);
            iterer = iterer + 1;
        end
    end
    
    output.r0mod = summer/iterer;
    
end