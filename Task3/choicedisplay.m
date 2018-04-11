function t = choicedisplay(t, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter)

%for testing a specific question
% t.cogoremo='Emotional';
% t.easyorhard='Easy';
% t.firstchoice = 'AF01HAS.JPG';
% t.secondchoice = 'AF01HAS.JPG';
% t.startside = 'L';
%end testing

if strcmp(t.cogoremo, 'Emotional') && strcmp(t.easyorhard,'Easy')
    
    questiontext{1} = 'Match Face';
    
elseif strcmp(t.cogoremo,'Emotional') && strcmp(t.easyorhard,'Hard')
    
    questiontext{1} = 'Match Emotion';
    
elseif strcmp(t.cogoremo, 'Cognitive') && strcmp(t.easyorhard, 'Easy')
    
    questiontext{1} = 'Match Shape';
    
elseif strcmp(t.cogoremo, 'Cognitive') && strcmp(t.easyorhard, 'Hard')
    
    questiontext{1} = 'Odd or Even';
    
end

sz = Screen('TextSize', window, 60); %80
white = WhiteIndex(screenNumber);
y = screenYpixels*.73;
  
%Hey Kristen, so I went outside of TOM'S STUFF. I thought the questions
%were quite lengthy, so I asked Helmet what they should be and he changed
%them for me. Because of that the second part of the if and
%elseif statements directly below this were eliminated since there is no longer second lines of
%text. :D I'm kind of figuring this stuff out.



if t.startside == 'L' && not(strcmp(t.cogoremo,'Emotional') && strcmp(t.easyorhard,'Hard'))
    DrawFormattedText(window, questiontext{1}, screenXpixels * 0.61, y, white);
elseif t.startside == 'R' && not(strcmp(t.cogoremo,'Emotional') && strcmp(t.easyorhard,'Hard'))
    DrawFormattedText(window, questiontext{1}, screenXpixels * 0.17,  y, white);
end

if t.startside == 'L' && strcmp(t.cogoremo,'Emotional') && strcmp(t.easyorhard,'Hard')
    DrawFormattedText(window, questiontext{1}, screenXpixels * 0.58, y, white);
elseif t.startside == 'R' && strcmp(t.cogoremo,'Emotional') && strcmp(t.easyorhard,'Hard')
    DrawFormattedText(window, questiontext{1}, screenXpixels * 0.14,  y, white);
end

% TODO: complete these if statements
% TOM'S STUFF PART 2 ****************************************************
% This works when t.startside == 'L', please finish for t.startside == 'R'
% Line 70 and line 90 are really what need done
if strcmp(t.cogoremo, 'Emotional')
    %display choices (face images)
    
    %   Draw first face choice
    facename = t.firstchoice;
    face = imread(strcat(['..' filesep 'Task3' filesep 'Faces' filesep], facename));
    faceTexture = Screen('MakeTexture', window, face);
    [s1, s2, s3] = size(face); %size of face
    aspectRatio = s2 / s1; %find aspect ratio of face
    
    heightScalers = .25; %scales everything up/down
    faceHeights = screenYpixels .* heightScalers;
    faceWidths = faceHeights .* aspectRatio;
    theRect = [0 0 faceWidths(1) faceHeights(1)];
    
    %need to work on positioning
    if t.startside == 'L'
        faceRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * .60, screenYpixels*.87);
    elseif t.startside == 'R'
        faceRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * .15, screenYpixels*.87);
    end
         
    Screen('DrawTextures', window, faceTexture, [],faceRects);
    
    %   Draw second face choice
    facename = t.secondchoice;
    face = imread(strcat(['..' filesep 'Task3' filesep 'Faces' filesep ], facename));
    faceTexture = Screen('MakeTexture', window, face);
    [s1, s2, s3] = size(face); %size of face
    aspectRatio = s2 / s1; %find aspect ratio of face
    
    heightScalers = .25; %scales everything up/down
    faceHeights = screenYpixels .* heightScalers;
    faceWidths = faceHeights .* aspectRatio;
    theRect = [0 0 faceWidths(1) faceHeights(1)];
    
    if t.startside == 'L'
        faceRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * .85, screenYpixels*.87);
    elseif t.startside == 'R'
        faceRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * .4, screenYpixels*.87);
    end
    
    Screen('DrawTextures', window, faceTexture, [],faceRects);
    Screen('Flip',window,[], 0);
    
    
    % END OF TOM'S STUFF PART 2 ****************************************************
    
    
    
    %****************************TOM'S STUFF********************************
