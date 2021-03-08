function output = fun_agst_statreadprocfun(stat_name)

    fname = stat_name;
    fname = split(fname,'.');
    fname(end) = [];
    fname = string(append(fname,'.mat'));
    AgentStat = load(fname);
    AgentStat = AgentStat.AgentStat;
    output = AgentStat;

end