function task3
%% -------- DESCRIPTION --------
% Function calls other functions for the Disengagement Task. 
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
% Other functions included: choicedisplay.m, face1display.m maketask.m,
% polygon.m, README.m, userinput3.m, waittostart.m

%% -------- INPUTS --------
% subID = the identification of the experimentalist [string, full path]
% repetitions = how many times faces/prompt will appear [number, 10-80]
% ISI = how much time passes between each face [number, 0-2]
% ICI = how much time passes between the second face and the prompt [number, 0-2]

%% -------- OUTPUTS --------
% Once the equal sign (=) is pressed, a face will appear on either the
% right or left side. After the ISI, another face will appear on the other
% side with a shape around it. After the IQI, a prompt will appear beneath
% the shape.
% From this process, a .mat file will be produced containing the ICI , the
% ISI, the number of repetitions, and the subject ID.
% subject_####.mat
% subject_####_DD_MM_YYYY.mat

%% -------- EXAMPLE --------
% subID = '1234'
% repetitions = 50
% ISI = 1.25
% ICI = 2

%% -------- FUNCTION --------
    [subID, repetitions, ISI, ICI] = userinput3;
    [screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter] = waittostart;

    d = ['Faces' filesep 'A*.JPG'];
    d = dir(d);
    faces = {d.name};
    allfaces = {d.name};
    tasks = {};

    if length(faces) < 6
        faces = allfaces;
    end

    % Creates all the tasks and shuffles their order
    for i = 1 : repetitions
        
        % Disengage, cognitive, easy, 3-4 sides, H -> N
        [t, faces] = maketask('Disengage', 'H', 'N', 'Cognitive', 'Easy', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t]; %#ok
        
        % Disengage, cognitive, easy, 3-4 sides, S -> N
        [t, faces] = maketask('Disengage', 'S', 'N', 'Cognitive', 'Easy', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t]; %#ok
        
        % Disengage, cognitive, easy, 5-6 sides, H -> N
        [t, faces] = maketask('Disengage', 'H', 'N', 'Cognitive', 'Easy', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t]; %#ok
        
        % Disengage, cognitive, easy, 5-6 sides, S -> N
        [t, faces] = maketask('Disengage', 'S', 'N', 'Cognitive', 'Easy', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t]; %#ok
        
        % Disengage, cognitive, hard, 3-4 sides, H -> N
        [t, faces] = maketask('Disengage', 'H', 'N', 'Cognitive', 'Hard', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t]; %#ok
        
        % Disengage, cognitive, hard, 3-4 sides, S -> N
        [t, faces] = maketask('Disengage', 'S', 'N', 'Cognitive', 'Hard', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t]; %#ok
       
        % Disengage, cognitive, hard, 5-6 sides, H -> N
        [t, faces] = maketask('Disengage', 'H', 'N', 'Cognitive', 'Hard', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t]; %#ok
        
        % Disengage, cognitive, hard, 5-6 sides, S -> N
        [t, faces] = maketask('Disengage', 'S', 'N', 'Cognitive', 'Hard', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t]; %#ok
        
        % Disengage, emotional, easy, 3-4 sides, H -> N
        [t, faces] = maketask('Disengage', 'H', 'N', 'Emotional', 'Easy', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t]; %#ok
        
        % Disengage, emotional, easy, 3-4 sides, S -> N
        [t, faces] = maketask('Disengage', 'S', 'N', 'Emotional', 'Easy', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t]; %#ok
        
        % Disengage, emotional, easy, 5-6 sides, H -> N
        [t, faces] = maketask('Disengage', 'H', 'N', 'Emotional', 'Easy', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t]; %#ok
        
        % Disengage, emotional, easy, 5-6 sides, S -> N
        [t, faces] = maketask('Disengage', 'S', 'N', 'Emotional', 'Easy', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t]; %#ok
      
        % Disengage, emotional, hard, 3-4 sides, H -> N
        [t, faces] = maketask('Disengage', 'H', 'N', 'Emotional', 'Hard', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t]; %#ok
        
        % Disengage, emotional, hard, 3-4 sides, S -> N
        [t, faces] = maketask('Disengage', 'S', 'N', 'Emotional', 'Hard', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t]; %#ok
        
        % Disengage, emotional, hard, 5-6 sides, H -> N
        [t, faces] = maketask('Disengage', 'H', 'N', 'Emotional', 'Hard', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t]; %#ok
        
        % Disengage, emotional, hard, 5-6 sides, S -> N
        [t, faces] = maketask('Disengage', 'S', 'N', 'Emotional', 'Hard', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t]; %#ok
        
        % Engage, cognitive, easy, 3-4 sides, N -> H
        [t, faces] = maketask('Engage', 'N', 'H', 'Cognitive', 'Easy', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t]; %#ok
        
        % Engage, cognitive, easy, 3-4 sides, N -> S
        [t, faces] = maketask('Engage', 'N', 'S', 'Cognitive', 'Easy', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t]; %#ok
        
        % Engage, cognitive, easy, 5-6 sides, N -> H
        [t, faces] = maketask('Engage', 'N', 'H', 'Cognitive', 'Easy', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t]; %#ok
        
        % Engage, cognitive, easy, 5-6 sides, N -> S
        [t, faces] = maketask('Engage', 'N', 'S', 'Cognitive', 'Easy', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t]; %#ok
        
        % Engage, cognitive, hard, 3-4 sides, N -> H
        [t, faces] = maketask('Engage', 'N', 'H', 'Cognitive', 'Hard', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t]; %#ok
        
        % Engage, cognitive, hard, 3-4 sides, N -> S
        [t, faces] = maketask('Engage', 'N', 'S', 'Cognitive', 'Hard', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t]; %#ok
        
        % Engage, cognitive, hard, 5-6 sides, N -> H
        [t, faces] = maketask('Engage', 'N', 'H', 'Cognitive', 'Hard', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t]; %#ok
        
        % Engage, cognitive, hard, 5-6 sides, N -> S
        [t, faces] = maketask('Engage', 'N', 'S', 'Cognitive', 'Hard', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t]; %#ok
        
        % Engage, emotional, easy, 3-4 sides, N -> H
        [t, faces] = maketask('Engage', 'N', 'H', 'Emotional', 'Easy', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t]; %#ok
        
        % Engage, emotional, easy, 3-4 sides, N -> S
        [t, faces] = maketask('Engage', 'N', 'S', 'Emotional', 'Easy', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t]; %#ok
        
        % Engage, emotional, easy, 5-6 sides, N -> H
        [t, faces] = maketask('Engage', 'N', 'H', 'Emotional', 'Easy', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t]; %#ok
        
        % Engage, emotional, easy, 5-6 sides, N -> S
        [t, faces] = maketask('Engage', 'N', 'S', 'Emotional', 'Easy', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t]; %#ok
        
        % Engage, emotional, hard, 3-4 sides, N -> H
        [t, faces] = maketask('Engage', 'N', 'H', 'Emotional', 'Hard', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t]; %#ok
       
        % Engage, emotional, hard, 3-4 sides, N -> S
        [t, faces] = maketask('Engage', 'N', 'S', 'Emotional', 'Hard', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t]; %#ok
        
        % Engage, emotional, hard, 5-6 sides, N -> H
        [t, faces] = maketask('Engage', 'N', 'H', 'Emotional', 'Hard', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t]; %#ok
        
        % Engage, emotional, hard, 5-6 sides, N -> S
        [t, faces] = maketask('Engage', 'N', 'S', 'Emotional', 'Hard', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t]; %#ok

    end
    
    % Shuffle order of tasks
    tasks = tasks(randperm(numel(tasks)));

    % Loop through tasks
    for i = 1 : length(tasks)
        tasks{i} = face1display(tasks{i}, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter, ISI, ICI);
        WaitSecs(ICI);
    end
    
    datafile = strcat('subject_',subID); % Makes filename for results
    save(datafile, 'subID', 'tasks', 'repetitions', 'ISI', 'ICI');
    copyfile(strcat('subject_',subID,'.mat'),datafile);
    sca;
end
