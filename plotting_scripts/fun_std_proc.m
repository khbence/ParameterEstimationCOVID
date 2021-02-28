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
    
    [av, stdev] = fun_std_avdev(input,norm,{'t'});
    
    average.t = av;
    standev.t = stdev;
    
    [av, stdev] = fun_std_avdev(input,norm,{'p1'});
    
    average.p1 = av;
    standev.p1 = stdev;
    
    [av, stdev] = fun_std_avdev(input,norm,{'p2'});
    
    average.p2 = av;
    standev.p2 = stdev;
    
    [av, stdev] = fun_std_avdev(input,norm,{'q'});
    
    average.q = av;
    standev.q = stdev;
    
    [av, stdev] = fun_std_avdev(input,norm,{'qt'});
    
    average.qt = av;
    standev.qt = stdev;
    
    [av, stdev] = fun_std_avdev(input,norm,{'nq'});
    
    average.nq = av;
    standev.nq = stdev;
    
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
    
end