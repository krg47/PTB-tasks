%Kristen notes :
%When you were doing ceil(.5*x) it was cutting the image number in half and
%making it favor the first half of the faces which were female 

% x = {d.name}';
% idx = randi(length(x));
% fname = x{idx};
% lst = ~cellfun(@isempty,strfind(x,x{idx}(1:2)));
% x(lst) = [];

% we need to load the images as textures
% store gender info in the image structs if possible
% store image info in an array or matrix
% loop through the array[randomindex] ===and mark when an image has been used
% skip ones that have already been used

%As of now, it should show randomly one of the 8 faces (and that's about
%all I got)

%Left goes to neutral faces, right to negative. No image is exactly
%repeated, but a face might be. Also it's not currently checking if names
%are repeated, just that the same one is not displayed for both slots at
%the same time. We could also maybe condense the loop for left vs right by
%putting the image display after everything. Add black background and white
%text. Also responses should be in separate arrays for image number, sex,
%valence, response, and reaction time (reaction time is already separate)

%10/11/17. It is recording response matrices now. We have to make sure no
%faces are repeated and write the responses to a file. imgnum, gender, and
%valence have one extra response right now. %use dlmwrite for writing to
%file?

%10/12. Be able to code subject id at top and pass into function. Make sure
%the face isn't repeated. Can we repeat names? YES names dont matter for
%now


clear;
addpath /Volumes/gizmo/Workspace/Matt_r
addpath /Volumes/gizmo/Workspace/Matt_r/GitRepo/Faces
addpath(genpath('/Applications/MatlabAddOns/Psychtoolbox-3-PTB_Beta-2016-09-10_V3.0.13/'))
Screen('Preference', 'SkipSyncTests', 1);
sca;
PsychDefaultSetup(2);

ISI=.5;

trials=20;  %# of faces we want to show

d= '/Volumes/gizmo/Workspace/Matt_R/GitRepo/Faces/*.png';
%we can add use wildcards to separate male versus female faces

mid=fopen('MaleNames.txt');  %male name file id
fid=fopen('FemaleNames.txt'); %female name file id

M=textscan(mid, '%s', 'delimiter', '\n'); %scan in name files into structures
MaleNames=M{1};
fclose(mid);
F=textscan(fid, '%s', 'delimiter', '\n');
FemaleNames=F{1};
fclose(fid);
subID='ID'; 

prob = 1.0 %chance that right response will give fearful face
experiment(MaleNames, FemaleNames, d, trials, ISI, subID, prob);

function [imgnum,gender,valence,response,responsetime] = experiment(MaleNames, FemaleNames, d, trials, ISI, subID, prob) %made this a function so that the arguments can be changed more easily
namenum = length(MaleNames);
facenumber = length(d);
d = dir(d);


% Get the screen numbers==
screens = Screen('Screens');

% Select the external screen if it is present, else revert to the native
% screen
screenNumber = max(screens);

% Define black, white and grey=
white = WhiteIndex(screenNumber);
grey = [0 0 0];

% Open an on screen window and color it grey
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey); %th=e ===small screen was displaying some stuff weird so I swapp e=d it back

% Set the blend funciton for the screen
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

% Get the size of the on screen window in pixels=
% For help see: Screen WindowSize?
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Get the centre coordinate of the window in pixels
% For help see: help RectCenter=    =
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
    % If the user is pressing a key, then display its code number and name.
    if keyIsDown
        % Note that we use find(keyCode) because keyCode is an array.
        % See 'help KbCheck'
        %fprintf('You pressed key %i which is %s\n', find(keyCode), KbName(keyCode));
        v=find(keyCode);
        if v==46
            break;
        end
        % If the user holds down a key, KbCheck will report multiple events.
        % To condense multiple 'keyDown' events into a single event, we wait until all
        % keys have been released.
    end
end
WaitSecs(0.5);


faces = {d.name}';
i = 0;
ranvar=randi(namenum); %take random integer from number of faces, ceil because 2 faces per number

fname = faces{ranvar};
file = displayface(fname, d, window, namenum, MaleNames, FemaleNames, i, xCenter, screenYpixels);



imgnum(1) = str2num(strcat(file(1), file(2)));
gender{1} = file(3);
valence{1} = file(9);

lst = ~cellfun(@isempty,strfind(faces,faces{ranvar}(1:2)));
faces(lst) = [];



Screen('Flip', window);



