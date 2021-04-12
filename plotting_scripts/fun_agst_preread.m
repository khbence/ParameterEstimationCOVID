function fun_agst_preread(samplename,agents,locations)

    for i = 1 : length(samplename)

        logicvar = samplename{i};
        logicvar = split(logicvar,'/');
        logicvar(end) = [];
        logicvar = strjoin(logicvar,'/');
        logicvar = append(logicvar,'/*.mat');
        logicvar = dir(logicvar);
        logicvar = length(logicvar);
        
        if ~logicvar
            list = dir(append(samplename{i},'*'));
            list = (extractfield(list,'name'))';
            list = string(list);
            list = split(list,'_');
            list(:,1:end-1) = [];
            list = split(list,'.');
            list(:,2) = [];
            list = str2double(list);

            for j = 1 : length(list)

                fname = append(samplename{i},num2str(list(j)),'.json');
                AgentStat = jsondecode(fileread(fname));
                AgentStat = AgentStat.Statistics;
                
                for k = 1 : length(AgentStat)

                    AgentStat(k).worstState_name = AgentStat(k).worstState.name;
                    AgentStat(k).worstState_begin = AgentStat(k).worstState.begin;
                    AgentStat(k).worstState_end = AgentStat(k).worstState.end;

                    AgentStat(k).type = agents(AgentStat(k).ID+1).typeID;
                    AgentStat(k).precond = agents(AgentStat(k).ID+1).preCond;
                    AgentStat(k).age = agents(AgentStat(k).ID+1).age;
                    AgentStat(k).sex = agents(AgentStat(k).ID+1).sex;

                    if AgentStat(k).InfectionLoc ~= 0
                        AgentStat(k).loc_ID = locations{AgentStat(k).InfectionLoc+1,1}.ID;
                        AgentStat(k).loc_type = locations{AgentStat(k).InfectionLoc+1,1}.type;
                        AgentStat(k).loc_area = locations{AgentStat(k).InfectionLoc+1,1}.area;
                        AgentStat(k).loc_capacity = locations{AgentStat(k).InfectionLoc+1,1}.capacity;
                        AgentStat(k).loc_infectious = locations{AgentStat(k).InfectionLoc+1,1}.infectious;
                        AgentStat(k).loc_age = locations{AgentStat(k).InfectionLoc+1,1}.ageInter;
                        AgentStat(k).loc_coord = locations{AgentStat(k).InfectionLoc+1,1}.coordinates;
                    else
                        AgentStat(k).loc_ID = '-1';
                        AgentStat(k).loc_type = -1;
                        AgentStat(k).loc_area = -1;
                        AgentStat(k).loc_capacity = -1;
                        AgentStat(k).loc_infectious = -1;
                        AgentStat(k).loc_age = [-1;-1];
                        AgentStat(k).loc_coord = [-1;-1];
                    end

                end

                AgentStat = rmfield(AgentStat,'worstState');

                N = length(AgentStat);

                var_infectionTime = ((([AgentStat.infectionTime]')*10)/60)/24;
                var_diagnosisTime = ((([AgentStat.diagnosisTime]')*10)/60)/24;
                var_quarantinedTime = ((([AgentStat.quarantinedTime]')*10)/60)/24;
                var_quarantinedUntilTime = ((([AgentStat.quarantinedUntilTime]'+1)*10)/60)/24;
                var_hospitalizedTime = ((([AgentStat.hospitalizedTime]')*10)/60)/24;
                var_hospitalizedUntilTime = ((([AgentStat.hospitalizedUntilTime]')*10)/60)/24;
                var_worstState_begin = ((([AgentStat.worstState_begin]')*10)/60)/24;
                var_worstState_end = ((([AgentStat.worstState_end]')*10)/60)/24;

                for k = 1 : N
                    AgentStat(k).infectionTime = var_infectionTime(k);
                    AgentStat(k).diagnosisTime = var_diagnosisTime(k);
                    AgentStat(k).quarantinedTime = var_quarantinedTime(k);
                    AgentStat(k).quarantinedUntilTime = var_quarantinedUntilTime(k);
                    AgentStat(k).hospitalizedTime = var_hospitalizedTime(k);
                    AgentStat(k).hospitalizedUntilTime = var_hospitalizedUntilTime(k);
                    AgentStat(k).worstState_begin = var_worstState_begin(k);
                    AgentStat(k).worstState_end = var_worstState_end(k);
                end

                for k = 1 : N
                    if AgentStat(k).worstState_end ~= abs(AgentStat(k).worstState_end)
                        AgentStat(k).worstState_end = -1;
                    end
                end

                for k = 1 : length(AgentStat)
                    segvar = length(agents(AgentStat(k).ID+1).locations);
                    for l = 1 : segvar
                        if agents(AgentStat(k).ID+1).locations(l).typeID == 4 ||...
                           agents(AgentStat(k).ID+1).locations(l).typeID == 13
                            AgentStat(k).WorkPlace = agents(AgentStat(k).ID+1).locations(l).locID;
                        end
                    end
                end

                for k = 1 : length(AgentStat)
                    if strcmp(AgentStat(k).loc_ID,AgentStat(k).WorkPlace)
                        AgentStat(k).workinfbool = 1;
                    else
                        AgentStat(k).workinfbool = 0;
                    end
                end

                AgentStat = struct2table(AgentStat);
                AgentStat = sortrows(AgentStat, 'infectionTime');
                AgentStat = table2struct(AgentStat);

                save(append(samplename{i},num2str(list(j)),'.mat'),'AgentStat');

            end
        end

    end
        
end