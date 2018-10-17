function [responsetime, imgnum, theImage, fname, keyresponse] = squares(s, numseq, d, key, sequencelength,  window,  screenXpixels, screenYpixels, yCenter, responsetime, imgnum, keyresponse, k, delta, emotion, ~,~)
%% -------- DESCRIPTION --------
% Function creates the squares in which the faces will appear. This
% function also outputs the faces into the designated squares determined by
% the sequence.

%% -------- FUNCTION --------
neutralIndex = 1; % First image is neutral

% When going from happy to sad, neutral face is in the middle
if emotion == 'HS' 
    neutralIndex = ceil(length(d)/2);
end

if key == 'N'
    
    if k > 1
        imgnum(k) = imgnum(k-1);
    else
        imgnum(k) = neutralIndex; % Start neutral
    end
end

if key == 'S'
    
    if neutralIndex + delta >= length(d)
         imgnum(k) = length(d); % Show saddest possible image
    else
        imgnum(k)= neutralIndex + delta; 
    end
end
if key == 'H'
    
    if neutralIndex + delta <= 1
         imgnum(k) = 1; % Show the most positive possible image
    else
        imgnum(k) = neutralIndex + delta;
    end
end



fpath = getfield(d(imgnum(k)), 'folder'); %#ok
fname = getfield(d(imgnum(k)),'name'); %#ok
theImage = imread(strcat(fpath, filesep, fname));

baseRect = [0 0 .22*screenXpixels .22*screenXpixels]; % Dimensions
squareXpos = [screenXpixels * 0.125 screenXpixels * 0.375 screenXpixels * .625 screenXpixels * .875]; % Screen X positions of our three rectangles
numSquares = length(squareXpos);

allRects = nan(4, 4);  % Make our rectangle coordinates
for squarecounter = 1:numSquares % j is placeholder for loop
    allRects(:, squarecounter) = CenterRectOnPointd(baseRect, squareXpos(squarecounter), yCenter);
end
penWidthPixels = 6; % Pen width for the frames

Screen('FillRect', window, [1 1 1], allRects, penWidthPixels); % Draw the rect to the screen

imageTexture = Screen('MakeTexture', window, theImage);
[s1, s2, s3] = size(theImage); %#ok %size of face
aspectRatio = s2 / s1; % Find aspect ratio of face

heightScalers = baseRect(3)/screenYpixels; % Scales everything down based on screen
imageHeights = screenYpixels .* heightScalers;
imageWidths = imageHeights .* aspectRatio;

dstRects = zeros(4, 1);


% Draw rectangles
theRect = [0 0 imageWidths(1) imageHeights(1)];



dstRects(:, 1) = CenterRectOnPointd(theRect, screenXpixels * (.25*s(k).sequence(numseq)-.125),...
    screenYpixels / 2);

Screen('DrawTextures', window, imageTexture, [], dstRects);
starttime = GetSecs;
Screen('Flip', window);

while KbCheck % Make sure keys are released
end
while 1
[keyIsDown,~,keyCode] = KbCheck;
if keyIsDown
    keyresponse(numseq) = find(keyCode);
    break;
end
end

endtime = GetSecs;

index = (k -1) * sequencelength + numseq;
responsetime(index) = endtime - starttime;



Screen('FillRect', window, [1 1 1], allRects, penWidthPixels);
Screen('Flip', window);