function [window, windowRect,screens, screenNumber, xCenter, yCenter] = waittostart
% Get the screen numbers==
screens = Screen('Screens');

% Select the external screen if it is present, else revert to the native
% screen
screenNumber = max(screens);

% Define black, white and grey=
white = WhiteIndex(screenNumber);
grey = [0 0 0];

% Open an on screen window and color it grey
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey); %th=e ===small screen was displaying some stuff weird so I swapp e=d it back

% Set the blend funciton for the screen
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

% Get the size of the on screen window in pixels=
% For help see: Screen WindowSize?
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Get the centre coordinate of the window in pixels
% For help see: help RectCenter=    =
[xCenter, yCenter] = RectCenter(windowRect);

% Draw text in the middle of the screen in Courier in white
Screen('TextSize', window, 80);
Screen('TextFont', window, 'Times');
DrawFormattedText(window, 'Waiting for Experiment to Start', 'center', 'center', white);

% Flip to the screen
Screen('Flip', window);


KbName('UnifyKeyNames');
    while KbCheck; end % Wait until all keys are released.
    while 1
        % Check the state of the keyboard.
        [keyIsDown,~,keyCode] = KbCheck;
        % If the user is pressing a key, then display its code number and name.
        if keyIsDown
            % Note that we use find(keyCode) because keyCode is an array.
            % See 'help KbCheck'
            %fprintf('You pressed key %i which is %s\n', find(keyCode), KbName(keyCode));
            v = find(keyCode);
            if v == 46
                break;
            end
            % If the user holds down a key, KbCheck will report multiple events.
            % To condense multiple 'keyDown' events into a single event, we wait until all
            % keys have been released.
        end
    end
    WaitSecs(0.5);