% computeModelResponse.m
%
%      usage: computeModelResponse(p,fitParams,stimulus)
%         by: guillaume riesen
%       date: 11/23/15
%    purpose: Calculates the response of a given RF model to a series of
%    stimuli
%
function modelResponse = computeModelResponse(p, fitParams, stimulus)

modelResponse = zeros(1,length(stimulus));
if(p.width<0)
    p.width=0;
end

for i=1:size(stimulus,1)
    if(stimulus(i)==20)
        modelResponse(i)=0;
    else
        modelResponse(i) = normpdf(stimulus(i),p.center,p.width)/100.;
    end
end

end