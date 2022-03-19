function output = fun_std_import(file)

    output = readtable(file);

    output = output(1:end-2,:);

    dims = size(output);

    N = dims(1);
    M = dims(2);

    temp = zeros(dims(1),32);

   
    for j = 1 : M
        if j ~= 20 && j ~= 27
                temp(:,j) = output{:,j};
        else
            if j == 20
                if iscell(output{1,20})
                    for i = 1 : N
                        seg = str2double(split(output{i,20}{1},','));
                        temp(i,j) = seg(1);
                        if length(seg)>1
                            temp(i,33) = seg(2);
                        end
                        if length(seg)>2
                            temp(i,34) = seg(3);
                        end
                        if length(seg)>3
                            temp(i,35) = seg(4);
                        end
                    end
                else
                    temp(:,j) = output{:,j};
                    temp(:,33) = 0;
                    temp(:,34) = 0;
                    temp(:,35) = 0;
                end
            elseif j == 27
                if iscell(output{1,27})
                    for i = 1 : N
                        seg = str2double(split(output{i,27}{1},','));
                        temp(i,j) = seg(1);
                        if length(seg)>1
                            temp(i,30) = seg(2);
                        end
                        if length(seg)>2
                            temp(i,31) = seg(3);
                        end
                        if length(seg)>3
                            temp(i,32) = seg(4);
                        end
                    end
                else
                    temp(:,j) = output{:,j};
                    temp(:,30) = 0;
                    temp(:,31) = 0;
                    temp(:,32) = 0;
                end
            end
        end
    end

    output = temp;

end