

%2/9- this is just a copy of task1_3 except trying to get it to work with
%the new face directory

%2/21- BM07Sad looks happy, DOES FIRST FACE HAVE TO BE NEUTRAL?
% heather, hannah, charlie, edward, monica, evelyn,
%phoebe, melissa
%experiment line 54
%Questions: should we say anything about needing psychtoolbox?
%do we credit the face bank?

% Make right/left random DONE
% start on neutral (happy for HS) DONE
% Cyle all people before repeating DONE
% switch halfway through DONE
% switch '/' to filesep for directories and folders DONE
% fix names that are too long either by repositioning or deleting old
% names DONE 

%Do we want group A or B for the face bank? -Now we only have 70 faces
%


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

end
