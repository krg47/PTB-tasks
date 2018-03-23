function choicedisplay(t, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter)

%for testing a specific question
t.cogoremo='Emotional';
 t.easyorhard='Easy';
%end testing

if strcmp(t.cogoremo, 'Emotional') && strcmp(t.easyorhard,'Easy')
    
    questiontext{1} = 'Which face matches the face above?';
    
elseif strcmp(t.cogoremo,'Emotional') && strcmp(t.easyorhard,'Hard')
    
    questiontext{1} = 'Which face''s emotion matches the';
    questiontext{2} = 'face above?';
    
elseif strcmp(t.cogoremo, 'Cognitive') && strcmp(t.easyorhard, 'Easy')
    
    questiontext{1} = 'Which shape matches the shape above?';
    
elseif strcmp(t.cogoremo, 'Cognitive') && strcmp(t.easyorhard, 'Hard')
    
    questiontext{1} = 'Does the shape above have an odd';
    questiontext{2} = 'or even number of sides?';
    
end




sz = Screen('TextSize', window, 40) %80
white = WhiteIndex(screenNumber);
y = screenYpixels*.74

if t.startside == 'L'
    DrawFormattedText(window, questiontext{1}, screenXpixels / 2, y, white);
    if length(questiontext) > 1
        DrawFormattedText(window, questiontext{2}, screenXpixels / 2, y + 50, white);
    end
elseif t.startside == 'R'
    DrawFormattedText(window, questiontext{1}, 50,  y, white);
    if length(questiontext) > 1
        DrawFormattedText(window, questiontext{2}, 50, y + 50, white);
    end
end

%TODO: complete these if statements
if strcmp(t.cogoremo, 'Emotional')
    %         display choices (face images)
    
    if t.startside == 'L' %We are displaying the choices under the right side
        
        %           this doesn't work yet pls help
     
      facename=t.firstchoice;
        face = imread(strcat(['..' filesep 'Task3' filesep 'Faces' filesep ], facename));
        faceTexture = Screen('MakeTexture',window, face);
        [s1, s2, s3] = size(face); %size of face
        aspectRatio = s2 / s1; %find aspect ratio of face
        
        heightScalers = .25; %scales everything up/down
        faceHeights = screenYpixels .* heightScalers;
        faceWidths = faceHeights .* aspectRatio;
        theRect = [0 0 faceWidths(1) faceHeights(1)];
        
        %           need to work on positioning
        faceRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * .28, screenYpixels*.9);
        
        
        Screen('DrawTextures', window, faceTexture, [],faceRects);
        
         facename=t.secondchoice;
        face = imread(strcat(['..' filesep 'Task3' filesep 'Faces' filesep ], facename));
        faceTexture = Screen('MakeTexture',window, face);
        [s1, s2, s3] = size(face); %size of face
        aspectRatio = s2 / s1; %find aspect ratio of face
        
        heightScalers = .25; %scales everything up/down
        faceHeights = screenYpixels .* heightScalers;
        faceWidths = faceHeights .* aspectRatio;
        theRect = [0 0 faceWidths(1) faceHeights(1)];
        
        faceRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * .28, screenYpixels*.9);
         Screen('DrawTextures', window, faceTexture, [],faceRects);
           Screen('Flip',window,[],1);
           
    elseif t.startside == 'R' %We are displaying the choices under the left side
      
      facename=t.firstchoice;
        face = imread(strcat(['..' filesep 'Task3' filesep 'Faces' filesep ], facename));
        faceTexture = Screen('MakeTexture',window, face);
        [s1, s2, s3] = size(face); %size of face
        aspectRatio = s2 / s1; %find aspect ratio of face
        
        heightScalers = .25; %scales everything up/down
        faceHeights = screenYpixels .* heightScalers;
        faceWidths = faceHeights .* aspectRatio;
        theRect = [0 0 faceWidths(1) faceHeights(1)];
        
        %           need to work on positioning
        faceRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * .72, screenYpixels*.9);
        
        
        Screen('DrawTextures', window, faceTexture, [],faceRects);
        
           Screen('Flip',window,[],1);
        %             faceRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * .72, screenYpixels*.4);
        %             Screen('DrawTextures', window, faceTexture, [],faceRects);
    end
    

    
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
    
    if t.startside == 'L'%We are displaying the choices under the right side
        
        firstchoice=t.firstchoice;
        
