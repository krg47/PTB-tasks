=%assuming there is a list of faces that start at 1 = most positive and 100
%=1234 most
%negative
%not entirely sure how the process should work. what faces? look at
%previous several blocks?
%will we have diff face types (sex and race) in diff files?
%what if they get sequence wrong?

clear;
addpath /Volumes/gizmo/Workspace/Matt_r
addpath /Volumes/gizmo/Workspace/Matt_r/GitRepo/Faces
addpath(genpath('/Applications/MatlabAddOns/Psychtoolbox-3-PTB_Beta-2016-09-10_V3.0.13/'))
Screen('Preference', 'SkipSyncTests', 1);
sca;
PsychDefaultSetup(2);
d = dir('/Volumes/gizmo/Workspace/Matt_R/GitRepo/Faces/*.png');
neutralreps=3; %number of neutral faces initially shown
repetitions=10; %how many times we want it to happen

sequence=[33, 31, 32, 32, 31, 30, 33]; %this is 4 2 3 3 2 1 4

[window, windowRect, screens, screenNumber, xCenter, yCenter] = waittostart; %waittostart function

key='N'; %key is N for initial neutral faces
img(1)=0;
for i=1:(repetitions+1)
[responsetime(i), img(i)] = facedisplay(sequence, d, key,i,img, window); %display function
key=analyze(responsetime, i, neutralreps);
end
%face analysis
%face display


KbStrokeWait;
    
    % Clear the
    % screen
    sca;
