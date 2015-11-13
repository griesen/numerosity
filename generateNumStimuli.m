function [ trialSequence ] = generateNumStimuli( numList, controlType )
%UNTITLED4 Summary of this function goes here
%   Takes a list of numbers and uses generateDots.m to produce a cell array of randomized
%   figures with those numbers of dots and the controltype given;
%
%   Control type sets which variable is being kept constant:
%   1: Constant area (smaller dots for larger Ns)
%   2: Constant dot size
%   3: Constant circumference (smaller dots for larger Ns)

nStims = size(numList,2);
trialSequence = cell(nStims,1);
for i=1:nStims
    trialSequence{i}=generateDots(numList(i),controlType);
    if(mod(i,10)==0)
        i
    end
end
end

