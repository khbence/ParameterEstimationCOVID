function output = fun_std_read(file)

    data = readmatrix(file);
    
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
    output.ho = data(:,21);
    output.vac = data(:,22);
    output.cvac = cumsum(data(:,22));
    
    output.nat = t+p2;
    output.npt = p1+p2;
    output.rpt = funNaNeraser((p1+p2)./(t+p2));
    output.sat = cumsum(t+p2);
    output.spt = cumsum(p1+p2);
    output.qni = data(:,17)-data(:,18);
    output.qii = funNaNeraser(data(:,18)./(data(:,2)+data(:,3)+data(:,4)+data(:,5)+data(:,6)+data(:,7)+data(:,8)));
    output.qiq = funNaNeraser(data(:,18)./data(:,17));
    
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
    
    newexposed_seged = data(:,23);
    %newexposed_seged = [newexposed_seged;0];
    alinfected_seged = data(:,2)+data(:,3)+data(:,4)+data(:,5)+data(:,6)+data(:,7)+data(:,8);
    output.ne = newexposed_seged;
    output.re = funNaNeraser(newexposed_seged./alinfected_seged);
    
    output.spec1 = funNaNeraser((t+p2)/(179500/100));
    output.spec2 = funNaNeraser((data(:,18)./(data(:,2)+data(:,3)+data(:,4)+data(:,5)+data(:,6)+data(:,7)+data(:,8)))*100);

end
