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

%11/2-if they press any key it should go on, but record what key they
%pressed. Include response if they actually pressed right button (0 or 1).

%11/3- do we want to store the key they press by name of by ASCII? As of
%now it is ASCII but just do KbName(matrix) to switch. How should we store
%the sequence that is used? (store it for each trial for comparison or just
%once?) It also seems to be lagging a slight amount since adding that all
%keys should be released before checking-is this an issue? also added
%aa 1 or 0 for if button is right or wrong

% 11/6 right now when the experiment ends they are shown a screen with
% empty squares until they press another button. Can we avoid this?
% I created a file called "sequences.txt" that has randomly generated
% sequences. I got rid of the ones I saw that had a bunch of repititions,
% but you may want to double-check it. Theres ~75 sequences in the file. I
% created the file, but I haven't made our function read from it
% yet.

%11/7 I was messing around with the inter trial interval (ITI) and I think
%that if it is used, then there should not be a problem with 2 numbers
%repeating in the sequence. I tried the ITI of 0.750 seconds and it was way too
%long of a time. I then tried it with 0.1 seconds and then 0.01 seconds.
%Both seemed adequate. I still do not think a sequence should have more
%than two of the same consecutive number.

%11/8 sequences.csv now has 94 valid sequences and one is randomly chosen.
%sequencer.m generates sequences and gets rid of ones with  repititions

%11/15- should average be recalculated between blocks?

%11/16- first half if you get better faces become more negative, second half faces
%become more positive (sequence stays the same)-FIXED. also gender and race of
%image. make reaction time for each key-FIXED. unique id is one of 18 faces.
%valence will be something like % then fearful/happy. store parameters put
%in for function, need 20x7 for storage

function task2(subID, blocks, repetitions, ITI, ISI);

addpath /Volumes/gizmo/Workspace/Matt_r
addpath /Volumes/gizmo/Workspace/Matt_r/GitRepo/Faces
addpath(genpath('/Applications/MatlabAddOns/Psychtoolbox-3-PTB_Beta-2016-09-10_V3.0.13/'))
Screen('Preference', 'SkipSyncTests', 1);
sca;
PsychDefaultSetup(2);
d = dir('Faces/*.png');
%maxconsecutive=2; %number of times the same number is allowed to be in the sequence consecutively
sequencelength=7; %set number of terms in sequence
neutralreps=2; %number of neutral faces initially shown


%sequence=[3; 4; 1; 2; 3; 1; 4]; %for now just use a given sequence before a sequence bank is given to us

%makes random sequence
sequences = csvread('sequences.csv');
sz = size(sequences);
rseq = randi(sz(1));
sequence = sequences(rseq, :);
sequence=transpose(sequence);


[screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter] = waittostart; %waittostart function

key='N'; %key is N for initial neutral faces
img(1)=0;
responsetime=zeros(1,10); %blank vectors
imgnum=zeros(1,10);
keyresponse=zeros(1,7);
for j = 1:blocks
    for i=1:repetitions %how many sequences of 7 we want
        k=(i+(j-1)*repetitions); %Variable k
        for numseq=1:length(sequence) %length of the sequence
            [responsetime, imgnum, theImage, fname,keyresponse] = squares(sequence, d, key,numseq, window, screenXpixels, screenYpixels,  yCenter,responsetime, imgnum, keyresponse, k, repetitions); %display function
            WaitSecs(ITI) %intertrial interval
        end
        valence{k,:} = fname(9);  %how to store?
        totalResponseTime(k)=sum(responsetime);
        key=analyze(responsetime, i, neutralreps, totalResponseTime,j,repetitions,k);
        %convert to cells
        responseTimeCell{k,:}=responsetime(1:length(sequence)); %slightly weird format otherwise would have extra 0s
        totalResponseTimeCell{k,:}=totalResponseTime(k);
        keyresponseCell{k,:}=transpose(keyresponse);  %store keyresponse as a column vector
        imgCell{k,:}=imgnum(k);
        sequenceCell{k,:}=sequence;
        rightorwrongCell{k,:}=(transpose(keyresponse)==(sequence+29)); %add 29 for ascii
        WaitSecs(ISI-ITI) %interstimulus interval, subtract ITI because it already waited ITI
    end
end

datafile=strcat('subject_',subID); %makes filename for results
save(datafile, 'responseTimeCell','totalResponseTimeCell', 'imgCell','valence', 'keyresponseCell', 'sequenceCell','rightorwrongCell') %also need image names and valence %


sca;
end