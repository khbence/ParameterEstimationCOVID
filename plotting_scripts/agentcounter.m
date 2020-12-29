function count = agentcounter(input)

    AgentStat = statreadprocfun(input);

    N = length(AgentStat);

    % Age:
    
    Agevec = [0 1 2 3 4 5 6 7 8 9];
    
    Agemat = zeros(10);
    
    for i = 1 : 10
        Agemat(i,:) = (i-1)*10 + Agevec;
    end
    
    Age_counter = zeros(10,1);
    
    for i = 1 : N
        for j = 1 : 10
            if sum(AgentStat(i).age == Agemat(j,:)) ~= 0
                Age_counter(j) = Age_counter(j) + 1;
            end
        end 
    end
    
    count.age = Age_counter;
    
    % Precond:
    
    Precond_counter = zeros(5,1);
    
    for i = 1 : N
        if AgentStat(i).precond == '1'
            Precond_counter(2) = Precond_counter(2) + 1;
        elseif AgentStat(i).precond == '2'
            Precond_counter(3) = Precond_counter(3) + 1;
        elseif AgentStat(i).precond == '3'
            Precond_counter(4) = Precond_counter(4) + 1;
        elseif AgentStat(i).precond == '4'
            Precond_counter(5) = Precond_counter(5) + 1;
        else
            Precond_counter(1) = Precond_counter(1) + 1;
        end
    end
    
    count.precond = Precond_counter;
    
    % Sex:
    
    Sex_counter = zeros(2,1);
    
    for i = 1 : N
        if AgentStat(i).sex == 'F'
            Sex_counter(1) = Sex_counter(1) + 1;
        else
            Sex_counter(2) = Sex_counter(2) + 1;
        end
    end
    
    count.sex = Sex_counter;
    
    % Agent type:
    
    Agenttype_counter = zeros(9,1);
    
    for i = 1 : N
        Agenttype_counter(AgentStat(i).type) = Agenttype_counter(AgentStat(i).type) + 1;
    end
    
    count.agenttype = Agenttype_counter;
    
    % Worst state:
    
    D1 = zeros(N,1);
    D2 = zeros(N,1);
    E = zeros(N,1);
    I1 = zeros(N,1);
    I2 = zeros(N,1);
    I3 = zeros(N,1);
    I4 = zeros(N,1);
    I5 = zeros(N,1);
    I6 = zeros(N,1);
    for i = 1 : N
        D1(i) = strcmp(AgentStat(i).worstState_name,'D1');
        D2(i) = strcmp(AgentStat(i).worstState_name,'D2');
        E(i) = strcmp(AgentStat(i).worstState_name,'E');
        I1(i) = strcmp(AgentStat(i).worstState_name,'I1');
        I2(i) = strcmp(AgentStat(i).worstState_name,'I2');
        I3(i) = strcmp(AgentStat(i).worstState_name,'I3');
        I4(i) = strcmp(AgentStat(i).worstState_name,'I4');
        I5(i) = strcmp(AgentStat(i).worstState_name,'I5_hospital');
        I6(i) = strcmp(AgentStat(i).worstState_name,'I6_hospital');
    end
    
    D1 = sum(D1);
    D2 = sum(D2);
    E = sum(E);
    I1 = sum(I1);
    I2 = sum(I2);
    I3 = sum(I3);
    I4 = sum(I4);
    I5 = sum(I5);
    I6 = sum(I6);
    
    Worststate_counter = [D1;D2;E;I1;I2;I3;I4;I5;I6];
    
    count.worststate = Worststate_counter;
    
    % Location type:
    
    Locationtype_counter = zeros(17,1);
    
    for i = 1 : N
        if AgentStat(i).loc_type ~= 22 && AgentStat(i).loc_type ~= 33 && AgentStat(i).loc_type ~= 44 && AgentStat(i).loc_type ~= -1 && AgentStat(i).loc_type ~= 0
            Locationtype_counter(AgentStat(i).loc_type) = Locationtype_counter(AgentStat(i).loc_type) + 1;
        elseif AgentStat(i).loc_type == 22 && AgentStat(i).loc_type ~= 33 && AgentStat(i).loc_type ~= 44 && AgentStat(i).loc_type ~= -1 && AgentStat(i).loc_type ~= 0
            Locationtype_counter(15) = Locationtype_counter(15) + 1;
        elseif AgentStat(i).loc_type ~= 22 && AgentStat(i).loc_type == 33 && AgentStat(i).loc_type ~= 44 && AgentStat(i).loc_type ~= -1 && AgentStat(i).loc_type ~= 0
            Locationtype_counter(16) = Locationtype_counter(16) + 1;
        elseif AgentStat(i).loc_type ~= 22 && AgentStat(i).loc_type ~= 33 && AgentStat(i).loc_type == 44 && AgentStat(i).loc_type ~= -1 && AgentStat(i).loc_type ~= 0
            Locationtype_counter(17) = Locationtype_counter(17) + 1;
        else
            
        end
    end
    
    count.locationtype = Locationtype_counter;
    
    % Infection number (time-dependent):
    
    var = zeros(length(AgentStat),1);
    for i = 1 : length(AgentStat)
        var(i) = AgentStat(i).infectionTime;
    end
    
    seg = var < 10000;
    
    seg = seg.*var;
    seg = max(seg);
    seg = round(seg);
    
    Infection_counter_t = zeros(seg+1,1);
    
    for i = 1 : N
        if AgentStat(i).infectionTime < 10000
            Infection_counter_t(double(int64(AgentStat(i).infectionTime))+1) = Infection_counter_t(double(int64(AgentStat(i).infectionTime))+1) + 1;
        end
    end
    
    count.infectiontimes = Infection_counter_t;
    
    % Infection number:
    
    count.infections = [N; 185386-N];
    
    % Diagnosis number (time-dependent):

    var = zeros(length(AgentStat),1);
    for i = 1 : length(AgentStat)
        var(i) = AgentStat(i).diagnosisTime;
    end
    
    seg = var;
    seg = max(seg);
    seg = round(seg);
    
    Diagnosis_counter_t = zeros(seg,1);
    
    for i = 1 : N
        if AgentStat(i).diagnosisTime ~= 0
            Diagnosis_counter_t(double(int64(AgentStat(i).diagnosisTime))) = Diagnosis_counter_t(double(int64(AgentStat(i).diagnosisTime))) + 1;
        end
    end
    
    count.diagnosistimes = [0;Diagnosis_counter_t];
    
    % Diagnosis number:
    
    var = sum(Diagnosis_counter_t);
    
    count.diagnosises = [var; N-var];

    % Precondition halál összefüggés:
    
    
    
    
end