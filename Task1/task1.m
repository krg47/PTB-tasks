function task1(subID, repetitions, ISI, prob, emotion)

% Set up PTB
Screen('Preference', 'SkipSyncTests', 1);
sca;
PsychDefaultSetup(2);


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
