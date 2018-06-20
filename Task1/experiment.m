function [imgnum,sex,valence,response,responsetime,bias] = experiment(MaleNames, FemaleNames, d, repetitions, ISI, subID, prob, emotion) %made this a function so that the arguments can be changed more easily
%% -------- DESCRIPTION --------
% Function selects random names and faces from lists and displays next face
% depending on the button previously selected.

%% -------- INPUTS --------
% MaleNames = List of male names [string]
% FemaleNames = List of female names [string]
% d = variable to call directory [full path]
% repetitions = the number of faces that will appear for that subject [number, 0-160]
% ISI (Inter-Stimulus Inverval) = the time (seconds) between two faces [number, 0-3]
% prob = the probability of bias, how likely a certain emotion will appear [number, 0-1]
% emotion = what two emotions will show while the task is running [string, (NS,HS,NF)]

%% -------- OUTPUTS --------
% Outputs lists that provide the image number shown, the sex of the image,
% the response, the response time, and the randomly generated bias.

%% -------- EXAMPLE --------
% MaleNames 
% FemaleNames
% d = dir(d)
% subID = 1234
% repetitions = 80
% ISI = 1.25
% prob = 0.80
% emotion = NS

%% -------- FUNCTION --------
% Number of names
namenum = length(MaleNames);
switchingpoint = floor(repetitions / 2); % The point at which the pattern switches
facenumber = length(d);
d = dir(d);

% Get the screen numbers
screens = Screen('Screens');

% Select the external screen if it is present, else revert to the native screen
screenNumber = max(screens);

white = WhiteIndex(screenNumber);
grey = [0 0 0];

% Open an on screen window and color it grey
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey);

% Set the blend funciton for the screen
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

% Get the size of the on screen window in pixels
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Get the center coordinate of the window in pixels
[xCenter, yCenter] = RectCenter(windowRect);

% Draw text in the middle of the screen in Courier in white
Screen('TextSize', window, 80);
Screen('TextFont', window, 'Times');
DrawFormattedText(window, 'Waiting for Experiment to Start', 'center', 'center', white);

% Flip to the screen
Screen('Flip', window);

KbName('UnifyKeyNames');

while KbCheck; end % Wait until all keys are released.

while 1
    % Check the state of the keyboard.
    [keyIsDown,~,keyCode] = KbCheck;
    if keyIsDown
        v = find(keyCode);
        if v == 46 %if "=" is pressed
            break;
        end
    end
end

WaitSecs(ISI);

% Randomly choose left/right happy/sad
x = rand;
if x < .5
    H = 80; %left arrow key
    S = 79; %right arrow key
end
if x >= .5
    H = 79; %right arrow key
    S = 80; %left arrow key
end

faces = {d.name};
i = 0;

if x < 0.5
    bias = 'R';
elseif x >= 0.5
    bias = 'L';
end


while true %Make sure first face is neutral
    idx = randi(length(faces));
    fname = faces{idx};
    if fname(5) == 'N' || fname(5) == 'H'
        break;
    end
end

% Display first face
file = displayface(fname, d, window, namenum, MaleNames, FemaleNames, i, xCenter, screenYpixels, emotion);

% Make sure the same person's face is not shown again
if idx ~= 1 %If it's not the first face, check the face before it
    
    if faces{idx - 1}(1:4) == fname(1:4)
        faces{idx - 1} = '';
    end
    
elseif idx ~= length(faces)  %If it's not the last face, check the face after it
    
    if faces{idx + 1}(1:4) == fname(1:4)
        faces{idx + 1} = '';
    end
end

faces{idx} = ''; %Eliminate the used face

faces(cellfun('isempty',faces)) = []; %Clear out used faces



% Save first face data
imgnum{1} = str2num(strcat(file(3), file(4)));
sex{1} = file(2);
valence{1} = file(5);
group{1} = file(1);
names{1} = file(1:4);

Screen('Flip', window);

