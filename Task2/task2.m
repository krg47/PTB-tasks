% TODO:
% Make function to generate random sequence instead of drawing from
% sequence bank. No repeating numbers, use all 4 buttons in each
% sequence-DONE
% Get user input of lenth of sequence DONE
% Make sure markov thing happens before each repetition, not every time it
% shows a face DONE
% When we cycle a sequence that starts and ends with the same #, then they
% will be back to back (not sure if this matters) (ex. [4 1 3 2 4] becomes
% [1 3 2 4 4]) DONE
% Check data storage still works DONE
%should we store what original unshifted/unchanged sequence is?

function task2(subID, reverseblocks, forwardblocks, repetitions, ITI, ISI, IBI, sex, race, emotion, violationrate)

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

            %          Input validation
            if str2num(answer{2}) < 3
                uiwait(warndlg('Must be at least 3 Reverse learning blocks'));
            elseif (mod((str2num(answer{2}) + str2num(answer{3})), 2) ~= 0)
                uiwait(warndlg('Must be an even number of blocks'));
            elseif str2num(answer{4}) <= 1
                uiwait(warndlg('Must have > 1 repetitions'));
            elseif isnan(str2double(answer{5})) | isnan(str2double(answer{6})) | isnan(str2double(answer{7}))
                uiwait(warndlg('Invalid ITI, ISI or IBI'));
            elseif ~(or(strcmp(answer{8}, 'F'), strcmp(answer{8}, 'M')))
                uiwait(warndlg('Invalid Sex'));
            elseif answer{9} ~= 'W' & answer{9} ~= 'B'
                uiwait(warndlg('Invalid Race'));
            elseif answer{10} ~= 'NS' & answer{10} ~= 'NF' & answer{10} ~= 'HS'
                uiwait(warndlg('Invalid Emotion spectrum. Must be NS, NF, or HS'));
            elseif str2num(answer{11})>1 || str2num(answer{11})<0
                uiwait(warndlg('Invalid Violation Rate'));
            elseif str2num(answer{12})<4
                uiwait(warndlg('The sequence length must be at least 4'));
            else
                
                %           Set values
                validInput = true
                subID = answer{1};
                reverseblocks = str2num(answer{2});
                forwardblocks = str2num(answer{3});
                repetitions = str2num(answer{4});
                ITI = str2double(answer{5});
                ISI = str2double(answer{6});
                IBI = str2double(answer{7});
                sex = answer{8};
                race = answer{9};
                emotion = answer{10};
                violationrate = str2num(answer{11});
                sequencelength = str2num(answer{12});
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
    [screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter] = waittostart; %waittostart function

    key = 'N'; %key is N for initial neutral faces
    img(1) = 0;
    responsetime = zeros(1,repetitions * reverseblocks); %blank vectors
    imgnum = zeros(1,repetitions * reverseblocks);
    imgnum(1) = ceil(length(d)/2); %neutral in the middle
    keyresponse = zeros(1,sequencelength);
    delta = 0; %amount up or down to change the mood
    totalblocks = reverseblocks + forwardblocks;
    reverse = true; %Always start with reverse learning. Switch after finishing reverseblocks


    for j = 1:totalblocks

        if j > reverseblocks
            reverse = false;
        end
        for i = 1:repetitions %how many sequences we want
           
            k = (i+(j-1)*repetitions);

            
            for numseq = 1:sequencelength %length of the sequence


%                 kk = k + numseq - 1;

               
                %           Display faces
                [responsetime, imgnum, theImage, fname,keyresponse] = squares(s, numseq, d, key,sequencelength, window, screenXpixels, screenYpixels,  yCenter,responsetime, imgnum, keyresponse, k, delta, emotion,violationrate,j); %display function

                WaitSecs(ISI) %Wait between faces
            end


            key = 'N';

            %       Save results
            valence{k,:} = fname(5);
            totalResponseTime(k) = sum(responsetime);
            totalResponseTimeCell{k,:} = totalResponseTime(k);
            keyresponseCell{k,:} = transpose(keyresponse-29);  %store keyresponse as a column vector
            imgCell{k,:} = fname;
            sequenceCell{k,:} = transpose(s(k).sequence);
            rightorwrongCell{k,:} = (keyresponseCell{k,:}==sequenceCell{k,:});
            originalsequence{1,:}= transpose(tempsequence);
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
        responseTimeCell{counter,:} = responses;
    end

    datafile = strcat('subject_',subID); %makes filename for results

    % Save data
    
    save(datafile, 'responseTimeCell','totalResponseTimeCell', 'imgCell','valence', 'keyresponseCell', 'sequenceCell','rightorwrongCell', 'originalsequence');
    
    KbWait;
    sca;