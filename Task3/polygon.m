function polygon(t, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter)

    numsides = t.numsides;

    % Define black and white
    white = WhiteIndex(screenNumber);
    black = BlackIndex(screenNumber);

    shapename = strcat('../Task3/Shapes/',num2str(numsides),'.PNG');
    shape = imread(shapename);
    shapeTexture = Screen('MakeTexture', window, shape);

    [s1, s2, s3] = size(shape); %size of face
    aspectRatio = s2 / s1; %find aspect ratio of face

    heightScalers = .58;
    shapeHeights = screenYpixels .* heightScalers;
    shapeWidths = shapeHeights .* aspectRatio;

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

    Screen('PutImage', window, shape, dstRects);
    facename = t.secondface;
    face = imread(strcat('../Task3/Faces/',facename));
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