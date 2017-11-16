function key=analyze(responsetime, i, neutralreps, totalResponseTime,j,repetitions,k)
avgResponseTime= sum(totalResponseTime)/(i+((j-1)*repetitions));
if j==1 %first block
if k<(neutralreps+1) %start neutral to get initial reaction times
    key='N'
end
if k>1
    if (totalResponseTime(i) - avgResponseTime)>0
        key = 'H' %goes to happy
    end
    if (totalResponseTime(i) - avgResponseTime)<0
        key = 'S' %goes to sad
    end
    if (totalResponseTime(i) - avgResponseTime)==0  %what to do if equal?
        key = 'N' %goes to neutral
    end
end
end

if j==2 %second block
    if (totalResponseTime(i+repetitions) - avgResponseTime)>0
        key = 'S' %goes to happy
    end
    if (totalResponseTime(i+repetitions) - avgResponseTime)<0
        key = 'H' %goes to sad
    end
    if (totalResponseTime(i+repetitions) - avgResponseTime)==0  %what to do if equal?
        key = 'N' %goes to neutral
    end
end
    
end

