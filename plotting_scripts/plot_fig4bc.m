close all;
%%Wave 1
%    'Age group distribution'

avg_age_1 = 1.0e+03 * [2.6926    2.4721    3.2874    3.6321    2.7835    3.0342    2.0692    1.1715    0.7583    0.0356];
std_age_1 = [217.7590  177.7702  222.3699  225.6579  196.8382  223.0577  160.7013   92.3441   48.4001    5.6241];

%    'Precondition distribution'

avg_precond_1=  1.0e+04 * [1.7633    0.1525    0.1497    0.0926    0.0356];
std_precond_1=  1.0e+03 * [1.2257    0.0959    0.1030    0.0858    0.0282];

%    'Infection locations'

avg_loc_1=  1.0e+04 * [ 0.0002    1.1711    0.0978    0.0161    0.0339    0.0008    0.1165    0.1196    0.0233    0.0954 0.0006    0.2099    0.0000    0.0279    0.0010    0.0353    0.0624    0.1439];

std_loc_1= [1.1929  846.2279   95.3936   19.5451   33.5131    8.2001   89.7438  114.5430   24.3828   98.4864 3.6916  127.1740    0.3038   36.6915    1.5317   39.2745   60.5881  140.7055];



%    'Ratio of infected agents in age groups'

avg_grp_1 = [0.1958    0.1250    0.1049    0.1256    0.1166    0.1224    0.0980    0.0882    0.0911    0.0983];
std_grp_1 = [   0.0158    0.0090    0.0071    0.0078    0.0082    0.0090    0.0076    0.0070    0.0058    0.0155];

    
%%Wave 2
%    'Age group distribution'

avg_age_2 =  1.0e+03 * [    5.8843    5.2675    7.2176    7.7090    6.8660    6.6975    2.9491    1.5195    0.9009    0.0380];
std_age_2 =    [319.0317  233.2683  378.6965  355.4831  367.6443  356.8081  235.1464  104.3527   69.3436    6.3365];

%    'Precondition distribution'
avg_precond_2 =   1.0e+04 * [    3.6882    0.2759    0.2761    0.1966    0.0681];
std_precond_2 =   1.0e+03 * [    1.8296    0.1727    0.1772    0.1301    0.0436];

%    'Infection locations'
avg_loc_2 =    1.0e+04 * [ 0.0003    2.4599    0.2577    0.0406    0.0003    0.0045    0.3292    0.4062    0.0436    0.1548 0.0047    0.2515    0.0007    0.0191    0.0004    0.0018    0.1402    0.3891];
std_loc_2 =   1.0e+03 * [    0.0019    1.3493    0.1682    0.0286    0.0025    0.0193    0.1877    0.2220    0.0381    0.1055   0.0194    0.0862    0.0040    0.0220    0.0013    0.0205    0.0733    0.3187];
	
%    'Ratio of infected agents in age groups'

avg_grp_2 = [0.4278    0.2664    0.2304    0.2666    0.2875    0.2702    0.1396    0.1144    0.1083    0.1048];
std_grp_2 = [0.0232    0.0118    0.0121    0.0123    0.0154    0.0144    0.0111    0.0079    0.0083    0.0175];

        figure; %4B
		scenarionames = {'First wave';'Second wave'};
        angle = 45;
		%avmat = [avg_loc_1./sum(avg_loc_1);avg_loc_2./sum(avg_loc_2)].*100;
		%sdmat = [std_loc_1./sum(avg_loc_1);std_loc_2./sum(avg_loc_2)].*100;
        avmat = [avg_loc_1;avg_loc_2];
		sdmat = [std_loc_1;std_loc_2];
		h = bar(avmat');
        xticks(1:size(avmat,2));
        xticklabels({'Public spaces','Residence','Public edu.','Std. workplace','Small soc. event','Large soc. event','Short stay POI','Long stay POI','Weekend activity','Recreational sites','Closed facility','Hospital','Non-std. schedule wp.','Health center','Commuters','Nursing home','Classroom','University'});
        set(h, {'DisplayName'}, scenarionames);
        hold on
        x_errorbar = zeros(1, numel(sdmat));
        for i = 1 : size(avmat,1)
            x_errorbar((i-1)*size(avmat,2)+1:i*size(avmat,2)) = h(i).XEndPoints;
        end
        h2 = errorbar(x_errorbar,reshape(avmat',1,numel(avmat)),reshape(sdmat',1,numel(sdmat)),'k','linestyle','none','HandleVisibility','off');
        hold off
        legend('Location','best')
        xtickangle(angle-15)
        ylabel('Number of infections')
        set(gca,'YScale','log')
        %ylim([0, 70]);
        title('Infections by location type')
        
        %fig4B categories
        oldgrp_avg = avmat;
        oldgrp_std = sdmat;
        figure
        newcats = {'Residence','Education','Workplace','Services','Social events','Healthcare','Elderly home'};
        newcat_grps = {[2,11],[3,17,18],[4,13],[7,8,9,10,1],[5,6],[12,14],[16]};
        avmat = zeros(length(scenarionames),size(newcats,2));
        sdmat = zeros(length(scenarionames),size(newcats,2));
        for i = 1:size(avmat,2)
            avmat(:,i) = sum(oldgrp_avg(:,newcat_grps{i}),2);
            sdmat(:,i) = sum(oldgrp_std(:,newcat_grps{i}),2);
        end
        h = bar(avmat');
        xticks(1:size(avmat,2));
        xticklabels(newcats);
        set(h, {'DisplayName'}, scenarionames);
        hold on
        x_errorbar = zeros(1, numel(sdmat));
        for i = 1 : size(avmat,1)
            x_errorbar((i-1)*size(avmat,2)+1:i*size(avmat,2)) = h(i).XEndPoints;
        end
        h2 = errorbar(x_errorbar,reshape(avmat',1,numel(avmat)),reshape(sdmat',1,numel(sdmat)),'k','linestyle','none','HandleVisibility','off');
        hold off
        legend('Location','best')
        xtickangle(angle-15)
        ylabel('Number of infections')
        set(gca,'YScale','log')
        %ylim([0, 70]);
        title('Infections by location type')
        
        

        figure;%4C
        avmat = [avg_grp_1;avg_grp_2]*100;%[avg_age_1./sum(avg_age_1);avg_age_2./sum(avg_age_2)].*100;
		sdmat = [std_grp_2;std_grp_2]*100;%[std_age_1./sum(avg_age_1);std_age_2./sum(avg_age_2)].*100;
        %avmat = [avg_age_1./sum(avg_age_1);avg_age_2./sum(avg_age_2)].*100;
		%sdmat = [std_age_1./sum(avg_age_1);std_age_2./sum(avg_age_2)].*100;
        h = bar(avmat');
        xticks(1:size(avmat,2));
        xticklabels({'0-9','10-19','20-29','30-39','40-49','50-59','60-69','70-79','80-89','90-99'});
        set(h, {'DisplayName'}, scenarionames);
        hold on
        x_errorbar = zeros(1, numel(sdmat));
        for i = 1 : size(avmat,1)
            x_errorbar((i-1)*size(avmat,2)+1:i*size(avmat,2)) = h(i).XEndPoints;
        end
        h2 = errorbar(x_errorbar,reshape(avmat',1,numel(avmat)),reshape(sdmat',1,numel(sdmat)),'k','linestyle','none','HandleVisibility','off');
        hold off
        legend('Location','best');
        xtickangle(angle)
        xlabel('Age intervals [years]');
        ylabel('Percentage of agents infected');
        title('Age group distribution');