%******RECORD RESPONSE***************
%response matrices M/F H/F L/R
i=1;
while i<trials + 2
    starttime(i)=GetSecs;
    
    
    
    KbName('UnifyKeyNames');
    while KbCheck; end % Wait until all keys are released.
    while 1
        % Check the state of the keyboard.
        
        [keyIsDown,~,keyCode] = KbCheck;
        
        % If the user is pressing a key, then display its code number and name.
        if keyIsDown
            endtime(i)=GetSecs;
            
            
            responsetime(i,:)=endtime(i)-starttime(i)
            
            % Note that we use find(keyCode) because keyCode is an array.
            % See 'help KbCheck'
            %fprintf('You pressed key %i which is %s\n', find(keyCode), KbName(keyCode));
            v=find(keyCode);
            
            z = rand; %Random double between 0 and 1
            if v==80 || v== 79
                
                if v==80 || (v==79 && z > prob) %left to neutral 
                    if v == 80
                        response{i,:}='L'; %record left or right==
                    else
                        response{i,:} = 'R';
                    end
                    test = 1;
                    while test == 1
                        
                       
                        idx = randi(length(faces));
                        fname = faces{idx};
                        
                        if fname(9) == 'H'
                            test = 0
                            lst = ~cellfun(@isempty,strfind(faces,faces{idx}(1:2)));
                            faces(lst) = [];
                        else
                            test = 1
                        end
                    end
                        
                    file = displayface(fname, d, window, namenum, MaleNames, FemaleNames, i, xCenter, screenYpixels);

                    
                                        
                end
                if v==79 && z < prob %right to negative
                    response{i,:} = 'R';
                    test = 1;
                    while test == 1
                        
                    
                        idx = randi(length(faces));
                        fname = faces{idx};
                        
                        if fname(9) == 'F'
                            test = 0;
                            lst = ~cellfun(@isempty,strfind(faces,faces{idx}(1:2)));
                            faces(lst) = [];
                        else
                            test = 1;
                        end
                    end
                        
                    file = displayface(fname, d, window, namenum, MaleNames, FemaleNames, i, xCenter, screenYpixels);

                    
                end
                WaitSecs(ISI);  %ISI
                
                if i<trials+1   %only flip if not the last time
                    Screen('Flip', window);
                end
                starttime=GetSecs;
                break;
            end
            
            
            % If the user holds down a key, KbCheck will report multiple events.
            % To condense multiple 'keyDown' events into a single event, we wait until all
            % keys have been released.=
        end
    end
    
    i=i+1;
    if i<trials+2
    imgnum(i,:) = str2num(strcat(file(1), file(2)))
    gender{i} = file(3)
    valence{i} = file(9)
    end
    
    
    filename=strcat('test_',subID,'.mat');
    save(filename,'imgnum','gender','valence','response','responsetime');
    
end


KbStrokeWait;

% Clear the screen=
sca;


end


function file = displayface(fname, d, window, namenum, MaleNames, FemaleNames, i, xCenter, screenYpixels)

    file=fname;  %gets name from structure

    theImage = imread(file);
    imageTexture = Screen('MakeTexture', window, theImage);
    Screen('DrawTextures', window, imageTexture);
    if file(3)=='M' %if file is male
        Screen('TextFont', window, 'Times');
        maleran(1)=randi(namenum); %random male name
        maleran(2)=randi(namenum);
        while maleran(2)==maleran(1)
            maleran(2)=randi(namenum);
        end
        a=MaleNames(maleran(1));  %temporary for names
        b=MaleNames(maleran(2));
        DrawFormattedText(window, a{1}, xCenter-530,...  %work on centering of names
            screenYpixels * 0.82, [1 1 1]);
        Screen('TextSize', window, 90);
        Screen('TextFont', window, 'Times');
        DrawFormattedText(window, b{1}, xCenter+300,...
            screenYpixels * 0.82, [1 1 1]);
    end

    if file(3)=='F'  %if file is female
        Screen('TextFont', window, 'Times');
        femaleran(1)=randi(namenum); %random female name
        femaleran(2)=randi(namenum);
        while femaleran(2)==femaleran(1)
            femaleran(2)=randi(namenum);
        end
        a=FemaleNames(femaleran(1));  %temporary for names
        b=FemaleNames(femaleran(2));

        DrawFormattedText(window, a{1}, xCenter-530,...
            screenYpixels * 0.82, [1 1 1]);
        Screen('TextSize', window, 90);
        Screen('TextFont', window, 'Times');
        a=FemaleNames(2);
        DrawFormattedText(window, b{1}, xCenter+300,...
            screenYpixels * 0.82, [1 1 1]);
    end


end

