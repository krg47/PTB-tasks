%assuming there is a list of faces that start at 1 = most positive and 100
%=1234
%most423=
%negative
%not entirely sure how the process should work. what faces? look at
%previous several blocks?
%will we have diff face types (sex and race) in diff files?
%what if they get sequence wrong?

%10/25- We have to somehow be able to pass info about the window/screen
%from one function to the other. %square test is working for 2 faces in a row
%now, just need to figure out how to get window info to it

%10/26- How are we supposed to be using inter trial interval? We found it
%weird whe some sequences would be something like 3323333. Should we
%prevent numbers from being repeated too many times? On the 7th it jumped
%without me clicking anything, but now it seems to be working. We might
%just want to watch out for that. Should we have a screen flash or removal
%of face or something to indicate face change?

%11/1- Face is now "flashing" on and off as intended. Should ISI be ITI +
%ISI or just the time in ISI?-just ISI. Once we have the facebank we can add which
%preset variables for race and sex. Do we want to store image names? Need
%to record image name, % valence (included in fname), response time. Not
%sure if it is storing in the desired format, but as of now the program can
%store image number, response time, and valence into a file named after the
%ID of the subject

clear;
addpath /Volumes/gizmo/Workspace/Matt_r
addpath /Volumes/gizmo/Workspace/Matt_r/GitRepo/Faces
addpath(genpath('/Applications/MatlabAddOns/Psychtoolbox-3-PTB_Beta-2016-09-10_V3.0.13/'))
Screen('Preference', 'SkipSyncTests', 1);
sca;
PsychDefaultSetup(2);
d = dir('/Volumes/gizmo/Workspace/Matt_R/GitRepo/Faces/*.png');
%maxconsecutive=2; %number of times the same number is allowed to be in the sequence consecutively
subID='1234'; %subject ID
sequencelength=7; %set number of terms in sequence
neutralreps=2; %number of neutral faces initially shown
repetitions=10; %how many times we want it to happen
ITI=0; %inter trial interval
ISI=1.25;
sequence=[3 4 1 2 3 1 4]; %for now just use a given sequence before a sequence bank is given to us

[screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter] = waittostart; %waittostart function

key='N'; %key is N for initial neutral faces
img(1)=0;
responsetime=zeros(1,10); %blank vectors
imgnum=zeros(1,10);
for i=1:repetitions %how many sequences of 7 we want
    for numseq=1:length(sequence) %length of the sequence
        [responsetime, imgnum, theImage, fname] = squares(sequence, d, key,numseq, img, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter,responsetime, imgnum,i); %display function
        WaitSecs(ITI) %intertrial interval
    end
    valence{i,:} = fname(9);  %how to store?
    totalResponseTime(i)=sum(responsetime);
    key=analyze(responsetime, i, neutralreps, totalResponseTime);
    %convert to cells
    responseCell{i,:}=totalResponseTime(i);
    imgCell{i,:}=imgnum(i);
    WaitSecs(ISI-ITI) %interstimulus interval, subtract ITI because it already waited ITI
end

datafile=strcat('subject_',subID); %makes filename for results
save(datafile, 'responseCell', 'imgCell','valence') %also need image names and valence %

KbStrokeWait; %ends with keyboard touch
sca;