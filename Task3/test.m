%for testing
numsides=4;
tmp=2;
t.firstface='AM13HAS.JPG';
%end testing

% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);

% Get the screen numbers
screens = Screen('Screens');

% Draw to the external screen if avaliable
screenNumber = max(screens);


% Define black and white
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

% Open an on screen window
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);

% Get the size of the on screen window
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect);

shapename=strcat('../Task3/Shapes/',num2str(numsides),'.PNG');

shape=imread(shapename);

shapeTexture = Screen('MakeTexture', window, shape);


[s1, s2, s3] = size(shape); %size of face
aspectRatio = s2 / s1; %find aspect ratio of face

heightScalers = .6; %scales everything up/down
shapeHeights = screenYpixels .* heightScalers;
shapeWidths = shapeHeights .* aspectRatio;

dstRects = zeros(4, 1);
faceRects = zeros(4, 1);

theRect = [0 0 shapeWidths(1) shapeHeights(1)];

if tmp==1&&numsides~=3
dstRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * .28, screenYpixels*.4);
elseif tmp==2&&numsides~=3
dstRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * .72, screenYpixels*.4);
end

%adjust y coord for triangles
if tmp==1&&numsides==3
dstRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * .28, screenYpixels*.29);
elseif tmp==2&&numsides==3
dstRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * .72, screenYpixels*.29);
end

Screen('DrawTextures', window, shapeTexture, [], dstRects);

facename=t(1).firstface;
face=imread(strcat('../Task3/Faces/',facename));
faceTexture=Screen('MakeTexture',window, face);
[s1, s2, s3] = size(face); %size of face
aspectRatio = s2 / s1; %find aspect ratio of face

heightScalers = .36; %scales everything up/down
faceHeights = screenYpixels .* heightScalers;
faceWidths = faceHeights .* aspectRatio;
theRect = [0 0 faceWidths(1) faceHeights(1)];
if tmp==1
faceRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * .28, screenYpixels*.4);
elseif tmp==2
faceRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * .72, screenYpixels*.4);
end

Screen('DrawTextures', window, faceTexture, [],faceRects);


%Screen('DrawDots', window, [.5*screenXpixels .5*screenYpixels], 20, [1 0
%0], [], 2); %can test centering with dots

% Flip to the screen
a='FLIP HERE'
Screen('Flip', window);

% Wait for a key press
KbStrokeWait;

% Clear the screen
sca;