function [ newStim ] = addColorField( oldStim )
%This function takes a stimulus file as produced by generateNumStimuli.mat
%and adds a field to each entry which specifies the color of the dots on
%that trial. One is for white dots, zero for black. The dots will be white
%on ten percent of the trials.
newStim = oldStim;
for i=1:size(newStim,1)
    newStim{i,2} = rand(1);
    newStim{i,2} = (newStim{i,2}>.9);
end
end

