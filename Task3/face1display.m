function face1display(t, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter, ISI, ICI)

a=t.startside

facename = t.firstface;
face=imread(strcat('../Task3/Faces/',facename));
faceTexture=Screen('MakeTexture',window, face);
[s1, s2, s3] = size(face); %size of face
aspectRatio = s2 / s1; %find aspect ratio of face

heightScalers = .36; %scales everything up/down
faceHeights = screenYpixels .* heightScalers;
faceWidths = faceHeights .* aspectRatio;
theRect = [0 0 faceWidths(1) faceHeights(1)];
if t.startside == 'L'
    faceRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * .28, screenYpixels*.4);
elseif t.startside == 'R'
    faceRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * .72, screenYpixels*.4);
end

Screen('DrawTextures', window, faceTexture, [],faceRects);

%Screen('DrawDots', window, [.5*screenXpixels .5*screenYpixels], 20, [1 0
%0], [], 2); %can test centering with dots

% Flip to the screen
a = 'FLIP HERE'
Screen('Flip', window, [], 1); % the 1 here means dont clear the screen when adding to it
WaitSecs(ISI);

polygon(t, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        WaitSecs(ISI);
        b='FLIP HERE'
choicedisplay(t, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
% Screen('Flip', window);

