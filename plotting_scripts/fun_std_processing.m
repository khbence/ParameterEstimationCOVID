function [average, standev] = fun_std_processing(samplename)
    
    list = dir(append(samplename,'*'));
    list = (extractfield(list,'name'))';
    list = string(list);
    list = split(list,'_');
    list(:,1:end-1) = [];
    list = split(list,'.');
    list(:,2) = [];
    list = str2double(list);
    
    struct_ar = [];

    for i = 1 : length(list)

        struct_ar = [struct_ar fun_std_read(append(samplename,num2str(list(i)),'.txt'))];
        
    end
    
    [average, standev] = fun_std_proc(struct_ar);

end