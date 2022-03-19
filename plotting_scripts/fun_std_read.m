function output = fun_std_read(file)

    data = fun_std_import(file);
    
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
    t = data(:,14);
    p1 = data(:,15);
    p2 = data(:,16);
    output.q = data(:,17);
    output.qt = data(:,18);
    output.nq = data(:,19);
    output.mu = data(:,20);
    output.mu2 = data(:,33);
    output.mu3 = data(:,34);
    output.mu4 = data(:,35);
    if size(data,2)<21
        data(:,21) = 0;
    end
    output.ho = data(:,21);
    if size(data,2)<22
        data(:,22) = 0;
    end
    output.vac = data(:,22);
    output.cvac = cumsum(data(:,22));
    
    output.nat = t+p2;
    output.npt = p1+p2;
    output.rpt = funNaNorInferaser((p1+p2)./(t+p2));
    output.sat = cumsum(t+p2);
    output.spt = cumsum(p1+p2);
    output.qni = data(:,17)-data(:,18);
    output.qii = funNaNorInferaser(data(:,18)./(data(:,2)+data(:,3)+data(:,4)+...
                                                data(:,5)+data(:,6)+data(:,7)+data(:,8)));
    output.qiq = funNaNorInferaser(data(:,18)./data(:,17));
    
    disu = diff(data(:,1));
    output.disu = [disu;0];
    dirt = diff(data(:,10));
    output.dirt = [dirt;0];
    dirh = diff(data(:,9));
    output.dirh = [dirh;0];
    didc = diff(data(:,11));
    output.didc = [didc;0];
    dido = diff(data(:,12));
    output.dido = [dido;0];
    if size(data,2)<23
        data(:,23) = 0;
    end
    output.ne = data(:,23);
    
    seged4re = zeros(length(data),1);
    windowvar = 9;
    for i = 11 : length(data)-9 % sum(E(10:19))/sum(E(1:9))
        iteratorvar = data(:,23);
        seged4re(i) = sum((iteratorvar(i:i+9))/(sum(iteratorvar(i-10:i-1))));
    end
    output.re = funNaNorInferaser(seged4re);
    
    output.spec1 = funNaNorInferaser((t+p2)/(179500/100));
    output.spec2 = funNaNorInferaser((data(:,18)./(data(:,2)+data(:,3)+data(:,4)+...
                                      data(:,5)+data(:,6)+data(:,7)+data(:,8)))*100);

    output.INF = data(:,24);
    output.RPI = data(:,24)+data(:,25);

    output.boos = data(:,26);

    output.immu1 = data(:,27);
    output.immu2 = data(:,30);
    output.immu3 = data(:,31);
    output.immu4 = data(:,32);
    
    output.hci = data(:,28);
    output.hce = data(:,29);

    % CSV data points
    
    output.CSVdm = data(end,11);
    output.CSVkm = max(data(:,7)+data(:,8)+data(:,9));
    output.CSVko = sum(data(:,7)+data(:,8)+data(:,9));
    output.CSVim = max(data(:,8));
    output.CSVio = sum(data(:,8));
    segvar = data(:,7)+data(:,8)+data(:,9);
    segvar = segvar(segvar>200);
    segvar = segvar-200;
    output.CSVki = sum(segvar);

end
