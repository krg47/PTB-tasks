function [ screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter] = waittostart

Screen('Preference', 'SkipSyncTests', 1);
sca;
PsychDefaultSetup(2);
screens = Screen('Screens'); % Get the screen numbers and screen setup
screenNumber = max(screens); 
white = WhiteIndex(screenNumber);
black = [0 0 0];
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black); %open black window
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
[xCenter, yCenter] = RectCenter(windowRect);

Screen('TextSize', window, 80);
Screen('TextFont', window, 'Times');
DrawFormattedText(window, 'Waiting for Experiment to Start', 'center', 'center', white);
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
        % waits until all keys have been released.
    end
end
WaitSecs(0.5); %delay before start