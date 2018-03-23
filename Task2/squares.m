function [responsetime, imgnum, theImage, fname, keyresponse, screencap] = squares(sequence, d, key,numseq,  window,  screenXpixels, screenYpixels, yCenter, responsetime, imgnum, keyresponse, k, delta, emotion)
%function to display squares and face

neutralIndex = 1; %first image is neutral

% When going from happy to sad, neutral face is in the middle
if emotion == 'HS' 
    neutralIndex = ceil(length(d)/2);
end

if key == 'N'
    
    if k > 1
        imgnum(k) = imgnum(k-1);
    else
        imgnum(k) = neutralIndex; %start neutral
    end
end

if key == 'S'
    
    if neutralIndex + delta >= length(d)
         imgnum(k) = length(d); %Show saddest possible image
    else
        imgnum(k)= neutralIndex + delta; %happier later
    %instead of adding 1, we should add %increase / 5
    %make sure that we dont escape the bounds
    end
end
if key == 'H'
    
    if neutralIndex + delta <= 1
         imgnum(k) = 1; %show the happiest (or most neutral) possible image
    else
        imgnum(k) = neutralIndex + delta;
    end
end



fpath = getfield(d(imgnum(k)), 'folder')
fname = getfield(d(imgnum(k)),'name')
theImage = imread(strcat(fpath, filesep, fname));

baseRect = [0 0 300 300]; %dimensions
squareXpos = [screenXpixels * 0.125 screenXpixels * 0.375 screenXpixels * .625 screenXpixels * .875]; % Screen X positions of our three rectangles
numSquares = length(squareXpos);

allRects = nan(4, 4);  % Make our rectangle coordinates
for j = 1:numSquares %j is placeholder for loop
    allRects(:, j) = CenterRectOnPointd(baseRect, squareXpos(j), yCenter);
end
penWidthPixels = 6; % Pen width for the frames

Screen('FillRect', window, [1 1 1], allRects, penWidthPixels); % Draw the rect to the screen

imageTexture = Screen('MakeTexture', window, theImage);
[s1, s2, s3] = size(theImage); %size of face
aspectRatio = s2 / s1; %find aspect ratio of face

heightScalers = .25; %scales everything down to .25 x
imageHeights = screenYpixels .* heightScalers;
imageWidths = imageHeights .* aspectRatio;

dstRects = zeros(4, 1);
sequence(numseq);

% Draw rectangles
theRect = [0 0 imageWidths(1) imageHeights(1)];
dstRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * (.25*sequence(numseq)-.125),...
    screenYpixels / 2);

Screen('DrawTextures', window, imageTexture, [], dstRects);
starttime = GetSecs;
Screen('Flip', window);

while KbCheck; %make sure keys are released
end
while 1
[keyIsDown,~,keyCode] = KbCheck;
if keyIsDown
    numseq;
    keyresponse(numseq) = find(keyCode);
    break;
end
end

endtime = GetSecs;

index = (k -1) * 7 + numseq
responsetime(index) = endtime - starttime

screencap = Screen('GetImage', window);

Screen('FillRect', window, [1 1 1], allRects, penWidthPixels);
Screen('Flip', window);