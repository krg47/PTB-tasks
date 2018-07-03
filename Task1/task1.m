function task1(subID, repetitions, ISI, prob, emotion)
%% -------- DESCRIPTION --------
% Function calls other functions for the Face-Name Task.
% A face will appear, and two randomly selected names will appear underneath the face. Names are pulled from a list.
% The participant will select which name they think matches the face by clicking the left or right arrow key.
% The left arrow key corresponds to the left name and the right key arrow key corresponds to the right name.
% NOTE: There is no correct answer; the names that appear underneath each face are random.
% When a key is selected, the face and names will disappear. After a short Interstimulus Interval, another face and two more names will appear.
% The Interstimulus Interval (ISI) is the time between the disappearance of one face and the appearance of another.
% Depending on what key was selected, the next face that appears should have a certain valence (e.g., more sad, fearful, happy, etc.).
% The valence is the emotion of the face.
% For example, the left key may produce a neutral face while the right key produces a sad face. The side that produces this effect is
% random and is switched half-way through. 
% There is a bias that can control the likelihood that this will occur. This is encoded by Probability of Bias parameter.
% For example, if you set this parameter to 0.8 then 80% of the time when you click the left arrow it will be sad. 
% The pairs of valence can be changed in the pop up before the task. 
  % The three options for valence pairs are:
      % Neutral to Sad (NS)
      % Neutral to Fearful (NF)
      % Happy to Sad (HS)
% The program records the following data from the task in a file titled "<test_ID>.mat":
      % Image numbers (i.e., which image was shown)
      % Group of image (A or B)
        % NOTE: Originally, we had two sets of images, but we
        % eliminated one set of images.
      % Sex of individual in the image
      % Valence of individual's face in the image
      % Participant's response (left or right)
      % Reaction time
      % Which side produces a more positive face
% Other functions included: userinput.m, experiment.mat, displayface.m,
% windowed_bias.m, README.m

%% -------- INPUTS --------
% subID = identification of particular experimentalist [string, full path]
% repetitions = the number of faces that will appear for that subject [number, 0-160]
% ISI (Interstimulus Inverval) = the time (seconds) between two faces [number, 0-3]
% prob = the probability of bias, how likely a certain emotion will appear [number, 0-1]
% emotion = what two emotions will show while the task is running [string, (NS,HS,NF)]

%% -------- OUTPUTS --------
% When the equal sing (=) is pressed, initiating the experiment, a face
% with a certain valence will appear in the middle of the screen and two
% names corresponding to the sex will appear beneath the image and
% bisecting the screen. Once an arrow key is pressed, the face will
% disappear and another face will appear with two new names. From this
% process, a .mat file will be produced containing the biased key of that trial, which image was used,
% the names that were shown, the response of the experimentalist, the
% response time for each image, the sex of the image shown, and the
% emotion (valence) of the image. 
% subject_1234.mat
% subject_1234_DD_MM_YYYY.mat

%% -------- EXAMPLE --------
% subID = 1234;
% repetitions = 80;
% ISI = 1.25;
% prob = 0.80;
% emotion = NS;
% task1(subID, repetitions, ISI, prob, emotion);

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
