function output = traceprocess(samplename,samplename2,agents,locations)

    list = dir(append(string(samplename),'*'));
    list = (extractfield(list,'name'))';
    list = string(list);
    list = split(list,'_');
    list(:,1:end-1) = [];
    list = str2double(list);

    iter_ar = min(list):max(list);

    list = dir(append(string(samplename2),'*'));
    list = (extractfield(list,'name'))';
    list = string(list);
    list = split(list,'_');
    list(:,1:end-1) = [];
    list = split(list,'.');
    list(:,2) = [];
    list = str2double(list);

    iter_ar2 = min(list):max(list);
    
    struct_ar1 = [];
    struct_ar2 = [];
    
    for i = 1 : length(iter_ar)
        
        seged = dir(append(string(samplename),num2str(iter_ar(i)),'/'));
        seged = seged(3:end);
        seged = (extractfield(seged,'name'))';
        seged = seged(1);
        seged = string(seged);
        seged = split(seged,'.');
        seged = seged(1);
        seged = split(seged,'_');
        seged = seged(1:end-1);
        seged = strjoin(seged,'_');
        seged = append(seged,'_');
        seged = append(string(samplename),num2str(iter_ar(i)),'/',seged);
        
        ip1 = seged;
        ip2 = append(string(samplename2),num2str(iter_ar2(i)),'.json');
        
        struct1 = contactr0fun(ip1,ip2,agents,locations);
        struct2 = contacttracer(ip1,ip2,agents,locations);
        
        struct_ar1 = [struct_ar1 struct1];
        struct_ar2 = [struct_ar2 struct2];
        
    end
    
    output.r0fun = struct_ar1;
    output.tracer = struct_ar2;

end