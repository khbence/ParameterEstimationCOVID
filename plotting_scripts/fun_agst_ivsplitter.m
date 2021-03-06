function output = fun_agst_ivsplitter(agentstat,boundaries)

    index_first = fun_agst_findFoLindex(agentstat,boundaries(1),0);
    index_last = fun_agst_findFoLindex(agentstat,boundaries(2),1);
    
    output = agentstat(index_first:index_last);

end