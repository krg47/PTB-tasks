function file = displayface(fname, d, window, namenum, MaleNames, FemaleNames, i, xCenter, screenYpixels, emotion)
    
    file = fname;  %Get name from structure
    fread = strcat(emotion, filesep, fname);
    theImage = imread(fread);
    
    imageTexture = Screen('MakeTexture', window, theImage);
    Screen('DrawTextures', window, imageTexture);
    
    if file(2) == 'M' %if file is male
        Screen('TextFont', window, 'Times');
        maleran(1) = randi(namenum); %random male name
        maleran(2) = randi(namenum);
        while maleran(2) == maleran(1)
            maleran(2) = randi(namenum);
        end
        
        a = MaleNames(maleran(1));  %temporary for names
        b = MaleNames(maleran(2));
        DrawFormattedText(window, a{1}, xCenter-530,...  %centering names
            screenYpixels * 0.82, [1 1 1]);
        Screen('TextSize', window, 90);
        Screen('TextFont', window, 'Times');
        DrawFormattedText(window, b{1}, xCenter+300,...
            screenYpixels * 0.82, [1 1 1]);
    end
    
    if file(2) == 'F'  %if file is female
        Screen('TextFont', window, 'Times');
        femaleran(1) = randi(namenum); %random female name
        femaleran(2) = randi(namenum);
        while femaleran(2) == femaleran(1)
            femaleran(2) = randi(namenum);
        end
        a = FemaleNames(femaleran(1));  %temporary for names
        b = FemaleNames(femaleran(2));

        DrawFormattedText(window, a{1}, xCenter-530,...
            screenYpixels * 0.82, [1 1 1]);
        Screen('TextSize', window, 90);
        Screen('TextFont', window, 'Times');
        a = FemaleNames(2);
        DrawFormattedText(window, b{1}, xCenter+300,...
            screenYpixels * 0.82, [1 1 1]);
    end
end