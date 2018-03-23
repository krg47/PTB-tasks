function [subID, repetitions, ISI, emotion] = userinput

validInput = false;
if nargin < 10
    while ~validInput
        prompt = {'SubjectID:', 'Repetitions:', 'Inter-Stimulus Interval:', 'Emotion: (NS, SN, NF, FN, HS, or SH)'};
        dlg_title = 'Configure Task';
        num_lines = 1;
        
        % Default values       
        def = {'1234','20', '1.25', 'NS'}; %Default is Neutral/sad 
        answer = inputdlg(prompt, dlg_title, num_lines, def);
        
        if isempty(answer), return, end;
        
%          Input validation
        if str2num(answer{2}) <= 1
            uiwait(warndlg('Must have > 1 repetitions'));
        elseif isnan(str2double(answer{3}))
            uiwait(warndlg('Invalid ITI, ISI or IBI'));
       % elseif answer{4} ~= 'NS' && answer{4} ~= 'HS'
            %uiwait(warndlg('Invalid Emotion spectrum. Must be NS, NF, or HS'));
        else
            
%           Set values
            validInput = true;
            subID = answer{1};
            repetitions = str2num(answer{2});
            ISI = str2double(answer{3});
            emotion = answer{4};
        end
    end
end