%         shapename=strcat('../Task3/Shapes/',num2str(numsides),'.PNG');
% 
%         shape=imread(shapename);
%         
%         shapeTexture = Screen('MakeTexture', window, shape);
%         
%         [s1, s2, s3] = size(shape); %size of face
%         aspectRatio = s2 / s1; %find aspect ratio of face
%         
%         heightScalers = .58;
%         shapeHeights = screenYpixels .* heightScalers;
%         shapeWidths = shapeHeights .* aspectRatio;
%         
%         dstRects = zeros(4, 1);
%         faceRects = zeros(4, 1);
%         
%         theRect = [0 0 shapeWidths(1) shapeHeights(1)]
% 
%         % heightScalers = .6; %scales everything up/down
% 
%         theRect = [0 0 shapeWidths(1) shapeHeights(1)]
% 
%         if t.startside == 'R' && numsides ~= 3
%             dstRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * .28, screenYpixels*.4);
%         elseif t.startside == 'L' && numsides ~= 3
%             dstRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * .72, screenYpixels*.4);
%         end
        
        secondchoice=t.secondchoice;
        
%         shapename=strcat('../Task3/Shapes/',num2str(numsides),'.PNG');
% 
%         shape=imread(shapename);
%         
%         shapeTexture = Screen('MakeTexture', window, shape);
%         
%         [s1, s2, s3] = size(shape); %size of face
%         aspectRatio = s2 / s1; %find aspect ratio of face
%         
%         heightScalers = .58;
%         shapeHeights = screenYpixels .* heightScalers;
%         shapeWidths = shapeHeights .* aspectRatio;
%         
%         dstRects = zeros(4, 1);
%         faceRects = zeros(4, 1);
%         
%         theRect = [0 0 shapeWidths(1) shapeHeights(1)]
% 
%         % heightScalers = .6; %scales everything up/down
% 
%         theRect = [0 0 shapeWidths(1) shapeHeights(1)]
% 
%         if t.startside == 'R' && numsides ~= 3
%             dstRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * .28, screenYpixels*.4);
%         elseif t.startside == 'L' && numsides ~= 3
%             dstRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * .72, screenYpixels*.4);
%         end
        
        DrawFormattedText(window, firstchoice, screenXpixels*.75,  screenYpixels*.25, white);
        DrawFormattedText(window, secondchoice, screenXpixels*.5,  screenYpixels*.25, white);
        
        
    elseif t.startside == 'R'%We are displaying the choices under the left side
        
        
        firstchoice=t.firstchoice;
        secondchoice=t.secondchoice;
        DrawFormattedText(window, firstchoice, screenXpixels*.5,  screenYpixels*.25, white);
        DrawFormattedText(window, secondchoice, screenXpixels*.25,  screenYpixels*.25, white);
    end
    
     Screen('Flip',window,[],1);
 %************************************************************    
    
elseif strcmp(t.cogoremo, 'Cognitive') && strcmp(t.easyorhard, 'Hard')
    %         display choices "even" and "odd"
    if t.startside == 'L' %We are displaying the choices under the right side
        
        DrawFormattedText(window, 'Even', screenXpixels/2,  screenYpixels*.9, white);
        DrawFormattedText(window, 'Odd', screenXpixels*.72, screenYpixels*.9, white);
        
    elseif t.startside == 'R' %We are displaying the choices under the left side
        
        DrawFormattedText(window, 'Even', 100,  screenYpixels*.9, white);
        DrawFormattedText(window, 'Odd', screenXpixels*.2,  screenYpixels*.9, white);
        
    end
    
    Screen('Flip', window, [], 1);


   
end


%checks key response
starttime=GetSecs;
%     starttime(i) = GetSecs;
    
    KbName('UnifyKeyNames');
    while KbCheck; end % Wait until all keys are released.
    while 1
        % Check the state of the keyboard
        [keyIsDown,~,keyCode] = KbCheck;
        
        % If the user is pressing a key, then display its code number and name.
        if keyIsDown
            endtime = GetSecs;
            responsetime = endtime - starttime;
            
            % Note that we use find(keyCode) because keyCode is an array.
            v = find(keyCode);
            break;
        end
    end
   
        if v==80
            response='L'
           
        elseif v==70
            response='R'
     
        end

%     if t.startside == 'R'
%         faceRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * .28, screenYpixels*.4);
%     elseif t.startside == 'L'
%         faceRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * .72, screenYpixels*.4);
%     end
%
%    TODO: display answer choices below the question tex


end
