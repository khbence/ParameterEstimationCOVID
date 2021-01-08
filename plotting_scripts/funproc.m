function [average, standev] = funproc(input)
    
    norm = 0;

    [av, stdev] = funavdev(input,norm,{'s'});
    
    average.s = av;
    standev.s = stdev;
    
    [av, stdev] = funavdev(input,norm,{'e'});
    
    average.e = av;
    standev.e = stdev;
    
    [av, stdev] = funavdev(input,norm,{'i1','i2','i3','i4','i5','i6'});
    
    average.i = av;
    standev.i = stdev;
    
    [av, stdev] = funavdev(input,norm,{'e','i1','i2','i3','i4','i5','i6'});
    
    average.ei = av;
    standev.ei = stdev;
    
    [av, stdev] = funavdev(input,norm,{'rh','r'});
    
    average.r = av;
    standev.r = stdev;
    
    [av, stdev] = funavdev(input,norm,{'dc'});
    
    average.d = av;
    standev.d = stdev;
    
    [av, stdev] = funavdev(input,norm,{'i5','i6'});
    
    average.k = av;
    standev.k = stdev;
    
    [av, stdev] = funavdev(input,norm,{'i5','i6','rh'});
    
    average.kt = av;
    standev.kt = stdev;
    
    [av, stdev] = funavdev(input,norm,{'i5','i6','rh','h'});
    
    average.ktnc = av;
    standev.ktnc = stdev;
    
    [av, stdev] = funavdev(input,norm,{'i6'});
    
    average.i6 = av;
    standev.i6 = stdev;
    
    [av, stdev] = funavdev(input,norm,{'t'});
    
    average.t = av;
    standev.t = stdev;
    
    [av, stdev] = funavdev(input,norm,{'p1'});
    
    average.p1 = av;
    standev.p1 = stdev;
    
    [av, stdev] = funavdev(input,norm,{'p2'});
    
    average.p2 = av;
    standev.p2 = stdev;
    
    [av, stdev] = funavdev(input,norm,{'q'});
    
    average.q = av;
    standev.q = stdev;
    
    [av, stdev] = funavdev(input,norm,{'qt'});
    
    average.qt = av;
    standev.qt = stdev;
    
    [av, stdev] = funavdev(input,norm,{'nq'});
    
    average.nq = av;
    standev.nq = stdev;
    
    [av, stdev] = funavdev(input,norm,{'do'});
    
    average.do = av;
    standev.do = stdev;
    
end