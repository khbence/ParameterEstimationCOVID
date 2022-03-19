function [average, standev] = fun_std_proc(input)
    
    norm = 0;

    [av, stdev] = fun_std_avdev(input,norm,{'s'});
    
    average.s = av;
    standev.s = stdev;
    
    [av, stdev] = fun_std_avdev(input,norm,{'e'});
    
    average.e = av;
    standev.e = stdev;
    
    [av, stdev] = fun_std_avdev(input,norm,{'i1','i2','i3','i4','i5','i6'});
    
    average.i = av;
    standev.i = stdev;
    
    [av, stdev] = fun_std_avdev(input,norm,{'e','i1','i2','i3','i4','i5','i6'});
    
    average.ei = av;
    standev.ei = stdev;
    
    [av, stdev] = fun_std_avdev(input,norm,{'rh','r'});
    
    average.r = av;
    standev.r = stdev;
    
    [av, stdev] = fun_std_avdev(input,norm,{'dc'});
    
    average.d = av;
    standev.d = stdev;
    
    [av, stdev] = fun_std_avdev(input,norm,{'i5','i6'});
    
    average.k = av;
    standev.k = stdev;
    
    [av, stdev] = fun_std_avdev(input,norm,{'i5','i6','rh'});
    
    average.kt = av;
    standev.kt = stdev;
    
    [av, stdev] = fun_std_avdev(input,norm,{'i5','i6','rh','h'});
    
    average.ktnc = av;
    standev.ktnc = stdev;
    
    [av, stdev] = fun_std_avdev(input,norm,{'i6'});
    
    average.i6 = av;
    standev.i6 = stdev;
    
    [av, stdev] = fun_std_avdev(input,norm,{'nat'});
    
    average.nat = av;
    standev.nat = stdev;
    
    [av, stdev] = fun_std_avdev(input,norm,{'npt'});
    
    average.npt = av;
    standev.npt = stdev;
    
    [av, stdev] = fun_std_avdev(input,norm,{'rpt'});
    
    average.rpt = av;
    standev.rpt = stdev;
    
    [av, stdev] = fun_std_avdev(input,norm,{'sat'});
    
    average.sat = av;
    standev.sat = stdev;
    
    [av, stdev] = fun_std_avdev(input,norm,{'spt'});
    
    average.spt = av;
    standev.spt = stdev;
    
    [av, stdev] = fun_std_avdev(input,norm,{'q'});
    
    average.q = av;
    standev.q = stdev;
    
    [av, stdev] = fun_std_avdev(input,norm,{'qt'});
    
    average.qt = av;
    standev.qt = stdev;
    
    [av, stdev] = fun_std_avdev(input,norm,{'nq'});
    
    average.nq = av;
    standev.nq = stdev;
    
    [av, stdev] = fun_std_avdev(input,norm,{'qni'});
    
    average.qni = av;
    standev.qni = stdev;
    
    [av, stdev] = fun_std_avdev(input,norm,{'do'});
    
    average.do = av;
    standev.do = stdev;
    
    [av, stdev] = fun_std_avdev(input,norm,{'h'});
    
    average.h = av;
    standev.h = stdev;
    
    [av, stdev] = fun_std_avdev(input,norm,{'mu'});
    
    average.mu = av;
    standev.mu = stdev;

    [av, stdev] = fun_std_avdev(input,norm,{'mu2'});
    
    average.mu2 = av;
    standev.mu2 = stdev;

    [av, stdev] = fun_std_avdev(input,norm,{'mu3'});
    
    average.mu3 = av;
    standev.mu3 = stdev;
    
    [av, stdev] = fun_std_avdev(input,norm,{'mu4'});
    
    average.mu4 = av;
    standev.mu4 = stdev;

    [av, stdev] = fun_std_avdev(input,norm,{'boos'});
    
    average.boos = av;
    standev.boos = stdev;

    [av, stdev] = fun_std_avdev(input,norm,{'INF'});
    
    average.INF = av;
    standev.INF = stdev;

    [av, stdev] = fun_std_avdev(input,norm,{'RPI'});
    
    average.RPI = av;
    standev.RPI = stdev;
    
    [av, stdev] = fun_std_avdev(input,norm,{'vac'});
    
    average.vac = av;
    standev.vac = stdev;
    
    [av, stdev] = fun_std_avdev(input,norm,{'cvac'});
    
    average.cvac = av;
    standev.cvac = stdev;
    
    [av, stdev] = fun_std_avdev(input,norm,{'immu1'});
    
    average.immu1 = av;
    standev.immu1 = stdev;

    [av, stdev] = fun_std_avdev(input,norm,{'immu2'});
    
    average.immu2 = av;
    standev.immu2 = stdev;

    [av, stdev] = fun_std_avdev(input,norm,{'immu3'});
    
    average.immu3 = av;
    standev.immu3 = stdev;

    [av, stdev] = fun_std_avdev(input,norm,{'immu4'});
    
    average.immu4 = av;
    standev.immu4 = stdev;

    [av, stdev] = fun_std_avdev(input,norm,{'disu'});
    
    average.disu = av;
    standev.disu = stdev;
    
    [av, stdev] = fun_std_avdev(input,norm,{'didc'});
    
    average.didc = av;
    standev.didc = stdev;
    
    [av, stdev] = fun_std_avdev(input,norm,{'dido'});
    
    average.dido = av;
    standev.dido = stdev;
    
    [av, stdev] = fun_std_avdev(input,norm,{'dirt','dirh'});
    
    average.dirt = av;
    standev.dirt = stdev;
    
    [av, stdev] = fun_std_avdev(input,norm,{'ne'});
    
    average.ne = av;
    standev.ne = stdev;
    
    [av, stdev] = fun_std_avdev(input,norm,{'re'});
    
    average.re = av;
    standev.re = stdev;
    
    [av, stdev] = fun_std_avdev(input,norm,{'qii'});
    
    average.qii = av;
    standev.qii = stdev;
    
    [av, stdev] = fun_std_avdev(input,norm,{'qiq'});
    
    average.qiq = av;
    standev.qiq = stdev;
    
    [av, stdev] = fun_std_avdev(input,norm,{'hci'});
    
    average.hci = av;
    standev.hci = stdev;
    
    [av, stdev] = fun_std_avdev(input,norm,{'hce'});
    
    average.hce = av;
    standev.hce = stdev;
    
    [av, stdev] = fun_std_avdev(input,norm,{'spec1'});
    
    average.spec1 = mean(av(11:end));
    standev.spec1 = mean(stdev(11:end));
    
    [av, stdev] = fun_std_avdev(input,norm,{'spec2'});
    
    average.spec2 = mean(av(11:end));
    standev.spec2 = mean(stdev(11:end));
    
    segvar = extractfield(input,'CSVdm');
    av = mean(segvar);
    stdev = std(segvar,norm);
    
    average.CSVdm = av;
    standev.CSVdm = stdev;
    
    segvar = extractfield(input,'CSVkm');
    av = mean(segvar);
    stdev = std(segvar,norm);
    
    average.CSVkm = av;
    standev.CSVkm = stdev;
    
    segvar = extractfield(input,'CSVko');
    av = mean(segvar);
    stdev = std(segvar,norm);
    
    average.CSVko = av;
    standev.CSVko = stdev;
    
    segvar = extractfield(input,'CSVim');
    av = mean(segvar);
    stdev = std(segvar,norm);
    
    average.CSVim = av;
    standev.CSVim = stdev;
    
    segvar = extractfield(input,'CSVio');
    av = mean(segvar);
    stdev = std(segvar,norm);
    
    average.CSVio = av;
    standev.CSVio = stdev;
    
    segvar = extractfield(input,'CSVki');
    av = mean(segvar);
    stdev = std(segvar,norm);
    
    average.CSVki = av;
    standev.CSVki = stdev;
    
end
