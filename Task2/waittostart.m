function [ screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter] = waittostart
%% -------- DESCRIPTION --------
% Function creates and positions the words "Waiting for Experiment to
% Start" in the center of the screen. These words should be the verhy first
% thing to appear after the syncing process for PTB.

%% -------- FUNCTION --------
screens = Screen('Screens'); % Get the screen numbers and screen setup
screenNumber = max(screens); 
white = WhiteIndex(screenNumber);
black = [0 0 0];
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black); % Open black window
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
[xCenter, yCenter] = RectCenter(windowRect);

Screen('TextSize', window, 50);
Screen('TextFont', window, 'Times');
DrawFormattedText(window, 'In this task, four boxes will be presented on the screen.\n A face will appear in one of the four boxes.\n The goal of this task is to press the button that corresponds\n to the box where the face appeared as quickly as possible.\n Please use your right hand to respond. Use your\n index finger for the first button (1), \nyour middle finger for the second button (2),\n your ring finger for the third button (3),\n and your pinky finger (4) for the fourth button.\n The face will disappear quickly and will\n appear at another location for a limited time.\n Continue this process until the task is over. \nPress the buttons as accurately and quickly as you can.', 'center', 'center', white);
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
DrawFormattedText(window, 'Place your right pointer, middle,\nring, and pinky fingers on the\nnumbers 1, 2, 3, & 4, respectively.\nPress the key corresponding to the box\nin which a face appears\nPress "=" to begin', 'center', 'center', white);
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