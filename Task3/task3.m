
function task3(subID, repetitions, ISI, ICI);

    [subID, repetitions, ISI, ICI, emotion] = userinput3;
    [screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter] = waittostart;

    d = ['Faces' filesep '*.JPG'];
    d = dir(d);
    faces = {d.name};
    allfaces = {d.name};
    tasks = {};

    if length(faces) < 6
        faces = allfaces;
    end

    % Creates all the tasks and shuffles their order
    for i = 1 : repetitions
        
        % disengage, cognitive, easy, 3-4 sides, H -> N
        [t, faces] = maketask('Disengage', 'H', 'N', 'Cognitive', 'Easy', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % disengage, cognitive, easy, 3-4 sides, S -> N
        [t, faces] = maketask('Disengage', 'S', 'N', 'Cognitive', 'Easy', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % disengage, cognitive, easy, 5-6 sides, H -> N
        [t, faces] = maketask('Disengage', 'H', 'N', 'Cognitive', 'Easy', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % disengage, cognitive, easy, 5-6 sides, S -> N
        [t, faces] = maketask('Disengage', 'S', 'N', 'Cognitive', 'Easy', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % disengage, cognitive, hard, 3-4 sides, H -> N
        [t, faces] = maketask('Disengage', 'H', 'N', 'Cognitive', 'Hard', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % disengage, cognitive, hard, 3-4 sides, S -> N
        [t, faces] = maketask('Disengage', 'S', 'N', 'Cognitive', 'Hard', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
       
        % disengage, cognitive, hard, 5-6 sides, H -> N
        [t, faces] = maketask('Disengage', 'H', 'N', 'Cognitive', 'Hard', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % disengage, cognitive, hard, 5-6 sides, S -> N
        [t, faces] = maketask('Disengage', 'S', 'N', 'Cognitive', 'Hard', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % disengage, emotional, easy, 3-4 sides, H -> N
        [t, faces] = maketask('Disengage', 'H', 'N', 'Emotional', 'Easy', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % disengage, emotional, easy, 3-4 sides, S -> N
        [t, faces] = maketask('Disengage', 'S', 'N', 'Emotional', 'Easy', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % disengage, emotional, easy, 5-6 sides, H -> N
        [t, faces] = maketask('Disengage', 'H', 'N', 'Emotional', 'Easy', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % disengage, emotional, easy, 5-6 sides, S -> N
        [t, faces] = maketask('Disengage', 'S', 'N', 'Emotional', 'Easy', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
      
        % disengage, emotional, hard, 3-4 sides, H -> N
        [t, faces] = maketask('Disengage', 'H', 'N', 'Emotional', 'Hard', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % disengage, emotional, hard, 3-4 sides, S -> N
        [t, faces] = maketask('Disengage', 'S', 'N', 'Emotional', 'Hard', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % disengage, emotional, hard, 5-6 sides, H -> N
        [t, faces] = maketask('Disengage', 'H', 'N', 'Emotional', 'Hard', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % disengage, emotional, hard, 5-6 sides, S -> N
        [t, faces] = maketask('Disengage', 'S', 'N', 'Emotional', 'Hard', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % engage, cognitive, easy, 3-4 sides, N -> H
        [t, faces] = maketask('Engage', 'N', 'H', 'Cognitive', 'Easy', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % engage, cognitive, easy, 3-4 sides, N -> S
        [t, faces] = maketask('Engage', 'N', 'S', 'Cognitive', 'Easy', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % engage, cognitive, easy, 5-6 sides, N -> H
        [t, faces] = maketask('Engage', 'N', 'H', 'Cognitive', 'Easy', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % engage, cognitive, easy, 5-6 sides, N -> S
        [t, faces] = maketask('Engage', 'N', 'S', 'Cognitive', 'Easy', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % engage, cognitive, hard, 3-4 sides, N -> H
        [t, faces] = maketask('Engage', 'N', 'H', 'Cognitive', 'Hard', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % engage, cognitive, hard, 3-4 sides, N -> S
        [t, faces] = maketask('Engage', 'N', 'S', 'Cognitive', 'Hard', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % engage, cognitive, hard, 5-6 sides, N -> H
        [t, faces] = maketask('Engage', 'N', 'H', 'Cognitive', 'Hard', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % engage, cognitive, hard, 5-6 sides, N -> S
        [t, faces] = maketask('Engage', 'N', 'S', 'Cognitive', 'Hard', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % engage, emotional, easy, 3-4 sides, N -> H
        [t, faces] = maketask('Engage', 'N', 'H', 'Emotional', 'Easy', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % engage, emotional, easy, 3-4 sides, N -> S
        [t, faces] = maketask('Engage', 'N', 'S', 'Emotional', 'Easy', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % engage, emotional, easy, 5-6 sides, N -> H
        [t, faces] = maketask('Engage', 'N', 'H', 'Emotional', 'Easy', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % engage, emotional, easy, 5-6 sides, N -> S
        [t, faces] = maketask('Engage', 'N', 'S', 'Emotional', 'Easy', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % engage, emotional, hard, 3-4 sides, N -> H
        [t, faces] = maketask('Engage', 'N', 'H', 'Emotional', 'Hard', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
       
        % engage, emotional, hard, 3-4 sides, N -> S
        [t, faces] = maketask('Engage', 'N', 'S', 'Emotional', 'Hard', '3-4', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % engage, emotional, hard, 5-6 sides, N -> H
        [t, faces] = maketask('Engage', 'N', 'H', 'Emotional', 'Hard', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];
        
        % engage, emotional, hard, 5-6 sides, N -> S
        [t, faces] = maketask('Engage', 'N', 'S', 'Emotional', 'Hard', '5-6', faces, allfaces, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter);
        tasks = [tasks, t];

    end
    
%   Shuffle order of tasks
    tasks = tasks(randperm(numel(tasks)));

%   Loop through tasks
    for i = 1 : length(tasks)
        tasks{i} = face1display(tasks{i}, screens, screenNumber,  black, window, windowRect, screenXpixels, screenYpixels, xCenter, yCenter, ISI, ICI);
        WaitSecs(ICI);
    end
    
    datafile = strcat('subject_',subID); %makes filename for results
    save(datafile, 'subID', 'tasks', 'repetitions', 'ISI', 'ICI');
    
    KbWait;
    sca;
end

%     TODO: 
%     Fix face choices displaying on left side
%     When the question takes up 2 lines, the second line is covered by the
%     face choices.
%     Do we want the screen to be blank in between questions?
%     Adjust spacing for even odd answer choices


%     Tom, if you want to try working on something, try to fill in the if
%     statements in choicedisplay.m, around line 80 it says Tom's stuff. I left some notes to
%     help you. To run the task, go to task3.m and hit run at the top.=
    
