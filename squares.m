function [responsetime, imgnum, theImage]=squares(sequence, d, key,i, img, window)

% Clear the workspace and the screen
sca;
close all;
clearvars;
%for scaling images http://peterscarfe.com/scaledimagedemo.html

[responsetime, imgnum, theImage] = facedisplay(sequence, d, key,i, img, window);


% Get the size of the on screen window
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect);

% Make a base Rect of 200 by 200 pixels
baseRect = [0 0 300 300];

% Screen X positions of our three rectangles
squareXpos = [screenXpixels * 0.125 screenXpixels * 0.375 screenXpixels * .625 screenXpixels * .875];
numSquares = length(squareXpos);

% Set the colors to Red, Green and Blue

% Make our rectangle coordinates
allRects = nan(4, 4);
for i = 1:numSquares
    allRects(:, i) = CenterRectOnPointd(baseRect, squareXpos(i), yCenter);
end

% Pen width for the frames
penWidthPixels = 6;

% Draw the rect to the screen
Screen('FrameRect', window, [1 1 1], allRects, penWidthPixels);

imageTexture = Screen('MakeTexture', window, theImage);
[s1, s2, s3] = size(theImage);
aspectRatio = s2 / s1;

heightScalers = .25;
imageHeights = screenYpixels .* heightScalers;
imageWidths = imageHeights .* aspectRatio;

% Number of images we will draw
numImages = numel(heightScalers);

% Make the destination rectangles for our image. We will draw the image
% multiple times over getting smaller on each iteration. So we need the big
% dstRects first followed by the progressively smaller ones
dstRects = zeros(4, numImages);
for i = 1:numImages
    theRect = [0 0 imageWidths(i) imageHeights(i)];
    dstRects(:, i) = CenterRectOnPointd(theRect, screenXpixels *.125,...
        screenYpixels / 2);
end

% Draw the image to the screen, unless otherwise specified PTB will draw
% the texture full size in the center of the screen.
Screen('DrawTextures', window, imageTexture, [], dstRects);
% Flip to the screen
Screen('Flip', window);

% Wait for a key press
KbStrokeWait;

% Clear the screen
sca;

