function [avg_windowed5_bias] = windowed_bias(valence, response, bias) 
% sum(strcmp(valence(strcmp(response,'R')),'S'))/length(valence(strcmp(response,'R')))*100
    % strcmp(response) filters response for R and sets R as 1. For strcmp(valence) takes all the
    % valences that have response R and displays them as: S=1 and N=0. The sum
    % adds all of these values. Length gives a number of how many responses
    % there are that the 'R' arrow key was pressed. 
% sum(strcmp(valence(strcmp(response,'R')),'N'))/length(valence(strcmp(response,'R')))*100
% sum(strcmp(valence(strcmp(response,'L')),'S'))/length(valence(strcmp(response,'L')))*100
% sum(strcmp(valence(strcmp(response,'L')),'N'))/length(valence(strcmp(response,'L')))*100

% example
% avg_windowed5_bias = windowed_bias(valence,response,bias);

positive = 'N'

avg_windowed5_bias = movmean(strcmp(response,bias),5,'Endpoints','discard')*100
% I need have a plot where the x axis is the # of stimuli minus 4
plot(avg_windowed5_bias,'*-');
axis([0 length(avg_windowed5_bias) 0 100]);

%avg_windowed5_bias_1 = movmean(strcmp(response(1:length(response)/2),bias),5,'Endpoints','discard')*100
%avg_windowed5_bias_2 = movmean(strcmp(response(length(response)/2:length(response)),'L'),5,'Endpoints','discard')*100