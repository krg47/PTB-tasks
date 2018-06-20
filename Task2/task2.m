function task2(subID, reverseblocks, forwardblocks, repetitions, ITI, ISI, IBI, sex, race, emotion, violationrate)
%% -------- DESCRIPTION --------
% Function calls other functions for the Motor Sequence Task. Other
% functions included: analyze.m, facedisplay.m, README.m, sequencer.m,
% squares.m, waittostart.m

%% -------- INPUTS --------
% subID = identification of particular experimentalist [string, full path]
% reverseblocks = faster time = less positive faces [number, 4-8]
% forwardblocks = faster time = more positive faces [number, 4-8]
% repetitions = how many sequences are shown in a block [number, 0-10]
% ITI = (Intertrial Interval) time between two sequences [number, 0-0.1]
% ISI = (Interstimulus Interval) time between two shown faces [number, 0.1-0.4]
% IBI = (Interblock Interval) time between two groups of sequences [number, 4-6]
% sex = the sex of the experimentalist [string (M,F) partial path]
% race = the race of the experimentalist [string (W,B,A) partial path]
% emotion = what two emotions will show while the task is running [string, (NS,HS,NF)]
% violationrate = the percentage of how the sequence may be violated [number, 0-1]

%% -------- OUTPUTS --------
% Outputs the subject identification and initiates the displaying of a face
% within a square

%% -------- EXAMPLE --------
% subID = '1234'
% reverseblocks = 8
% forwardblocks = 4
% repetitions = 4
% ITI = 0
% ISI = 1.25
% IBI = 5
% sex = 'F'
% race = 'W'
% emotion = 'NS'
% violationrate = 0
% sequencelength = 7

%% -------- FUNCTION --------
    validInput = false;

    % Give dialog box popup if arguments aren't given
    if nargin < 11
        while ~validInput
            prompt = {'SubjectID:','Foward learning blocks:', 'Reverse learning blocks:', 'Repetitions:', 'Inter-Trial Interval:', 'Inter-Stimulus Interval:', 'Inter-Block Interval', 'Sex: (F or M)', 'Race: (W or B)', 'Emotion: (NS, NF, or HS)', 'Violation Rate', 'Sequence length'};
            dlg_title = 'Configure Task';
            num_lines = 1;

            % Default values
            def = {'1234','8', '4', '4', '1.25', '0.15', '5', 'F', 'W', 'NS', '0','7'}; %Default is Neutral/sad
            answer = inputdlg(prompt,dlg_title,num_lines,def);

            if isempty(answer),return,end;

            % Input validation
            if str2num(answer{2}) < 3 %#ok
                uiwait(warndlg('Must be at least 3 Reverse learning blocks'));
            elseif (mod((str2num(answer{2}) + str2num(answer{3})), 2) ~= 0) %#ok
                uiwait(warndlg('Must be an even number of blocks'));
            elseif str2num(answer{4}) <= 1 %#ok
                uiwait(warndlg('Must have > 1 repetitions'));
            elseif isnan(str2double(answer{5})) | isnan(str2double(answer{6})) | isnan(str2double(answer{7})) %#ok
                uiwait(warndlg('Invalid ITI, ISI or IBI'));
            elseif ~(or(strcmp(answer{8}, 'F'), strcmp(answer{8}, 'M')))
                uiwait(warndlg('Invalid Sex'));
            elseif answer{9} ~= 'W' & answer{9} ~= 'B' %#ok
                uiwait(warndlg('Invalid Race'));
            elseif answer{10} ~= 'NS' & answer{10} ~= 'NF' & answer{10} ~= 'HS' %#ok
                uiwait(warndlg('Invalid Emotion spectrum. Must be NS, NF, or HS'));
            elseif str2num(answer{11})>1 || str2num(answer{11})<0 %#ok
                uiwait(warndlg('Invalid Violation Rate'));
            elseif str2num(answer{12})<4 %#ok
                uiwait(warndlg('The sequence length must be at least 4'));
            else
                
                % Set values
                validInput = true;
                subID = answer{1};
                reverseblocks = str2num(answer{2}); %#ok
                forwardblocks = str2num(answer{3}); %#ok
                repetitions = str2num(answer{4}); %#ok
                ITI = str2double(answer{5});
                ISI = str2double(answer{6});
                IBI = str2double(answer{7});
                sex = answer{8};
                race = answer{9};
                emotion = answer{10};
                violationrate = str2num(answer{11}); %#ok
                sequencelength = str2num(answer{12}); %#ok
            end
        end
    end

    Screen('Preference', 'SkipSyncTests', 1);
    sca;
    PsychDefaultSetup(2);

    % Find appropriate pictures based on sex and race
    dirStr = '';

    if sex == 'M'
        dirStr = ['Faces' filesep 'Male' filesep];
    elseif sex == 'F'
        dirStr = ['Faces' filesep 'Female' filesep];
    end

    if race == 'W'
        dirStr = strcat(dirStr, 'White', filesep);
    elseif race == 'B'
        dirStr = strcat(dirStr, 'Black', filesep);
    end

    tempd = dir(dirStr);
    folders = {tempd.name}';

    % Exclude hidden files
    lst = cellfun(@(x)isempty((regexp(x, '^\.'))),folders, 'un', 0);
    lst = cellfun(@(x,y)x(x & y),folders, lst, 'un', 0);
    lst = lst(~cellfun('isempty',lst));

    whichFace = randi(length(lst));
    dirStr = (strcat(dirStr, lst(whichFace), filesep, emotion, filesep)); %Navigate to random subject's folder of this gender and race
    dirStr = dirStr{1};

    tempd = dir(dirStr);
    folders = {tempd.name}';

    % Exclude hidden files
    lst = cellfun(@(x)isempty((regexp(x, '^\.'))),folders, 'un', 0);
    lst = cellfun(@(x,y)x(x & y),folders, lst, 'un', 0);
    lst = lst(~cellfun('isempty',lst));

    dirStr = strcat(dirStr, lst{1}, filesep);

    d = dir(dirStr);

    % Exclude hidden files
    lst = arrayfun(@(x)isempty((regexp(x.name, '^\.'))), d, 'un', 0);
    lst = arrayfun(@(x,y)x.name(x.name & y),d, cell2mat(lst), 'un', 0);
    d = d(~cellfun('isempty',lst)); % d = range of faces



    neutralreps = 2; %number of neutral faces initially shown

    %makes random sequence
    rng('shuffle'); %resets random number generator
