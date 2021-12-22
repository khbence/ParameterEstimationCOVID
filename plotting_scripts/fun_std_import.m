function output = fun_std_import(file)

    output = readtable(file);

    output = output(1:end-2,:);

    dims = size(output);

    N = dims(1);
    M = dims(2);

    temp = zeros(dims(1),32);

    for i = 1 : N
        for j = 1 : M
            if j ~= 20 && j ~= 27
                temp(i,j) = output{i,j};
            elseif j == 20
                seg = str2double(split(output{i,20}{1},','));
                temp(i,j) = seg(1);
                temp(i,31) = seg(2);
                temp(i,32) = seg(3);
            elseif j == 27
                seg = str2double(split(output{i,27}{1},','));
                temp(i,j) = seg(1);
                temp(i,28) = seg(2);
                temp(i,29) = seg(3);
                temp(i,30) = seg(4);
            end
        end
    end

    output = temp;

end