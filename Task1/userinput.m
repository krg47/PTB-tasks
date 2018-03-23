function [subID, repetitions, ISI, prob, emotion] = userinput

validInput = false;
if nargin < 10
    while ~validInput
        prompt = {'SubjectID:', 'Repetitions:', 'Inter-Stimulus Interval:', 'Probability of Bias (0-1):', 'Emotion: (NS, NF, or HS)'};
        dlg_title = 'Configure Task';
        num_lines = 1;
        
        % Default values       
        def = {'1234','20', '1.25','1', 'NS'}; %Default is Neutral/sad 
        answer = inputdlg(prompt, dlg_title, num_lines, def)
        answer{5}~='NS'
        if isempty(answer), return, end;
        
%          Input validation
        if str2num(answer{2}) <= 1
            uiwait(warndlg('Must have > 1 repetitions'));
        elseif isnan(str2double(answer{3}))
            uiwait(warndlg('Invalid ITI, ISI or IBI'));
%         elseif (answer{5} ~= 'NS') & (answer{5} ~= 'NF') & (answer{5} ~= 'HS')
%             uiwait(warndlg('Invalid Emotion spectrum. Must be NS, NF, or HS'));
        else
            
%           Set values
            validInput = true;
            subID = answer{1};
            repetitions = str2num(answer{2});
            ISI = str2double(answer{3});
            prob = str2double(answer{4}); %chance that right response will give fearful face
            emotion = answer{5};
        end
    end
end