%****RECORD RESPONSE****
%response matrices M/F H/F L/R
i = 1;
while i < repetitions + 1
    
    % Switch left/right if at the switching point
    if i == switchingpoint
        %switches happy (or neutral) and sad
        if H == 79
            H = 80;
            S = 79;
        elseif H == 80
            H = 79;
            S = 80;
        end
    end
    
    starttime(i) = GetSecs;
    
    KbName('UnifyKeyNames');
    while KbCheck; end % Wait until all keys are released.
    while 1
        % Check the state of the keyboard
        [keyIsDown,~,keyCode] = KbCheck;
        
        % If the user is pressing a key, then display its code number and name.
        if keyIsDown
            endtime(i) = GetSecs;
            responsetime(i,:) = endtime(i) - starttime(i);
            
            % Note that we use find(keyCode) because keyCode is an array.
            v = find(keyCode);
            
            z = rand; %Random number to determine if the next face will follow the pattern
            if v == 80 || v == 79
                
                if (v == H && z<=prob) || (v == S && z > prob) %show neutral (or happy)
                   
                    if v == 80
                        response{i,:} ='L'; %record left or right
                    else
                        response{i,:} ='R';
                    end
                    
                    while true %Make sure face is positive (Happy or Neutral)
                        idx = randi(length(faces));
                        fname = faces{idx};
                        if fname(5) == 'N' || fname(5) == 'H'
                            break;
                        end
                    end
                    
                    %Display face
                    
                    file = displayface(fname, d, window, namenum, MaleNames, FemaleNames, i, xCenter, screenYpixels, emotion);
                    
                    % Make sure we don't show the same person's face twice
                    if idx ~= 1 %If it's not the first face, check the face before it
                        
                        if faces{idx - 1}(1:4) == fname(1:4)
                            faces{idx - 1} = '';
                        end
                    end
                    if idx ~= length(faces)  %If it's not the last face, check the face after it
                        
                        if faces{idx + 1}(1:4) == fname(1:4)
                            faces{idx + 1} = '';
                        end
                    end
                    
                    faces{idx} = '';
                    
                    faces(cellfun('isempty',faces)) = []; %Clear out used faces
                    
                    if length(faces) < 2 %There are no faces left
                        faces = {d.name}; % reset face list
                    end
                end
                
               if (v == S && z<=prob) || (v == H && z > prob) %Negative face next
                   
                    if v == 80
                        response{i,:} ='L'; %record left or right
                    else
                        response{i,:} = 'R';
                    end
                    
                    while true %Make sure face is negative (sad or fearful)
                        idx = randi(length(faces));
                        fname = faces{idx};
                        if fname(5) == 'S' || fname(5) == 'A'
                            break;
                        end
                    end
                    
                    %Display the face
                   
                    file = displayface(fname, d, window, namenum, MaleNames, FemaleNames, i, xCenter, screenYpixels, emotion);
                    
                    %Make sure we don't show the same person's face twice
                    if idx ~= 1 %If it's not the first face, check the face before it
                        
                        if faces{idx - 1}(1:4) == fname(1:4)
                            faces{idx - 1} = '';
                        end
                    end
                    if idx ~= length(faces)  %If it's not the last face, check the face after it
                        
                        if faces{idx + 1}(1:4) == fname(1:4)
                            faces{idx + 1} = '';
                        end
                    end
                    faces{idx} = '';
                    
                    faces(cellfun('isempty',faces)) = []; %Clear out used faces
                    
                    if length(faces) < 2 %There are no faces left
                        faces = {d.name}; % reset face list
                    end
              
                end
                WaitSecs(ISI);  %Wait time between faces
                
                if i < repetitions + 1   %only flip if not the last time
                    Screen('Flip', window);
                end
                
                starttime = GetSecs;
                
                break;
            end
        end
    end
    
    i = i + 1; % Iterate
    if i < repetitions + 1
        % Save face data
        imgnum{i,:} = str2num(strcat(file(3), file(4)));
        sex{i,:} = file(2);
        valence{i,:} = file(5);
        group{i,:} = file(1);
        names{i,:} = fname(1:4);
    end
    
    
    filename = strcat('subject_',subID,'.mat');
    save(filename,'group','imgnum','sex','valence','response','responsetime','names','bias');
    
end
KbStrokeWait;

% Clear the screen
sca;
end
