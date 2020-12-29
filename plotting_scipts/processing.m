function [average, standev] = processing(samplename)
    
    list = dir(append(samplename,'*'));
    list = (extractfield(list,'name'))';
    list = string(list);
    list = split(list,'_');
    list(:,1:end-1) = [];
    list = split(list,'.');
    list(:,2) = [];
    list = str2double(list);

    iter_ar = min(list):max(list);
    
    struct_ar = [];

    for i = 1 : length(iter_ar)

        struct_ar = [struct_ar funread(append(samplename,num2str(iter_ar(i)),'.txt'))];
        
    end
    
    [average, standev] = funproc(struct_ar);

end