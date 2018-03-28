function sequence=sequencer(maxconsecutive)

%Code for making random sequence file
% for j  = 1:100
%     tempsequence = [];
%     for i=1:7
%         tempsequence(i) = randi(4);
%     end
%     dlmwrite('sequences.csv',tempsequence,'-append');
% end

maxconsecutive = 1
num = csvread('sequences.csv');
x = size(num);
i = 1;
while i < x(1)
    
    sequence=num(i,:);
    run_starts = [0 find(diff(sequence) ~= 0)] + 1
    
    run_lengths = [diff(run_starts), length(sequence) - run_starts(end) + 1]
    if (any(run_lengths > maxconsecutive))
        num(i,:) = [];
        i = i - 1;
    end
    x = size(num);
    i = i + 1;
    
end

dlmwrite('sequences.csv',num);