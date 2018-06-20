function task1(subID, repetitions, ISI, prob, emotion)
%% -------- DESCRIPTION --------
% Function calls other functions for the Face-Name Task.
% Other functions included: userinput.m, experiment.mat, displayface.m,
% windowed_bias.m, README.m

%% -------- INPUTS --------
% subID = identification of particular experimentalist [string, full path]
% repetitions = the number of faces that will appear for that subject [number, 0-160]
% ISI (Interstimulus Inverval) = the time (seconds) between two faces [number, 0-3]
% prob = the probability of bias, how likely a certain emotion will appear [number, 0-1]
% emotion = what two emotions will show while the task is running [string, (NS,HS,NF)]

%% -------- OUTPUTS --------
% Outputs the subject identification and initiates usage of faces and names. 

%% -------- EXAMPLE --------
% subID = 1234
% repetitions = 80
% ISI = 1.25
% prob = 0.80
% emotion = NS

%% -------- FUNCTION --------
% Set up PTB
sca;
PsychDefaultSetup(2);
Screen('Preference', 'SkipSyncTests',1);


% Get user input and validate
if nargin < 5
    [subID, repetitions, ISI, prob, emotion] = userinput;
    
    if emotion(1) == 'N' && emotion(2) == 'S'
        d = ['..' filesep 'Task1' filesep 'NS' filesep '*.JPG'];
    end
    if emotion(1) == 'N' && emotion(2) == 'F'
        d = ['..' filesep 'Task1' filesep 'NF' filesep '*.JPG'];
    end
    if emotion(1) == 'H' && emotion(2) == 'S'
        d = ['..' filesep 'Task1' filesep 'HS' filesep '*.JPG'];
    end
end

mid = fopen('MaleNames.txt');  %male name file id
fid = fopen('FemaleNames.txt'); %female name file id

M = textscan(mid, '%s', 'delimiter', '\n'); %scan in name files into structures
MaleNames = M{1};
fclose(mid);

F = textscan(fid, '%s', 'delimiter', '\n');
FemaleNames = F{1};
fclose(fid);

%Run experimental task
experiment(MaleNames, FemaleNames, d, repetitions, ISI, subID, prob, emotion);

%save with date
filename = strcat('subject_',subID,'_',date,'.mat');
copyfile(strcat('subject_',subID,'.mat'),filename);

end
