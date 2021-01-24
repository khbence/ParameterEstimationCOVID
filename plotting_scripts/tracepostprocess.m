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
    
    seged_av = zeros(max,M);
    seged_max = zeros(max,M);
    
    for i = 1 : N
        for j = 1 : M
            seged_av(:,j) = var(i).tracer(j).average;
            seged_max(:,j) = var(i).tracer(j).maximuminfections;
        end
        var2(i).tracer.average.av = mean(seged_av,2);
        var2(i).tracer.average.std = std(seged_av,0,2);
        var2(i).tracer.maximum.av = mean(seged_max,2);
        var2(i).tracer.maximum.std = std(seged_max,0,2);
        var2(i).r0fun = var(i).r0fun;
    end
    
    output = var2;

end