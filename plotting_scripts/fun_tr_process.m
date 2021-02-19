function output = fun_tr_process(samplename,samplename2,agents,locations)

    list = dir(append(string(samplename),'*'));
    list = (extractfield(list,'name'))';
    list = string(list);
    list = split(list,'_');
    list(:,1:end-1) = [];
    list = str2double(list);

    list2 = dir(append(string(samplename2),'*'));
    list2 = (extractfield(list2,'name'))';
    list2 = string(list2);
    list2 = split(list2,'_');
    list2(:,1:end-1) = [];
    list2 = split(list2,'.');
    list2(:,2) = [];
    list2 = str2double(list2);
    
    struct_ar1 = [];
    struct_ar2 = [];
    
    for i = 1 : length(list)
        
        seged = dir(append(string(samplename),num2str(list(i)),'/'));
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
        seged = append(string(samplename),num2str(list(i)),'/',seged);
        
        ip1 = seged;
        ip2 = append(string(samplename2),num2str(list2(i)),'.json');
        
        struct1 = fun_tr_contactr0fun(ip1,ip2,agents,locations);
        struct2 = fun_tr_contacttracer(ip1,ip2,agents,locations);
        
        struct_ar1 = [struct_ar1 struct1];
        struct_ar2 = [struct_ar2 struct2];
        
    end
    
    output.r0fun = struct_ar1;
    output.tracer = struct_ar2;

end