function [avg_windowed5_bias,std_windowed5_bias, avg_bias_quarter] = windowed_bias(valence,response,bias)
% example
% [avg_windowed5_bias,avg_bias_quarter] = windowed_bias(~,response,bias,nonbias);

% Sets the nonbias variable based on the bias variable
if bias == 'R'
    nonbias = 'L';
elseif bias == 'L'
    nonbias = 'R';
end

% The average windowed bias over the span of 5 response values
avg_windowed5_bias = movmean(strcmp(response,bias),5,'Endpoints','shrink');
std_windowed5_bias = movstd(strcmp(response,bias),5,'Endpoints','shrink');

figure;
errorbar(avg_windowed5_bias,std_windowed5_bias,'*-r');
hold all;
h = gca;
y = [h.YLim(1):0.2:h.YLim(2)];
plot(round(length(response)/2)*ones(length(y),1),y,'black--');
title('Average Windowed (5) Bias vs. Time');

% The quarterly averages of the responses
quarters = [1:floor(length(response)/4):length(response)];
for idx = 1:4
    avg_bias_quarter(idx,:) = nanmean(avg_windowed5_bias(quarters(idx):quarters(idx+1)));
    std_bias_quarter(idx,:) = nanstd(avg_windowed5_bias(quarters(idx):quarters(idx+1)));
end

figure(2);
errorbar(avg_bias_quarter,std_bias_quarter,'*-r');
title('Average Quarter Bias vs. Time');

% Make sure that the probability of bias is functioning properly
% If the probability of bias is 0.80, the other key should have a 0.20 bias
% that the next face is a negative valence

side = unique(response);
valence_group = unique(valence);

count = 1;
for sidx = 1:length(side)
    for vidx = 1:length(valence_group)
        cur_side = side(sidx);
        cur_valence_group = valence_group(vidx);
        idx = find(strcmp(response(1:round(end/2)),cur_side))+1;
        data(count,:) = sum(strcmp(valence(idx),cur_valence_group))/length(idx)*100;
        data_val_1(count,:) = ['first half' cur_side cur_valence_group];
        count = count + 1;
    end
end

count = 1;
for sidx = 1:length(side)
    for vidx = 1:length(valence_group)
        cur_side = side(sidx);
        cur_valence_group = valence_group(vidx);
        idx = find(strcmp(response(round(end/2)+1:end),cur_side))+1;
        data(count,:) = sum(strcmp(valence(idx),cur_valence_group))/length(idx)*100;
        data_val_2(count,:) = ['second half' cur_side cur_valence_group];
        count = count + 1;
    end
end

data_val = [data_val_1; data_val_2]
