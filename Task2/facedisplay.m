function [responsetime, imgnum] = facedisplay(d, key, i, img, window)
%% -------- DESCRIPTION --------
% Function determines the valence of the next face that should be shown,
% scales it appropriately, and positions it when appropriate.

%% -------- OUTPUTS --------
% This function outputs the response time between two images as well as the
% image that was shown. They are stored in respective arrays. 
% They may be accessed in either the subject_####.mat or the 
% subject_####_DD_MM_YYYY.mat

%% -------- FUNCTION --------
if key == 'N'
    imgnum = ceil(length(d)/2); % Keeps the valence the same if the average response time per sequence is the same as the total average (miracle)
end
if key == 'H'
    imgnum = img(i-1)+1; % More positive valences in the next sequence
end
if key == 'S'
    imgnum = img(i-1)-1; % More negative valence in the next sequence
end
fname = getfield(d(imgnum),'name'); %#ok
theImage = imread(fname);
imageTexture = Screen('MakeTexture', window, theImage);
[s1, s2, s3] = size(theImage); %#ok % Size of face
aspectRatio = s2 / s1; % Finds aspect ratio of face

heightScalers = 1.4; % Scales everything up/down
faceHeights = screenYpixels .* heightScalers;
faceWidths = faceHeights .* aspectRatio;
theRect = [0 0 faceWidths(1) faceHeights(1)]; %#ok



Screen('DrawTextures', window, imageTexture);
Screen('Flip', window);


starttime = GetSecs;
for i = 1:length(sequence) % Loop checks all of keys in sequence are pressed
    while 1
        % Check the state of the keyboard.
        [keyIsDown, ~, keyCode] = KbCheck;
        if keyIsDown
            v = find(keyCode);
            if v == sequence(i)
                break;
            end
        end
    end
    
    
end
endtime = GetSecs;
responsetime = endtime - starttime;