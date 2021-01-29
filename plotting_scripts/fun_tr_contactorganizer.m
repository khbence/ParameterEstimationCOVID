function output = fun_tr_contactorganizer(input)

    list = dir(append(input,'*'));
    list = (extractfield(list,'name'))';
    list = string(list);
    list = split(list,'_');
    list(:,1:end-1) = [];
    list = split(list,'.');
    list(:,2) = [];
    list = str2double(list);
    list = sort(list);

    cell_ar = cell(length(list),2);

    for i = 1 : length(list)

        cell_ar{i,1} = (((list(i))*10)/60)/24;

        var = fun_tr_reader(append(input,num2str(list(i)),'.txt'));

        cell_ar{i,2} = var;

    end
    
    for i = 1 : length(cell_ar)
    
        cell_ar{i,3} = fun_tr_cutter(cell_ar{i,1});
    
    end
    
    output = cell_ar;

end