%     sequences = csvread('sequences.csv');
%     sz = size(sequences);
%     rseq = randi(sz(1));

    %sequence = sequences(rseq, :)
    [s, tempsequence] = sequencer(sequencelength, violationrate, reverseblocks, forwardblocks, repetitions);  
  
    % Show starting screen
    [screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter] = waittostart; %#ok % waittostart function 

    key = 'N'; % key is N for initial neutral faces
    img(1) = 0; %#ok
    responsetime = zeros(1,repetitions * reverseblocks); % blank vectors
    imgnum = zeros(1,repetitions * reverseblocks);
    imgnum(1) = ceil(length(d)/2); % neutral in the middle
    keyresponse = zeros(1,sequencelength);
    delta = 0; % amount up or down to change the mood
    totalblocks = reverseblocks + forwardblocks;
    reverse = true; % Always start with reverse learning. Switch after finishing reverseblocks


    for j = 1:totalblocks

        if j > reverseblocks
            reverse = false;
        end
        for i = 1:repetitions % how many sequences we want
           
            k = (i+(j-1)*repetitions);

            
            for numseq = 1:sequencelength % length of the sequence


%                 kk = k + numseq - 1;

               
                % Display faces
                [responsetime, imgnum, theImage, fname,keyresponse] = squares(s, numseq, d, key,sequencelength, window, screenXpixels, screenYpixels,  yCenter,responsetime, imgnum, keyresponse, k, delta, emotion,violationrate,j); %#ok % display function 

                WaitSecs(ISI) % Wait between faces
            end


            key = 'N';

            % Save results
            valence{k,:} = fname(5); %#ok
            totalResponseTime(k) = sum(responsetime); %#ok
            totalResponseTimeCell{k,:} = totalResponseTime(k); %#ok
            keyresponseCell{k,:} = transpose(keyresponse-29); %#ok % store keyresponse as a column vector
            imgCell{k,:} = fname; %#ok
            sequenceCell{k,:} = transpose(s(k).sequence); %#ok
            rightorwrongCell{k,:} = (keyresponseCell{k,:}==sequenceCell{k,:}); %#ok
            originalsequence{1,:}= transpose(tempsequence);%#ok
            WaitSecs(ITI - ISI) % subtract ISI because it already waited ISI
        end

        if j > 2 % After 2 blocks, determine valence of subsequent face

            baseline = (sum(responsetime(1:(repetitions * neutralreps * sequencelength)))) / neutralreps; %Avg of first 2 blocks
            [key, delta] = analyze(responsetime, j,repetitions,k, baseline, reverse,sequencelength);
        end

        WaitSecs(IBI); %Inter block interval
    end

    %Cell with all response times for keypresses

    totreps = length(responsetime) / sequencelength;
    for counter = 1 : totreps
        start = counter * sequencelength - (sequencelength-1);
        final = start + (sequencelength-1);
        responses = transpose(responsetime(start:final));
        responseTimeCell{counter,:} = responses; %#ok
    end

    datafile = strcat('subject_',subID); %makes filename for results

    % Save data
    
    save(datafile, 'responseTimeCell','totalResponseTimeCell', 'imgCell','valence', 'keyresponseCell', 'sequenceCell','rightorwrongCell', 'originalsequence');
    copyfile(strcat('subject_',subID,'.mat'),datafile);
    
    KbWait;
    sca;