function output = fun_agst_process(samplename,agents,clog,LocMap)

    list = dir(append(samplename,'*'));
    list = (extractfield(list,'name'))';
    list = string(list);
    list = split(list,'_');
    list(:,1:end-1) = [];
    list = split(list,'.');
    list(:,2) = [];
    list = str2double(list);
    
    struct_ar = [];

    for i = 1 : length(list)

        countvar = fun_agst_agentcounter(append(samplename,num2str(list(i)),'.json'),agents,clog,LocMap);
        
        if ~(isequaln(countvar,0))
            struct_ar = [struct_ar countvar];
        end
        
    end
    
    meret = size(struct_ar);
    
    seged_age = [];
    seged_precond = [];
    seged_sex = [];
    seged_agenttype = [];
    seged_worststate = [];
    seged_locationtype = [];
    seged_infections = [];
    seged_diagnoses = [];
    
    if meret(2) ~= 0 && meret(2) ~= 1
        for i = 1 : meret(2)
        
            seged_age = [seged_age struct_ar(i).age];
            seged_precond = [seged_precond struct_ar(i).precond];
            seged_sex = [seged_sex struct_ar(i).sex];
            seged_agenttype = [seged_agenttype struct_ar(i).agenttype];
            seged_worststate = [seged_worststate struct_ar(i).worststate];
            seged_locationtype = [seged_locationtype struct_ar(i).locationtype];
            seged_infections = [seged_infections struct_ar(i).infections];
            seged_diagnoses = [seged_diagnoses struct_ar(i).diagnoses];
            
        end
    
        av_age = mean(seged_age,2);
        std_age = std(seged_age,0,2);
        av_precond = mean(seged_precond,2);
        std_precond = std(seged_precond,0,2);
        av_sex = mean(seged_sex,2);
        std_sex = std(seged_sex,0,2);
        av_agenttype = mean(seged_agenttype,2);
        std_agenttype = std(seged_agenttype,0,2);
        av_worststate = mean(seged_worststate,2);
        std_worststate = std(seged_worststate,0,2);
        av_locationtype = mean(seged_locationtype,2);
        std_locationtype = std(seged_locationtype,0,2);
        av_infections = mean(seged_infections,2);
        std_infections = std(seged_infections,0,2);
        av_diagnoses = mean(seged_diagnoses,2);
        std_diagnoses = std(seged_diagnoses,0,2);

        output.av.age = av_age;
        output.std.age = std_age;
        output.av.precond = av_precond;
        output.std.precond = std_precond;
        output.av.sex = av_sex;
        output.std.sex = std_sex;
        output.av.agenttype = av_agenttype;
        output.std.agenttype = std_agenttype;
        output.av.worststate = av_worststate;
        output.std.worststate = std_worststate;
        output.av.locationtype = av_locationtype;
        output.std.locationtype = std_locationtype;
        output.av.infections = av_infections;
        output.std.infections = std_infections;
        output.av.diagnoses = av_diagnoses;
        output.std.diagnoses = std_diagnoses;
    else
        output.av.age = 0;
        output.std.age = 0;
        output.av.precond = 0;
        output.std.precond = 0;
        output.av.sex = 0;
        output.std.sex = 0;
        output.av.agenttype = 0;
        output.std.agenttype = 0;
        output.av.worststate = 0;
        output.std.worststate = 0;
        output.av.locationtype = 0;
        output.std.locationtype = 0;
        output.av.infections = 0;
        output.std.infections = 0;
        output.av.diagnoses = 0;
        output.std.diagnoses = 0;
    end
end