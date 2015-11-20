load numList;
for i=1:2
    if i==1
        saveString = 'constantArea';
    else if i==2
            saveString = 'constantSize';
        end
    end
    for j=5:8
        stims = generateNumStimuli(numList,i);
        save(sprintf('%s%d.mat',saveString,j),'stims');
    end
end