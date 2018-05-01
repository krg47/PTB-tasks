%Task 3

% Design

    % To launch, click "Run" in task3.m or call function task3 as in 
        % example below. 
    % Press the "=" key to start the experiment
    % A face will be randomly selected and displayed on either the right or
    % left side of the screen.
    % Another face will appear on the opposite side of the screen with a
    % shape around it.
    % Underneath the face surrounded by a shape, one of four questions will be randomly presented:
        % 1. Match Shape (Cognitive Easy); 
        % Two shapes will appear underneath the prompt, and the
        % test subject needs to match the shape.
        % 2. Even or Odd (Cognitive Hard); 
        % The words "Even" and "Odd" will
        % appear underneath the prompt, and the test subject needs to
        % determine if the shape has an odd or even number of sides or
        % vertices.
        % 3. Match Face (Emotional Easy);
        % Two faces will appear underneath the prompt, and the test subject
        % needs to select the exact face that matches.
        % 4. Match Emotion (Emotional Hard);
        % Two different faces will appear underneath the prompt, and the
        % subject needs to select the face that matches the emotion.
 
% Adjustable parameters:

    % Subject ID
    % Repetitions
    % ISI (Inter-Stimulus Interval)
    % Inter-Question Interval

    
% File/Directory Descriptions
    % Working directory should include these files/folders:
    % README.m - this document 
    % task3.m - main body of the task that calls other functions
    % userinput3.m - allows for input of adjustable parameters
    % waittostart.m - sets up the screen for display, and waits until "=" is pressed to begin the task
    % maketask.m - randomizes what type of face appears first
    % face1display.m - displays the first face
    % polygon.m - displays the second face with a surrounding shape
    % choicedisplay.m - displays the the questions and choices 

%Example Use
    subID = '1234';
    repetitions = 20;
    ISI = 1.25;
    ICI = 2.0;
   
    
    
    task3(subID, repetitions, ISI, ICI);
    