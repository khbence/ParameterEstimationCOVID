function funplot_realdata(hundata,numAgents,hunPopulation,w,nepesseg)

national = hundata*numAgents/hunPopulation;
data_len = numel(national);
plot(0:data_len-1,national/nepesseg,'Color',[0.4470 0.7410 0],'LineWidth',w,'DisplayName','Országos adat');

end