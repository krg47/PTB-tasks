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

%11-20- Changes we need to make based on meeting: Face valence changes only after a
%whole block is completed. Calculate new valence by valence = (avg speed of first 2
%blocks) - (speed of most recent block) / 5. If  valence > 0, face becomes more
%negative by amount valence. If valence < 0, face becomes more positive by
%amount valence.

%Faces shouldnt change until after the third block. Also make sequence start on a random
%place in the sequence. StartingSpot = randomint modulo 7

%11-27 faces should now only change after block 3 and every block after
%that. Working on calculating valence correctly from baseline

%11-29 calculating valence should work now. It only checks if H S or N,
%doesn't calculate how much more happy or sad the next face should be

%11-30 I added a folder with 50 sad to 50 happy called Task2Faces. I'm not
%entirely sure how we should be calculating what % valence it goes up or
%down. we also have to store data as continous.

%1-22 I think the images should get happier/sadder by the correct
%percentage now. Haven't tested it much because we don't have the images
%ready yet. Our current setup relies on each face having a folder that
%starts with the happiest faces and ends wiht the saddest faces, with the
%neutral face in the middle

%1-26 TODO: make an example use of this function. If # of arguments is less than
%the number taken, open a dialogue box prompting for gender, race, blocks,
%etc.  Calucate delta by %change in time = %change in face. Switch from
%"reverse learning" to "forward learning" in the middle of the task.
%Reverse learning should always come first. Number of blocks should always
%be even. # of blocks must be > 3. Use only relative filepaths. The
%function should change directories for you. Should be runnable immediatley
%after unzipping.

% 1-31 If you run the function without all the arguments, a dialog box will
% ask for the parameters. Input validation should work. Need to incorporate
% the forward learning blocks. ie after doing the reverse learning blocks,
% switch so that faster = happier. Once we get the images merged we can
% also use the gender and race options.

%2/9-do we want total response time to just keep adding as in seconds from
%the start? or just time per block

function task2(subID, reverseblocks, forwardblocks, repetitions, ITI, ISI, gender, race, emotion);

validInput = false;

if nargin < 8
    while ~validInput
        prompt = {'SubjectID:','Foward learning blocks:', 'Reverse learning blocks:', 'Repetitions:', 'ITI:', 'ISI:', 'Gender', 'Race:', 'Emotion'};
        dlg_title = 'Configure Task';
        num_lines = 1;
        def = {'1234','8', '4', '4', '0', '1.25', 'F', 'W', 'NS'}; %Default is Neutral/sad 
        answer = inputdlg(prompt,dlg_title,num_lines,def);
        
        if isempty(answer),return,end;
        
        if str2num(answer{2}) < 3
            uiwait(warndlg('Must be at least 3 Reverse learning blocks'));
        elseif (mod((str2num(answer{2}) + str2num(answer{3})), 2) ~= 0)
            uiwait(warndlg('Must be an even number of blocks'));
        elseif str2num(answer{4}) <= 1
            uiwait(warndlg('Must have > 1 repetitions'));
        elseif isnan(str2double(answer{5})) | isnan(str2double(answer{6}))
            uiwait(warndlg('Invalid ITI or ISI'));
        elseif ~(or(strcmp(answer{7}, 'F'), strcmp(answer{7}, 'M')))
            uiwait(warndlg('Invalid Gender'));
        elseif answer{8} ~= 'W' & answer{8} ~= 'B'
            uiwait(warndlg('Invalid Race'));
        elseif answer{9} ~= 'NS' & answer{9} ~= 'NF' & answer{9} ~= 'HS'
            uiwait(warndlg('Invalid Emotion spectrum. Must be NS, NF, or HS'));
        else
            validInput = true
            subID = answer{1}
            reverseblocks = str2num(answer{2})
            forwardblocks = str2num(answer{3})
            repetitions = str2num(answer{4})
            ITI = str2double(answer{5})
            ISI = str2double(answer{6})
            gender = answer{7}
            race = answer{8}
            emotion = answer{9}
        end
    end
end

% addpath /Volumes/gizmo/Workspace/Matt_r
% addpath /Volumes/gizmo/Workspace/Matt_r/GitRepo/Task2/Task2Faces
% addpath(genpath('/Applications/MatlabAddOns/Psychtoolbox-3-PTB_Beta-2016-09-10_V3.0.13/'))
Screen('Preference', 'SkipSyncTests', 1);
sca;
PsychDefaultSetup(2);
dirStr = '';

if gender == 'M'
    dirStr = 'Faces/Male/'
elseif gender == 'F'
    dirStr = 'Faces/Female/'
