function [responsetime, imgnum, theImage, fname]=squares(sequence, d, key,numseq, img, screens, screenNumber, black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter, responsetime, imgnum,i)
%function to display squares and face

if key=='N'
    imgnum(i)=ceil(length(d)/2); %neutral in the middle
end
if key == 'H'
    imgnum(i)=imgnum(i-1)+1; %happier later
end
if key == 'S'
    imgnum(i)=imgnum(i-1)-1; %sad earlier
end

fname=getfield(d(imgnum(i)),'name');
theImage = imread(fname);
fname=getfield(d(imgnum(i)),'name');
theImage = imread(fname);

baseRect = [0 0 300 300]; %dimensions
squareXpos = [screenXpixels * 0.125 screenXpixels * 0.375 screenXpixels * .625 screenXpixels * .875]; % Screen X positions of our three rectangles
numSquares = length(squareXpos);

allRects = nan(4, 4);  % Make our rectangle coordinates
for j = 1:numSquares %j is placeholder for loop
    allRects(:, j) = CenterRectOnPointd(baseRect, squareXpos(j), yCenter);
end
penWidthPixels = 6; % Pen width for the frames

Screen('FrameRect', window, [1 1 1], allRects, penWidthPixels); % Draw the rect to the screen

imageTexture = Screen('MakeTexture', window, theImage);
[s1, s2, s3] = size(theImage); %size of face
aspectRatio = s2 / s1; %find aspect ratio of face

heightScalers = .25; %scales everything down to .25 x
imageHeights = screenYpixels .* heightScalers;
imageWidths = imageHeights .* aspectRatio;

dstRects = zeros(4, 1);
sequence(numseq);

theRect = [0 0 imageWidths(1) imageHeights(1)];
dstRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * (.25*sequence(numseq)-.125),...
    screenYpixels / 2);

Screen('DrawTextures', window, imageTexture, [], dstRects);
starttime=GetSecs;
Screen('Flip', window);

while 1
    % Check the state of the keyboard.
    [keyIsDown,~,keyCode] = KbCheck;
    if keyIsDown
        v = find(keyCode);
        if v == (sequence(numseq)+29)
            break;
        end
    end
end

endtime=GetSecs;
responsetime(numseq) = endtime - starttime;

%now have it go back to just squares so that face seems to "flash" on and
%off, this can not happen if ITI=0
Screen('FrameRect', window, [1 1 1], allRects, penWidthPixels);
Screen('Flip', window);