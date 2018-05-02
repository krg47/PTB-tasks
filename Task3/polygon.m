function polygon(t, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter)

    numsides = t.numsides;

    % Define black and white
    white = WhiteIndex(screenNumber);
    black = BlackIndex(screenNumber);

    shapename = strcat('..', filesep, 'Task3', filesep, 'Shapes', filesep, num2str(numsides), '.PNG');
    shape = imread(shapename);
    shapeTexture = Screen('MakeTexture', window, shape);

    [s1, s2, s3] = size(shape); %size of face
    aspectRatio = s2 / s1; %find aspect ratio of face

    heightScalers = .58;
    shapeHeights = screenYpixels .* heightScalers;
    shapeWidths = shapeHeights .* aspectRatio;
    
    
    if t.startside == 'R' && numsides == 4
        heightScalers = 0.58;
        shapeHeights = screenYpixels*0.90 .* heightScalers;
        shapeWidths = shapeHeights .* aspectRatio;
    elseif t.startside == 'L' && numsides == 4
        heightScalers = 0.58;
        shapeHeights = screenYpixels*0.90 .* heightScalers;
        shapeWidths = shapeHeights .* aspectRatio;
    end

    
    if t.startside == 'R' && numsides == 6
        heightScalers = 0.58;
        shapeHeights = screenYpixels*0.9 .* heightScalers;
        shapeWidths = shapeHeights .* aspectRatio;
    elseif t.startside == 'L' && numsides == 6
        heightScalers = 0.58;
        shapeHeights = screenYpixels*0.9 .* heightScalers;
        shapeWidths = shapeHeights .* aspectRatio;
    end
        

    dstRects = zeros(4, 1);
    faceRects = zeros(4, 1);

    theRect = [0 0 shapeWidths(1) shapeHeights(1)];

    if t.startside == 'R' && numsides ~= 3
        dstRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * .28, screenYpixels*.4);
    elseif t.startside == 'L' && numsides ~= 3
        dstRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * .72, screenYpixels*.4);
    end

    % adjust y coord for triangles
    if t.startside == 'R' && numsides == 3
        dstRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * .28, screenYpixels*.29);
    elseif t.startside == 'L' && numsides == 3
        dstRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * .72, screenYpixels*.29); %was .29
    end
    
    % adjust y coord for pentagons
    if t.startside == 'R' && numsides == 5
        dstRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * 0.28, screenYpixels * 0.36);
    elseif t.startside == 'L' && numsides == 5
        dstRects(:,1) = CenterRectOnPointd(theRect, screenXpixels * 0.72, screenYpixels * 0.36);
    end
    
    Screen('PutImage', window, shape, dstRects);
    facename = t.secondface;
    face = imread(strcat('..', filesep, 'Task3', filesep, 'Faces', filesep, facename));
    faceTexture = Screen('MakeTexture',window, face);
    [s1, s2, s3] = size(face); %size of face
    aspectRatio = s2 / s1; %find aspect ratio of face

    heightScalers = .36; %scales everything up/down
    faceHeights = screenYpixels .* heightScalers;
    faceWidths = faceHeights .* aspectRatio;
    theRect = [0 0 faceWidths(1) faceHeights(1)];
    
    if t.startside == 'R'
        faceRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * .28, screenYpixels*.4);
    elseif t.startside == 'L'
        faceRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * .72, screenYpixels*.4);
    end

    Screen('DrawTextures', window, faceTexture, [],faceRects);

    % Flip to the screen
    Screen('Flip', window, [], 1);

end