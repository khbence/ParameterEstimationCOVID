function [average, standev] = funproc(input)

    N = length(input);
    M = length(input(1).s);
    ip = input;
    
    av = zeros(M,1);
    stdev = zeros(M,1);
    
    norm = 0;


    for i = 1 : M
        
        sum = 0;
        stdev_init = zeros(N,1);
        
        for j = 1 : N
            
            sum = sum + ip(j).s(i);
            stdev_init(j) = ip(j).s(i);
            
        end
        
        av(i) = sum/N;
        stdev(i) = std(stdev_init,norm);
        
    end
    
    average.s = av;
    standev.s = stdev;
    
    for i = 1 : M
        
        sum = 0;
        stdev_init = zeros(N,1);
        
        for j = 1 : N
            
            sum = sum + ip(j).e(i);
            stdev_init(j) = ip(j).e(i);
            
        end
        
        av(i) = sum/N;
        stdev(i) = std(stdev_init,norm);
        
    end
    
    average.e = av;
    standev.e = stdev;
    
    for i = 1 : M
        
        sum = 0;
        stdev_init = zeros(N,1);
        
        for j = 1 : N
            
            sum = sum + (ip(j).i1(i)+ip(j).i2(i)+ip(j).i3(i)+ip(j).i4(i)+ip(j).i5(i)+ip(j).i6(i));
            stdev_init(j) = (ip(j).i1(i)+ip(j).i2(i)+ip(j).i3(i)+ip(j).i4(i)+ip(j).i5(i)+ip(j).i6(i));
            
        end
        
        av(i) = sum/N;
        stdev(i) = std(stdev_init,norm);
        
    end
    
    average.i = av;
    standev.i = stdev;
    
    for i = 1 : M
        
        sum = 0;
        stdev_init = zeros(N,1);
        
        for j = 1 : N
            
            sum = sum + (ip(j).e(i)+ip(j).i1(i)+ip(j).i2(i)+ip(j).i3(i)+ip(j).i4(i)+ip(j).i5(i)+ip(j).i6(i));
            stdev_init(j) = (ip(j).e(i)+ip(j).i1(i)+ip(j).i2(i)+ip(j).i3(i)+ip(j).i4(i)+ip(j).i5(i)+ip(j).i6(i));
            
        end
        
        av(i) = sum/N;
        stdev(i) = std(stdev_init,norm);
        
    end
    
    average.ei = av;
    standev.ei = stdev;
    
    for i = 1 : M
        
        sum = 0;
        stdev_init = zeros(N,1);
            
        for j = 1 : N
                
            sum = sum + (ip(j).rh(i)+ip(j).r(i));
            stdev_init(j) = (ip(j).rh(i)+ip(j).r(i));
                
        end
            
        av(i) = sum/N;
        stdev(i) = std(stdev_init,norm);
            
    end
    
    average.r = av;
    standev.r = stdev;
    
    for i = 1 : M
            
        sum = 0;
        stdev_init = zeros(N,1);
            
        for j = 1 : N
                
            sum = sum + ip(j).dc(i);
            stdev_init(j) = ip(j).dc(i);
            
        end
            
        av(i) = sum/N;
        stdev(i) = std(stdev_init,norm);
            
    end
    
    average.d = av;
    standev.d = stdev;
    
    for i = 1 : M
            
        sum = 0;
        stdev_init = zeros(N,1);
            
        for j = 1 : N
                
            %sum = sum + (ip(j).i5(i)+ip(j).i6(i)+ip(j).rh(i));
            sum = sum + (ip(j).i5(i)+ip(j).i6(i));
            %stdev_init(j) = (ip(j).i5(i)+ip(j).i6(i)+ip(j).rh(i));
            stdev_init(j) = (ip(j).i5(i)+ip(j).i6(i));
            
        end
            
        av(i) = sum/N;
        stdev(i) = std(stdev_init,norm);
            
    end
    
    average.k = av;
    standev.k = stdev;
    
    for i = 1 : M
            
        sum = 0;
        stdev_init = zeros(N,1);
            
        for j = 1 : N
                
            sum = sum + (ip(j).i5(i)+ip(j).i6(i)+ip(j).rh(i));
            stdev_init(j) = (ip(j).i5(i)+ip(j).i6(i)+ip(j).rh(i));
            
        end
            
        av(i) = sum/N;
        stdev(i) = std(stdev_init,norm);
            
    end
    
    average.kt = av;
    standev.kt = stdev;
    
    for i = 1 : M
            
        sum = 0;
        stdev_init = zeros(N,1);
            
        for j = 1 : N
                
            sum = sum + ip(j).i6(i);
            stdev_init(j) = ip(j).i6(i);
            
        end
            
        av(i) = sum/N;
        stdev(i) = std(stdev_init,norm);
            
    end
    
    average.i6 = av;
    standev.i6 = stdev;
    
    for i = 1 : M
        
        sum = 0;
        stdev_init = zeros(N,1);
        
        for j = 1 : N
            
            sum = sum + ip(j).t(i);
            stdev_init(j) = ip(j).t(i);
            
        end
        
        av(i) = sum/N;
        stdev(i) = std(stdev_init,norm);
        
    end
    
    average.t = av;
    standev.t = stdev;
    
    for i = 1 : M
        
        sum = 0;
        stdev_init = zeros(N,1);
        
        for j = 1 : N
            
            sum = sum + ip(j).p1(i);
            stdev_init(j) = ip(j).p1(i);
            
        end
        
        av(i) = sum/N;
        stdev(i) = std(stdev_init,norm);
        
    end
    
    average.p1 = av;
    standev.p1 = stdev;
    
    for i = 1 : M
        
        sum = 0;
        stdev_init = zeros(N,1);
        
        for j = 1 : N
            
            sum = sum + ip(j).p2(i);
            stdev_init(j) = ip(j).p2(i);
            
        end
        
        av(i) = sum/N;
        stdev(i) = std(stdev_init,norm);
        
    end
    
    average.p2 = av;
    standev.p2 = stdev;
    
    for i = 1 : M
        
        sum = 0;
        stdev_init = zeros(N,1);
        
        for j = 1 : N
            
            sum = sum + ip(j).q(i);
            stdev_init(j) = ip(j).q(i);
            
        end
        
        av(i) = sum/N;
        stdev(i) = std(stdev_init,norm);
        
    end
    
    average.q = av;
    standev.q = stdev;
    
    for i = 1 : M
        
        sum = 0;
        stdev_init = zeros(N,1);
        
        for j = 1 : N
            
            sum = sum + ip(j).qt(i);
            stdev_init(j) = ip(j).qt(i);
            
        end
        
        av(i) = sum/N;
        stdev(i) = std(stdev_init,norm);
        
    end
    
    average.qt = av;
    standev.qt = stdev;
    
    for i = 1 : M
        
        sum = 0;
        stdev_init = zeros(N,1);
        
        for j = 1 : N
            
            sum = sum + ip(j).nq(i);
            stdev_init(j) = ip(j).nq(i);
            
        end
        
        av(i) = sum/N;
        stdev(i) = std(stdev_init,norm);
        
    end
    
    average.nq = av;
    standev.nq = stdev;
    
    for i = 1 : M
        
        sum = 0;
        stdev_init = zeros(N,1);
        
        for j = 1 : N
            
            sum = sum + ip(j).do(i);
            stdev_init(j) = ip(j).do(i);
            
        end
        
        av(i) = sum/N;
        stdev(i) = std(stdev_init,norm);
        
    end
    
    average.do = av;
    standev.do = stdev;
    
end