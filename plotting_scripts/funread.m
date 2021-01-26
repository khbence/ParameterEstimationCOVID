function output = funread(file)

    data = readmatrix(file);
    % var = data(end-3:end,:);
    %data(end-3:end,:) = [];
    
    [row, col] = find(isnan(data(:,1)));

    for i = 1 : length(row)
        data(row(i),:) = [];
        if i < length(row)
        row(i+1) = row(i+1) - i;
        end
    end
    
    output.s = data(:,1);
    output.e = data(:,2);
    output.i1 = data(:,3);
    output.i2 = data(:,4);
    output.i3 = data(:,5);
    output.i4 = data(:,6);
    output.i5 = data(:,7);
    output.i6 = data(:,8);
    output.rh = data(:,9);
    output.r = data(:,10);
    output.dc = data(:,11);
    output.do = data(:,12);
    output.h = data(:,13);
    output.t = data(:,14);
    output.p1 = data(:,15);
    output.p2 = data(:,16);
    output.q = data(:,17);
    output.qt = data(:,18);
    output.nq = data(:,19);
    output.mu = data(:,20);

end