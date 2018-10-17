function [ screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter] = waittostart
%% -------- DESCRIPTION --------
% Function creates and positions the words "Waiting for Experiment to
% Start" in the center of the screen. These words should be the verhy first
% thing to appear after the syncing process for PTB.

%% -------- FUNCTION --------
Screen('Preference', 'SkipSyncTests', 1);
sca;
PsychDefaultSetup(2);
screens = Screen('Screens'); % Get the screen numbers and screen setup
screenNumber = max(screens); 

white = WhiteIndex(screenNumber);
black = [0 0 0];

[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black); % Open black window
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
[xCenter, yCenter] = RectCenter(windowRect);

Screen('TextSize', window, 40);
Screen('TextFont', window, 'Times');
DrawFormattedText(window, 'In this task, a face will appear on the left or right side of the screen. \n A face will appear in one of the four boxes. \n After a brief period of time, \n another face will appear on the other side of the screen. \n The new face will be inside a shape (for example, a rectangle, pentagon, etc.), \n and below the new face will be instructions and two answer choices. \n One on the left and one on the right. \n You will be asked to answer one of the following questions:\n (1) Match Shape: Select the shape that matches the one around the new face.\n (2) Count Corners: Count the number of corners on the shape, \n and choose whether it is ''odd'' or ''even''.\n (3) Match Face: Select the face that matches the new face\n (4) Match Emotion: Select the face that has \nthe matching emotion with the new face.\n To select the answer on the left, please press \n the left arrow key with your left index finger. \n To select the answer on the right, please press \n the right arrow key with your right index finger. \n You have a limited time to decide, so please press \n the button as quickly and accurately as possible.', 'center', 'center', white);
Screen('Flip', window);

KbName('UnifyKeyNames');
while KbCheck; end % Wait until all keys are released.
while 1
    % Check the state of the keyboard.
    [keyIsDown,~,keyCode] = KbCheck;
    % If the user is pressing a key
    if keyIsDown
        v = find(keyCode);
        if v == 46
            break;
        end
        % Waits until all keys have been released.
    end
end

Screen('TextSize', window, 80);
Screen('TextFont', window, 'Times');
DrawFormattedText(window, 'Press the left or right \n arrow keys with your \nleft and right pointer fingers,\n respectively, to answer \neach prompt.\n Press "=" to begin', 'center', 'center', white);
Screen('Flip', window);

KbName('UnifyKeyNames');
while KbCheck; end % Wait until all keys are released.
while 1
    % Check the state of the keyboard.
    [keyIsDown,~,keyCode] = KbCheck;
    % If the user is pressing a key
    if keyIsDown
        v = find(keyCode);
        if v == 46
            break;
        end
        % Waits until all keys have been released.
    end
end
WaitSecs(0.5); % Delay before start
end