%Lecture 10

catawba = xlsread('catawba_data.xls');
temps = catawba(:,4);
flows = catawba(:,5);
days = length(catawba);
W = zeros(days,1);
losses = zeros(days,1);



for i=1:days
   
    
        W(i) = 33.3/(1+exp(.15*(16.9-(temps(i)))))+(127/flows(i));
        
        if W(i) > 37 && W(i) <=40
            losses(i) = .25*2000*24;
        elseif W(i) >40 && W(i) <=42
            losses(i) = .50*2000*24;
        elseif W(i)>42
            losses(i) = 2000*24;
        end 
    
end

losses_dollars = (losses*100)/1000;

annual_losses = zeros(41,1);

for i = 1:41
    annual_losses(i) = sum(losses_dollars((i-1)*365+1:(i-1)*365+365));
end 



%yLabel('Frequency');
%xLabel('Losses $1000');
histogram(annual_losses,100);
%plot(annual_losses);

sorted_losses = sortrows(annual_losses);

CC_temps = temps + 2;
flows = catawba(:,5);

log_flows = log(flows);
Whitened_flows = log_flows - (mean(log_flows))/std(log_flows);

CC_flows = (Whitened_flows + 0.9*mean(log_flows))*1.2*std(log_flows);
CC_flows = exp(CC_flows);