elseif strcmp(t.cogoremo, 'Cognitive') && strcmp(t.easyorhard, 'Easy')
    
    %       display choices (shape images)
    %       t.firstchoice -> number of sides on first choice shape
    %       t.secondchoice -> number of sides on second choice shape
    %       Look at polygon.m lines 9 - 44 on how to display the shape images.
    %       You will need to adjust so that they display where you want them (under the face w/ the shape)
    %
    %       Tom's note - I tried to replicate what was in polygon.m under
    %       firstchoice=t.firstchoice and secondchoice=t.secondchoice to test if that did anything, but it
    %       just gave me a bunch of errors. I commented it out.
    
    firstchoice = t.firstchoice;
    shapename = strcat('..', filesep, 'Task3', filesep, 'Shapes', filesep, num2str(firstchoice),'.PNG');
    
    [shape, ~, alpha]  = imread(shapename);
    
    shapeTexture1 = Screen('MakeTexture', window, shape);
    shape(:, :, 4) = alpha;
    shapeTexture2 = Screen('MakeTexture', window, shape);
    
    
    [s1, s2, s3] = size(shape); %size of face
    aspectRatio = s2 / s1; %find aspect ratio of face
    
    heightScalers = .15;
    
    if firstchoice == 3
        heightScalers = .12;
    end
    
    shapeHeights = screenYpixels .* heightScalers;
    shapeWidths = shapeHeights .* aspectRatio;
    
    dstRects = zeros(4, 1);
    shapeRects = zeros(4, 1);
    sizes = size(shape);
    
    secondchoice = t.secondchoice;
    
    shape2name = strcat('..', filesep, 'Task3', filesep, 'Shapes', filesep, num2str(secondchoice),'.PNG');
    
    [shape2, ~, alpha2]  = imread(shape2name);
    
    
    shape2Texture = Screen('MakeTexture', window, shape2);
    shape2(:, :, 4) = alpha2;
    
    [s12, s22, s32] = size(shape2); %size of face
    aspectRatio2= s22 / s12; %find aspect ratio of face
    
    heightScalers2 = .15;
    
    if secondchoice == 3
        heightScalers2 = .12;
    end
    
    shape2Heights = screenYpixels .* heightScalers2;
    shape2Widths = shape2Heights .* aspectRatio2;
    
    dstRects2 = zeros(4, 1);
    shape2Rects = zeros(4, 1);
    sizes2 = size(shape2);
    
    
    theRect = [0 0 shapeWidths(1) shapeHeights(1)];
    theRect2 = [0 0 shape2Widths(1) shape2Heights(1)];
    
    if t.startside == 'L'
        
        dstRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * .60, screenYpixels*.85);
        Screen('DrawTexture', window, shapeTexture2, [-1, -2, sizes(2) + 1, sizes(1) + 1], dstRects);
        
        dstRects2(:, 1) = CenterRectOnPointd(theRect2, screenXpixels * .83, screenYpixels*.85);
        Screen('DrawTexture', window, shape2Texture, [-1, -1, sizes2(2) + 1, sizes2(1) + 1], dstRects2);
        
    elseif t.startside == 'R'
        dstRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * .15, screenYpixels*.85);
        Screen('DrawTexture', window, shapeTexture2, [-1, -2, sizes(2) + 1, sizes(1) + 1], dstRects);
        
        dstRects2(:, 1) = CenterRectOnPointd(theRect2, screenXpixels * .40, screenYpixels*.85);
        Screen('DrawTexture', window, shape2Texture, [-1, -1, sizes2(2) + 1, sizes2(1) + 1], dstRects2);
        
    end
    
    Screen('Flip',window,[], 0);
    %************************************************************
    
elseif strcmp(t.cogoremo, 'Cognitive') && strcmp(t.easyorhard, 'Hard')
    %         display choices "even" and "odd"
    
    Screen('TextSize', window, 80);
    if t.startside == 'L' %We are displaying the choices under the right side
        
        DrawFormattedText(window, 'Even', screenXpixels * .53,  screenYpixels*.85, white);
        DrawFormattedText(window, 'Odd', screenXpixels * .80, screenYpixels*.85, white);
        
    elseif t.startside == 'R' %We are displaying the choices under the left side
        
        DrawFormattedText(window, 'Even', screenXpixels*.08,  screenYpixels*.85, white);
        DrawFormattedText(window, 'Odd', screenXpixels*.38,  screenYpixels*.85, white);
        
    end
    
    Screen('Flip', window, [], 0);
    Screen('TextSize', window, 40);
    
end

% checks key response
starttime = GetSecs;
%     starttime(i) = GetSecs;

KbName('UnifyKeyNames');
while KbCheck; end % Wait until all keys are released.
while 1
    % Check the state of the keyboard
    [keyIsDown,~,keyCode] = KbCheck;
    
    % If the user is pressing a key, then display its code number and name.
    if keyIsDown
        endtime = GetSecs;
        t.responsetime = endtime - starttime;
        
        % Note that we use find(keyCode) because keyCode is an array.
        v = find(keyCode);
        break;
    end
end

if v == 80
    t.response = 'L';
    if t.answerside == 'L'
        t.rightorwrong = 'Right';
    else
        t.rightorwrong = 'Wrong';
    end
    
elseif v == 70
    t.response = 'R';
    if t.answerside == 'R'
        t.rightorwrong = 'Right';
    else
        t.rightorwrong = 'Wrong';
    end
end
Screen('Flip', window, [], 0);

end