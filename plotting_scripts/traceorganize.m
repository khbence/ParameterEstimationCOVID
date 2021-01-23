function output = traceorganize(tr_ip,agst_ip,agents,locations)

    N = length(tr_ip);
    
    struct_ar = [];
    
    for i = 1 : N
        
        struct_ar = [struct_ar traceprocess(tr_ip(i),agst_ip(i),agents,locations)];
        
    end
    
    output = struct_ar;

end