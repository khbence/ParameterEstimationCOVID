function output = fun_tr_postprocess(tr_ip,agst_ip,agents,locations)

    var = fun_tr_organize(tr_ip,agst_ip,agents,locations);
    
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
    seged_r0 = zeros(1,M);
    seged_r0mod = zeros(1,M);
    seged_eloszlas = cell(1,M);
    
    for i = 1 : N
        for j = 1 : M
            seged_av(:,j) = var(i).tracer(j).average;
            seged_max(:,j) = var(i).tracer(j).maximuminfections;
            seged_r0(j) = var(i).r0fun(j).r0;
            seged_r0mod(j) = var(i).r0fun(j).r0mod;
            seged_eloszlas{1,j} = var(i).r0fun(j).eloszlas;
        end
        var2(i).tracer.average.av = mean(seged_av,2);
        var2(i).tracer.average.std = std(seged_av,0,2);
        var2(i).tracer.maximum.av = mean(seged_max,2);
        var2(i).tracer.maximum.std = std(seged_max,0,2);
        var2(i).r0fun.eloszlas = seged_eloszlas;
        var2(i).r0fun.r0.av = mean(seged_r0);
        var2(i).r0fun.r0.std = std(seged_r0,0);
        var2(i).r0fun.r0mod.av = mean(seged_r0mod);
        var2(i).r0fun.r0mod.std = std(seged_r0mod,0);
    end
    
    output = var2;

end