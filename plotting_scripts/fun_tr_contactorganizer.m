function output = fun_tr_contactorganizer(input)

    input2 = split(input,'_');
    input2(end-1) = 'v1';
    input2 = strjoin(input2,'_');

    list = dir(append(input,'*'));
    list = (extractfield(list,'name'))';
    list = string(list);
    list = split(list,'_');
    list(:,1:end-1) = [];
    list = split(list,'.');
    list(:,2) = [];
    list = str2double(list);
    list = sort(list);

    cell_ar = cell(length(list),3);

    for i = 1 : length(list)

        cell_ar{i,1} = (((list(i))*10)/60)/24;

        var = fun_tr_reader(append(input,num2str(list(i)),'.txt'));

        cell_ar{i,2} = var;
        
        cell_ar{i,3} = funcutter(cell_ar{i,1});

    end
    
    list2 = dir(append(input2,'*'));
    list2 = (extractfield(list2,'name'))';
    list2 = string(list2);
    list2 = split(list2,'_');
    list2(:,1:end-1) = [];
    list2 = split(list2,'.');
    list2(:,2) = [];
    list2 = str2double(list2);
    list2 = sort(list2);

    cell_ar2 = cell(length(list2),3);

    for i = 1 : length(list2)

        cell_ar2{i,1} = (((list2(i))*10)/60)/24;

        var2 = fun_tr_reader(append(input2,num2str(list2(i)),'.txt'));

        cell_ar2{i,2} = var2;
        
        cell_ar2{i,3} = funcutter(cell_ar2{i,1});

    end
    
    cell_ar = [cell_ar;cell_ar2];
    cell_ar = sortrows(cell_ar,1);
    
    output = cell_ar;

end