end

if race == 'W'
    dirStr = strcat(dirStr, 'White/');
elseif race == 'B'
    dirStr = strcat(dirStr, 'Black/');
end



% dirStr = 'Faces/Female/White/'
% emotion = 'NS'


tempd = dir(dirStr);
folders = {tempd.name}'

lst = cellfun(@(x)isempty((regexp(x, '^\.'))),folders, 'un', 0)
lst = cellfun(@(x,y)x(x & y),folders, lst, 'un', 0)
lst = lst(~cellfun('isempty',lst))

whichFace = randi(size(lst));
dirStr = (strcat(dirStr, lst(whichFace), '/', emotion, '/'))%Navigate to random subject's folder of this gender and race
dirStr = dirStr{1}

tempd = dir(dirStr)
folders = {tempd.name}';

lst = cellfun(@(x)isempty((regexp(x, '^\.'))),folders, 'un', 0);
lst = cellfun(@(x,y)x(x & y),folders, lst, 'un', 0);
lst = lst(~cellfun('isempty',lst))

dirStr = strcat(dirStr, lst{1}, '/')

d = dir(dirStr)

lst = arrayfun(@(x)isempty((regexp(x.name, '^\.'))), d, 'un', 0)
lst = arrayfun(@(x,y)x.name(x.name & y),d, cell2mat(lst), 'un', 0)
d = d(~cellfun('isempty',lst))


% d = dir('Task2Faces/42M_SA_C_crop/*.jpg');
%maxconsecutive=2; %number of times the same number is allowed to be in the sequence consecutively
sequencelength = 7; %set number of terms in sequence
neutralreps = 2; %number of neutral faces initially shown


%sequence=[3; 4; 1; 2; 3; 1; 4]; %for now just use a given sequence before a sequence bank is given to us

%makes random sequence
sequences = csvread('sequences.csv');
sz = size(sequences);
rseq = randi(sz(1));
sequence = sequences(rseq, :);
sequence = transpose(sequence);
% sequence = circshift(sequence, randi(sequencelength), 1); this rotates sequence by random amount


[screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter] = waittostart; %waittostart function

key = 'N'; %key is N for initial neutral faces
img(1) = 0;
responsetime = zeros(1,repetitions * reverseblocks); %blank vectors
imgnum = zeros(1,repetitions * reverseblocks);
imgnum(1) = ceil(length(d)/2); %neutral in the middle
keyresponse = zeros(1,7);
delta = 0; %amount up or down to change the mood
totalblocks = reverseblocks + forwardblocks;
reverse = true;
for j = 1:totalblocks
    str = strcat('starting block ', int2str(j));
    if j > reverseblocks
        reverse = false;
    end
    for i = 1:repetitions %how many sequences of 7 we want
        str = strcat('starting rep ', int2str(i));
        str = strcat('key: ', key);
        k = (i+(j-1)*repetitions); %Variable k
        
        for numseq = 1:length(sequence) %length of the sequence
            
            [responsetime, imgnum, theImage, fname,keyresponse] = squares(sequence, d, key,numseq, window, screenXpixels, screenYpixels,  yCenter,responsetime, imgnum, keyresponse, k, delta); %display function
            
            WaitSecs(ITI) %intertrial interval
        end
        key = 'N';
        valence{k,:} = fname(5);  %how to store?
        totalResponseTime(k) = sum(responsetime);
        
        %convert to cells
        
        responseTimeCell{k,:} = responsetime((length(responsetime)-6):length(responsetime)); %slightly weird format otherwise would have extra 0s
        totalResponseTimeCell{k,:} = totalResponseTime(k);
        keyresponseCell{k,:} = transpose(keyresponse);  %store keyresponse as a column vector
        imgCell{k,:} = imgnum(k);
        sequenceCell{k,:} = sequence;
        rightorwrongCell{k,:} = (transpose(keyresponse)==(sequence+29)); %add 29 for ascii
        WaitSecs(ISI - ITI) %interstimulus interval, subtract ITI because it already waited ITI
    end
    
    if j > 2 % After 2 blocks, determine valence of subsequent face
        a='aaaaaa'
        baseline = (sum(responsetime(1:(repetitions * neutralreps * 7)))) / neutralreps %Avg of first 2 blocks
        [key, delta] = analyze(responsetime, j,repetitions,k, baseline, reverse);
    end
end

datafile = strcat('subject_',subID); %makes filename for results
save(datafile, 'responseTimeCell','totalResponseTimeCell', 'imgCell','valence', 'keyresponseCell', 'sequenceCell','rightorwrongCell') %also need image names and valence %

sca;
end