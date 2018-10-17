function [imgnum,sex,valence,response,responsetime,bias] = experiment(MaleNames, FemaleNames, d, origRepetitions,flippedRepetitions, ISI, Duration, subID, prob, emotion) %made this a function so that the arguments can be changed more easily
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
% Outputs lists that provide the the biased key of that trial, which images were used,
% the names that were shown, the response of the experimentalist, the
% response time for each image, the sex of the image shown, and the emotion
%% -------- FUNCTION --------
% Number of names
namenum = length(MaleNames);
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

Screen('TextSize', window, 40);
Screen('TextFont', window, 'Times');
DrawFormattedText(window, 'The goal of this task is to choose a name that best fits a person''s face. \nYou will be shown a picture of a person''s face with two names below. \nPlease respond to the most suited name as quickly as you can. \nThis is not a memory task, and there are no correct or incorrect answers.\n Simply select the name that seems to better suit the person. \nTo select the name on the left, please press \nthe left arrow key on the keyboard with your left index finger.\n To select the name on the right, please press\n the right arrow key on the keyboard with your right index finger.\n Please respond while the face is displayed.\n New faces and names will follow. \nYou have a limited time to respond to each face.', 'center', 'center', white);

% Flip to the screen
Screen('Flip', window);

while KbCheck; end % Wait until all keys are released.

while 1
    % Check the state of the keyboard.
    [keyIsDown,~,keyCode] = KbCheck;
    if keyIsDown
        v = find(keyCode);
        if v == 46 % If "=" is pressed
            break;
        end
    end
end

% Draw text in the middle of the screen in Courier in white
Screen('TextSize', window, 80);
Screen('TextFont', window, 'Times');
DrawFormattedText(window, 'Press the left or right \n arrow keys with your \nleft and right pointer fingers,\n respectively, to match each \nface to one of the two\n names at the bottom.\n Press "=" to begin', 'center', 'center', white);

% Flip to the screen
Screen('Flip', window);

KbName('UnifyKeyNames');

while KbCheck; end % Wait until all keys are released.

while 1
    % Check the state of the keyboard.
    [keyIsDown,~,keyCode] = KbCheck;
    if keyIsDown
        v = find(keyCode);
        if v == 46 % If "=" is pressed
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
i = 1;

if x < 0.5
    bias = 'R';
elseif x >= 0.5
    bias = 'L';
end


while true % Make sure first face is neutral
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
imgnum{1} = str2double(strcat(file(3), file(4)));
sex{1} = file(2);
valence{1} = file(5);
group{1} = file(1);
names{1} = file(1:4);

Screen('Flip', window);

%****RECORD RESPONSE****
% Response matrices M/F H/F L/R
% Need to add in Duration, Can do this by using an if statement designating
% the program to record a NaN if not responding in time
i = 2;
while i < origRepetitions+flippedRepetitions + 2
    
    % Switch left/right if at the switching point
    if i == (origRepetitions+1)
        %switches happy (or neutral) and sad
        if H == 79
            H = 80;
            S = 79;
        elseif H == 80
            H = 79;
            S = 80;
        end
    end
    pressed = 0;
    starttime(i) = GetSecs;
    
    KbName('UnifyKeyNames');
    while KbCheck; end % Wait until all keys are released.
    
        while (GetSecs-starttime(i))<Duration
            [keyIsDown,~,keyCode] = KbCheck;
            if keyIsDown
                responsetime(i-1) = GetSecs-starttime(i);
                pressed = 1;
                break;
            end
        end
   
  
    
    
    
    if pressed == 0
        Screen('TextSize', window, 80);
        Screen('TextFont', window, 'Times');
        DrawFormattedText(window, 'Please answer as\nquickly as possible', 'center', 'center', white);
        Screen('Flip', window);
        responsetime(i-1) = NaN;
        WaitSecs(1); %leave message on screen for 3 sec
        
        while true % Make sure face is neutral
            idx = randi(length(faces));
            fname = faces{idx};
            tempname=names{i-1};
            tempsex=sex{i-1};
            tempval=valence{i-1};
            if fname(5) == tempval && fname(2)==tempsex
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
        
        
        
        
    elseif pressed==1
        
        
        
        % Note that we use find(keyCode) because keyCode is an array.
        v = find(keyCode)
        
        z = rand %Random number to determine if the next face will follow the pattern
        
        if (v == H && z<=prob) || (v == S && z > prob) %show neutral (or happy)
            
            if v == 80
                response{i-1,:} ='L'; % Record left or right
            else
                response{i-1,:} ='R';
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
                response{i-1,:} ='L'; %record left or right
            else
                response{i-1,:} = 'R';
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
        
        
    end
    
    
    WaitSecs(ISI);  %Wait time between faces
    
    if i < origRepetitions+flippedRepetitions + 1   %only flip if not the last time
        Screen('Flip', window);
    end
    
    starttime = GetSecs;
    
    
    
    if i < origRepetitions+flippedRepetitions + 1
        % Save face data
        responsetime
        if isnan(responsetime(i-1))
            imgnum{i,:} = str2num(strcat(file(3), file(4)));
            sex{i,:} = file(2);
            valence{i,:} = file(5);
            group{i,:} =file(1);
            names{i,:} = fname(1:4);
        else
            imgnum{i,:} = str2num(strcat(file(3), file(4)));
            sex{i,:} = file(2);
            valence{i,:} = file(5);
            group{i,:} = file(1);
            names{i,:} = fname(1:4);
        end
    end
    
    i = i + 1; % Iterate
    
end


filename = strcat('subject_',subID,'.mat');
save(filename,'group','imgnum','sex','valence','response','responsetime','names','bias');
KbStrokeWait;

% Clear the screen
sca;
end
