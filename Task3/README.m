% Task 3

% Design:

    % To launch the task, click "Run" in task3.m or call the function "task3" as in the example below. 
    % Press the "=" key to start the experiment, as prompted.
    % A face will be randomly selected and displayed on either the right or left side of the screen.
    % A brief pause called the Interstimulus Interval (ISI) will pass. 
    % Another face will appear on the opposite side of the screen with a shape around it.
    % Underneath the face surrounded by a shape, one of four prompts will be randomly presented:
        % 1. Match Shape (Cognitive Easy); 
            % Two shapes will appear underneath the prompt, and the
            % participant needs to match the shape.
        % 2. Even or Odd (Cognitive Hard); 
            % The words "Even" and "Odd" will appear underneath the prompt, 
            % and the participant needs to determine if the shape has
            % an odd or even number of sides.
        % 3. Match Face (Emotional Easy);
            % Two faces will appear underneath the prompt, and the test subject
            % needs to select the exact face that matches.
        % 4. Match Emotion (Emotional Hard);
            % Two different faces will appear underneath the prompt, and the
            % subject needs to select the face that matches the emotion.
    % To answer these prompts, the left and right arrow keys corresponds 
    % to the answers on their respective sides.
        % For example, when the "Even or Odd" prompt is presented, the words "Even" and "Odd" will be presented.
        % Press left for "Even" and right for "Odd."
    % The participant must obtain a certain accuracy to be considered for
    % analysis. 
 
% Adjustable parameters:

    % Subject ID
    % Repetitions
    % ISI (Inter-Stimulus Interval)
    % Inter-Question Interval

    
% File/Directory Descriptions
    % Working directory should include these files/folders:
        % README.m - This is the README. It's purpose is to guide
            % laboratories through the process of using this task.
        % task3.m - This is the main body of the program, and it calls all of the other functions.
        % userinput3.m - This allows for the input of adjustable parameters.
        % waittostart.m - This sets up the screen for display, and waits until "=" is pressed to begin the task. 
        % maketask.m - This randomizes what type of face appears first.
        % face1display.m - This displays the first face.
        % polygon.m - This displays the second face with a surrounding shape.
        % choicedisplay.m - This displays the the prompts and choices.
        % subject_1234.mat - This is example data output.
        % t3screenshot.mat - This is also example data output.
        % tasks.mat - This is also example data output.
        % Faces - This is a folder of all of the faces used in the task.
        % Shapes - This is a folder of all the shapes used in the task

% Example Use:
    subID = '1234';
    repetitions = 20;
    ISI = 1.25;
    ICI = 2.0;
   
    
    
    task3(subID, repetitions, ISI, ICI);
    