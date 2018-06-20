function [] = windowed_bias(fname_mat)
%% -------- DESCRIPTION --------
% Function takes outputs from the Face-Names tasks and plots them for further interpretation.

%% -------- INPUTS --------
% fname_mat = the file containing the results from the experiment [string, full path]

%% -------- OUTPUTS --------
% Average Windowed Bias vs. Time (line graph)
% Average Quatered Bias vs. Time (line graph)
% Response Time vs. Time (line graph)
% Images Shown vs. Sex (bar graph)
% Average Windowed Bias vs. Sex (bar graph)
% Average Windowed Bias vs. Valence (bar graph)
% Response Time vs. Sex (bar graph)
% Response Time vs. Valence (bar graph)
% bias_ matrix = verifies that the sex displayed was equal
% sex_check = average of the sexes shown
% sex_std = standard deviation of the sexes shown
% valence_average = average of the valences shown
% valence_std = standard deviation of the valences shown

%% -------- EXAMPLE --------
% fname_mat = '/Volumes/gizmo/Workspace/Matt_R/GitRepo/Task1/data/subject0003_2018_05_31/subject_0003_31-May-2018.mat';
% windowed_bias(fname_mat);

%% -------- FUNCTION --------
load(fname_mat);
[fdir,fname] = fileparts(fname_mat);
savename = [fdir '/' fname '_windowedbias.mat'];

% The average windowed bias over the span of 5 response values
avg_windowed5_bias = movmean(strcmp(response,bias),5,'Endpoints','shrink');
std_windowed5_bias = movstd(strcmp(response,bias),5,'Endpoints','shrink');

% Creating, scaling, and editing the plot
% Holding a plot with error on it
h = figure;
h.Color = 'w';
subplot(3,3,1);
errorbar(avg_windowed5_bias,std_windowed5_bias,'*-r');
hold all;
h = gca;
y = h.YLim(1):0.2:h.YLim(2);
plot(round(length(response)/2)*ones(length(y),1),y,'black--');
title('AW(5)Bias vs. Time');

% The quarterly averages of the responses
quarters = 1:floor(length(response)/4):length(response)+1;
quarters(end) = quarters(end) - 1;
for idx = 1:4
    avg_bias_quarter(idx,:) = nanmean(avg_windowed5_bias(quarters(idx):quarters(idx+1))); %#ok
    std_bias_quarter(idx,:) = nanstd(avg_windowed5_bias(quarters(idx):quarters(idx+1))); %#ok
end

subplot(3,3,2);
errorbar(avg_bias_quarter,std_bias_quarter,'*-r');
title('AQB vs. Time');

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
        idx = find(strcmp(response,cur_side))+1;
        idx1 = idx(1:round(end/2)-1);
        idx2 = idx(round(end/2)+1:end-1);
        prob1 = sum(strcmp(valence(idx1),cur_valence_group))/length(idx1)*100;
        prob2 = sum(strcmp(valence(idx2),cur_valence_group))/length(idx2)*100;
        bias_matrix(count,:) = ['first half' cur_side cur_valence_group prob1]; %#ok
        count = count + 1;
        bias_matrix(count,:) = ['second half' cur_side cur_valence_group prob2]; %#ok
        count = count + 1;
    end
end
bias_matrix = sortrows(bias_matrix,1); %#ok
subplot(3,3,3);
plot(responsetime,'*-b');
average_responsetime = sum(responsetime)/length(responsetime); %#ok
title('Response Time vs Time');

% Bar Plot of Amount of Images Shown vs. Sex (First half and Second half)
sex_check = [sum(strcmp(sex(1:end/2),'M')) sum(strcmp(sex(1:end/2),'F')); sum(strcmp(sex(end/2+1:end),'M')) sum(strcmp(sex(end/2+1:end),'F'))] / (length(sex)/2); %#ok
subplot(3,3,4);
bar(sex_check);
set(gca, 'xticklabel',{'M','F'});
legend('First Half','Second Half');
% ylim([0 length(sex)/4+5]);
title('Images Shown vs. Sex');

% Bar plot (avg_windowed5_bias for Sex: M/F)
sex_average = [mean(avg_windowed5_bias(strcmp(sex,'M'))) mean(avg_windowed5_bias(strcmp(sex,'F')))];
sex_std = [std(avg_windowed5_bias(strcmp(sex,'M'))) std(avg_windowed5_bias(strcmp(sex,'F')))];
subplot(3,3,6);
hold on
bar(sex_average, 0.6);
errorbar(sex_average,sex_std,'.');
text(1:length(sex_average),sex_average,num2str(sex_average'),'vert','bottom','horiz','center');
box off
set(gca,'xtick',[1 2],'xticklabel',{'M', 'F'});
title('AW(5)Bias vs. Sex');

% Bar plot (avg_windowed5_bias for Valence)
if sum(strcmp(valence,'H')) > 0
    positive = 'H';
else
    positive = 'N';
end

if sum(strcmp(valence, 'F')) > 0
    negative = 'F';
else
    negative = 'S';
end

valence_average = [mean(avg_windowed5_bias(strcmp(valence,positive))) mean(avg_windowed5_bias(strcmp(valence,negative)))];
valence_std = [std(avg_windowed5_bias(strcmp(valence,positive))) std(avg_windowed5_bias(strcmp(valence,negative)))];
subplot(3,3,7);
hold on
bar(valence_average, 0.5);
errorbar(valence_average,valence_std,'.');
text(1:length(valence_average),valence_average,num2str(valence_average'),'vert','bottom','horiz','center');
box off
set(gca,'xtick',[1 2],'xticklabel', {positive, negative});
title('AW(5)Bias vs. Valence');

% Bar plot (responsetime for Sex: M/F - split by first and second half)
sex_average = [mean(responsetime(strcmp(sex,'M'))) mean(responsetime(strcmp(sex,'F')))];
sex_std = [std(responsetime(strcmp(sex,'M'))) std(responsetime(strcmp(sex,'F')))];
subplot(3,3,8);
hold on
bar(sex_average, 0.5);
errorbar(sex_average,sex_std,'.');
text(1:length(sex_average),sex_average,num2str(sex_average'),'vert','bottom','horiz','center');
box off
set(gca,'xtick',[1 2], 'xticklabel', {'M', 'F'});
title('Response Time vs. Sex');

% Bar plot (responsetime for Valence - split by first and second half)
valence_average = [mean(responsetime(strcmp(valence,positive))) mean(responsetime(strcmp(valence,negative)))];
valence_std = [std(responsetime(strcmp(valence,positive))) std(responsetime(strcmp(valence,negative)))];
subplot(3,3,9);
hold on
bar(valence_average, 0.5);
errorbar(valence_average,valence_std,'.');
text(1:length(valence_average),valence_average,num2str(valence_average'),'vert','bottom','horiz','center');
box off
set(gca, 'xtick',[1 2],'xticklabel', {positive, negative});
title('Response Time vs. Valence');

save(savename,'sex_average','sex_std','valence_average','valence_std', 'bias_matrix');