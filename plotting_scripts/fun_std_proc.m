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
    
    [av, stdev] = fun_std_avdev(input,norm,{'vac'});
    
    average.vac = av;
    standev.vac = stdev;

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
    
end
