% numberListFromStim.m
%
%      usage: numberListFromStim(stimulus, TR)
%         by: guillaume riesen
%       date: 11/20/15
%    purpose: extracts a vector of number values from a stimulus file used
%    to replicate the harvey et al numerosity experiment. This vector will
%    contain the number of dots shown during each TR, and can be used as a
%    'screen image' stand-in for population analysis.
%
function numberList = numberListFromStim(task, TR, nVols)

%Load the array of dot locations for each presentation from the task file

stim = task.randVars.stimuli;

%Extract the actual number of dots for each presentation

nums = zeros(size(stim,1),1);

for i=1:size(nums,1)
    nums(i) = size(stim{i},1);
end

%Find the average numerosity present during each TR (this may be silly)

numByMillisecond = reshape(repmat(nums',[750,1]),[],1);
numByTR = zeros(nVols,1);

for i=1:nVols
    numByTR(i) = mean(numByMillisecond(i*TR:i*TR+TR,1));
end

numberList = numByTR;
