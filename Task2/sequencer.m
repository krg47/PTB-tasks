function sequence=sequencer(maxconsecutive, sequencelength)

a=1;
while a>0   %if repeats longer than max consecutive allowed are found, it will make a new sequence
    
    sequence=randi([1 4], 1,7);
    run_starts = [0 find(diff(sequence) ~= 0)] + 1
    
    run_lengths = [diff(run_starts), length(sequence) - run_starts(end) + 1]
    a=find(run_lengths >maxconsecutive)
end