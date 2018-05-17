function [avg_windowed5_bias] = windowed_bias(valence,response,bias,nonbias) 
% sum(strcmp(valence(strcmp(response,'R')),'S'))/length(valence(strcmp(response,'R')))*100
    % strcmp(response) filters response for R and sets R as 1. For strcmp(valence) takes all the
    % valences that have response R and displays them as: S=1 and N=0. The sum
    % adds all of these values. Length gives a number of how many responses
    % there are that the 'R' arrow key was pressed. 
% sum(strcmp(valence(strcmp(response,'R')),'N'))/length(valence(strcmp(response,'R')))*100
% sum(strcmp(valence(strcmp(response,'L')),'S'))/length(valence(strcmp(response,'L')))*100
% sum(strcmp(valence(strcmp(response,'L')),'N'))/length(valence(strcmp(response,'L')))*100

% example
% avg_windowed5_bias = windowed_bias(valence,response,bias,nonbias);

% if sum(strcmp(valence,'H')) > 0
%     positive = 'H'
% else
%     positive = 'N'
% end

% avg_windowed5_bias = movmean(strcmp(response,bias),5,'Endpoints','discard')*100
% I need have a plot where the x axis is the # of stimuli minus 4
% plot(avg_windowed5_bias,'*-');
% axis([0 length(avg_windowed5_bias) 0 100]);

% 80% of the time, the right arrow key produces a more negative face. That
% means this if the experimentalist should implicitly want to see more
% neutral faces then therer should be an average of 20% for hitting the
% right key and 80% hitting the left key. Therefore, if we plot average
% bias vs. time, shouldn't we see the data reach 20% and then plateau?

% If the bias is going toward the more negative face, shouldn't someone
% without MDD implicitly want to become less negative and thus implicitly
% press the button that leads toward a less negative result?

if bias == 'R'
    nonbias = 'L'
elseif bias == 'L'
    nonbias = 'R'
end

avg_windowed5_bias_1sthalf = movmean(strcmp(response(1:(length(response)/2)+2),bias),5,'Endpoints','discard')*100;
figure(1);
plot(avg_windowed5_bias_1sthalf,'*-');
axis([0 length(avg_windowed5_bias_1sthalf) 0 100]);

avg_windowed5_bias_2ndhalf = movmean(strcmp(response(((length(response)/2)-1):length(response)),nonbias),5,'Endpoints','discard')*100;
figure(2);
plot(avg_windowed5_bias_2ndhalf,'*-');
axis([0 length(avg_windowed5_bias_2ndhalf) 0 100]);

C = [avg_windowed5_bias_1sthalf;avg_windowed5_bias_2ndhalf]

avg_windowed5_bias_whole = movmean(strcmp(response,bias),5,'Endpoint','discard')*100;
figure(3);
plot(avg_windowed5_bias_whole,'*-r');
axis([0 length(avg_windowed5_bias_whole) 0 100]);

figure(4)
plot(C,'*-g');
axis([0 length(C) 0 100]);
% avg_windowed5_nonbias_1sthalf = movmean(strcmp(response(1:length(response)/2),nonbias),5,'Endpoints','discard')*100
% avg_windowed5_nonbias_2ndhalf = movmean(strcmp(response((length(response)/2)+1:length(response)),nonbias),5,'Endpoints','discard')*100