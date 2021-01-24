function output = tracepostprocess(tr_ip,agst_ip,agents,locations)

    var = traceorganize(tr_ip,agst_ip,agents,locations);
    
    N = length(var);
    M = length(var(1).tracer);
    max = 0;

    for i = 1 : N
        for j = 1 : M
            if length(var(i).tracer(j).average) > max
                max = length(var(i).tracer(j).average);
            end
        end
    end
    
    for i = 1 : N
        for j = 1 : M
            if length(var(i).tracer(j).average) ~= max
                var(i).tracer(j).average(end+1:max) = 0;
                var(i).tracer(j).maximuminfections(end+1:max) = 0;
            end
        end
    end
    
    output = var;

end