close all;
%%Wave 1

%    'Infection locations'
avg_loc_1 =   1.0e+04 * [0.0002    1.1711    0.0978    0.0161    0.0339    0.0008    0.1165    0.1196    0.0233    0.0954    0.0006    0.2099    0.0000    0.0279 ...
    0.0010    0.0353    0.0624    0.1439;    0.0004    4.0015    0.4605    0.2683    0.4154    0.2578    0.5597    0.5800    0.1002    0.3774 ...
    0.0045    0.3609    0.0006    0.2276    0.0006    0.0655    0.3665    0.6071];


std_loc_1= [1.1929  846.2279   95.3936   19.5451   33.5131    8.2001   89.7438  114.5430   24.3828   98.4864    3.6916  127.1740    0.3038   36.6915 ...
    1.5317   39.2745   60.5881  140.7055;    1.8397  356.7798   63.0239   61.5238   53.8778   30.9015  110.5081  103.8142   25.0035   49.4167 ...
    6.5555   63.3748    1.8947   52.0551    1.7328   17.4764   53.6676   93.9156];

avg_loc_2 = 1.0e+04 * [0.0003    2.4599    0.2577    0.0406    0.0003    0.0045    0.3292    0.4062    0.0436    0.1548    0.0047    0.2515    0.0007    0.0191 ...
    0.0004    0.0018    0.1402    0.3891;    0.0001    0.1742    0.0210    0.0095    0.0190    0.0115    0.0283    0.0442    0.0039    0.0092...
    0.0002    0.0238    0.0001    0.0082    0.0002    0.0001    0.0175    0.0193];


std_loc_2 =    1.0e+03 * [0.0019    1.3493    0.1682    0.0286    0.0025    0.0193    0.1877    0.2220    0.0381    0.1055    0.0194    0.0862    0.0040    0.0220 ...
    0.0013    0.0205    0.0733    0.3187;    0.0009    0.3000    0.0539    0.0245    0.0308    0.0212    0.0636    0.0885    0.0066    0.0202...
    0.0022    0.0394    0.0008    0.0178    0.0011    0.0006    0.0440    0.0411];

bothwaves_avg = flip(avg_loc_1+avg_loc_2);
bothwaves_std = flip((std_loc_1+std_loc_2)./2);

	
        figure; %3B
		scenarionames = {'Free spread';'Restrictions'};
        angle = 45;
		avmat = bothwaves_avg;%./sum(bothwaves_avg,2).*100;%[avg_loc_1./sum(avg_loc_1);avg_loc_2./sum(avg_loc_2)].*100;
		sdmat = bothwaves_std;%./sum(bothwaves_avg,2).*100;
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
        
