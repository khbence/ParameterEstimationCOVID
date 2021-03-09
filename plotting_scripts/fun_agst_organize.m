function [output,agents,itbool] = fun_agst_organize(samplenames,agents,clog,LocMap,interval)

    N = length(samplenames);
    
    finvar = [];
    itbool = [];
    
    for i = 1 : N
        
        finvar_seged = fun_agst_process(samplenames{i},agents,clog,LocMap,interval);
        
        if sum(finvar_seged.av.age) ~= 0
            finvar = [finvar finvar_seged];
            itbool = [itbool 1];
        else
            itbool = [itbool 0];
        end
        
    end
    
    N = length(finvar);
    
    for i = 1 : N
        
        fin_var_re.av.age(i,:) = finvar(i).av.age;
        fin_var_re.av.precond(i,:) = finvar(i).av.precond;
        fin_var_re.av.sex(i,:) = finvar(i).av.sex;
        fin_var_re.av.agenttype(i,:) = finvar(i).av.agenttype;
        fin_var_re.av.worststate(i,:) = finvar(i).av.worststate;
        fin_var_re.av.locationtype(i,:) = finvar(i).av.locationtype;
        fin_var_re.av.infections(i,:) = finvar(i).av.infections;
        fin_var_re.av.diagnoses(i,:) = finvar(i).av.diagnoses;
        fin_var_re.std.age(i,:) = finvar(i).std.age;
        fin_var_re.std.precond(i,:) = finvar(i).std.precond;
        fin_var_re.std.sex(i,:) = finvar(i).std.sex;
        fin_var_re.std.agenttype(i,:) = finvar(i).std.agenttype;
        fin_var_re.std.worststate(i,:) = finvar(i).std.worststate;
        fin_var_re.std.locationtype(i,:) = finvar(i).std.locationtype;
        fin_var_re.std.infections(i,:) = finvar(i).std.infections;
        fin_var_re.std.diagnoses(i,:) = finvar(i).std.diagnoses;
        
    end
    
    existbool = exist('fin_var_re','var');
    
    if existbool
        output = fin_var_re;
    else
        output = 0;
    end

end