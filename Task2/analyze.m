function key=analyze(responsetime, j, repetitions, k, baseline)

starti = responsetime((j - 1) * repetitions * 7);
endi = starti + (7 * repetitions);
totaltime = sum(starti : endi);

if j == 3 %After third block, compare to initial baseline
    
    if totaltime < baseline
        key = 'S';
    end
    if totaltime > baseline
        key = 'H';
    end
    if totaltime == baseline
        key = 'N';
    end
    
else %Otherwise, compare to previous block
    
    starti = responsetime((j - 2) * repetitions * 7);
    endi = starti + (7 * repetitions);
    baseline = sum(starti : endi);
    
    if totaltime < baseline
        key = 'S';
    end
    if totaltime > baseline
        key = 'H';
    end
    if totaltime == baseline
        key = 'N';
    end
end

