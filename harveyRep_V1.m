% harveyRep.m
%
%        $Id:$ 
%      usage: harveyRep()
%         by: cameron mckenzie
%       date: 10/07/15
%    purpose: Replicate Harvey Numerosity Experiment

function myscreen = harveyRep(testStimuli)



% check arguments
if ~any(nargin == [1])
  help taskTemplate
  return
end

% initalize the screen
myscreen = initScreen;

%testing flag
Testing = 1; %1 if we're not in the MRI set this flag

if Testing
    task{1}.waitForBacktick = 0; %don't wait for backticks from the scanner right now
else
    task{1}.waitForBacktick = 1; %if not testing wait for backticks!
end

% task parameters
task{1}.numTrials = 2;
task{1}.seglen = [0.3 0.45]; %specify segment lengths in seconds
task{1}.seglen = repmat([0.3 0.45],[1 size(testStimuli,1)]);
task{1}.randVars.stimuli = testStimuli;

%Each task is broken up into trials, each of which has the same structure
%in terms of segments. The number of segments is defined impicitly... you
%set flags on each segment for things like synchToVol, getResponse, with
%binary vectors of length N, where N is the number of segments and as long
%as you set them all correctly, it will just run the correct number of
%segments. The most basic thing you need to do is set the segment lengths.

% To set segment lengths, you can either use:
% task{1}.seglen = [t1 t2...], where t_n are segment lengths in seconds.

%OR you can set a minimum and a maximum segment length. This is helpful to
%temporally jitter trials to do event-related MRI or to prevent expectation
%effects in behavioral experiments.

% EG: I use the following settings in my experiment
% task{1}.segmin = [2 2]
% task{1}.segmin = [2 9]

%This means the first segment is always 2 seconds long and the second
%segment is anywhere from 2s to 9s, chosen randomly.


%synchToVol flags indicate whether the code will line up segments to volume
%acquisitions (eg, wait for a backtick from the scanner before moving on
%form the segment).
task{1}.synchToVol = zeros(1,10); %no synch at the moment

%getResponse indicates that the response callback should run during a
%particular segment
task{1}.getResponse = ones(2*size(testStimuli,1),1); %get response on every segment

%fixed stimulus parameters - any constants we need for the experiment go
%here. If a parameter gets only one value, it's a constant
task{1}.parameter.control = 1; %I think here we might put a flag for what
                            %control condition we want on this run, for now
                            %just a placeholder


%variable stimulus parameters. If more than one value is specified for a
%parameter, it is randomized across if the randomize flag is set
task{1}.random = 0; %set the flag not to randomize

task{1}.parameter.number = 1; %here we will put the actual numbers we are
    % using and possible other variables that define control condition, etc



%task{1}.randVars.calculated.response = nan; - just if we want responses
%we'll set up a variable to track them if we need to.



% initialize the task
for phaseNum = 1:length(task)
  [task{phaseNum} myscreen] = initTask(task{phaseNum},myscreen,@startSegmentCallback,@screenUpdateCallback,@getResponseCallback);
end

% init the stimulus
myscreen = initStimulus('stimulus',myscreen);




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main display loop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


phaseNum = 1;
while (phaseNum <= length(task)) && ~myscreen.userHitEsc
  % update the task
  [task myscreen phaseNum] = updateTask(task,myscreen,phaseNum);
  % flip screen
  myscreen = tickScreen(myscreen,task);
end


% if we got here, we are at the end of the experiment
myscreen = endTask(myscreen,task);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function that gets called at the start of each segment
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [task myscreen] = startSegmentCallback(task, myscreen)
    disp(['start segment ' num2str(task.thistrial.thisseg)]); 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function that gets called to draw the stimulus each frame
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [task myscreen] = screenUpdateCallback(task, myscreen)

    %we'll pull out what we actually want here...
%     x = [1 1];
%     y = [1 -2];
%     sz = [1.5 1.5];
    currStim = testStimuli{ceil(task.thistrial.thisseg/2),1};
    dotColor = testStimuli{ceil(task.thistrial.thisseg/2),2};
%global stimulus
% 
    % clear the screen to gray
    mglClearScreen([0.2 0.2 0.2]);
    % draw a red fixation X
    %mglLines2(-.5*mglGetParam('deviceWidth'),-.5*mglGetParam('deviceHeight'),.5*mglGetParam('deviceWidth'),.5*mglGetParam('deviceHeight'),1,[1 0 0]);
    %mglLines2(.5*mglGetParam('deviceWidth'),-.5*mglGetParam('deviceHeight'),-.5*mglGetParam('deviceWidth'),.5*mglGetParam('deviceHeight'),1,[1 0 0]);
    
    mglLines2(-5.5,-5.5,5.5,5.5,1,[1 0 0]);
    mglLines2(5.5,-5.5,-5.5,5.5,1,[1 0 0]);
    
    
if (mod(task.thistrial.thisseg,2) == 1) %happy trick - odd segments we draw
    % draw points with 50 roundness (polygon edges) and color black
    if dotColor == 1
        mglGluDisk(currStim(:,1), currStim(:,2), currStim(1,3),[1 1 1],50); %this is easy once we have matrix pulled out
    else
        mglGluDisk(currStim(:,1), currStim(:,2), currStim(1,3),[0 0 0],50); %this is easy once we have matrix pulled out
    end
end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function that gets called upon a subject response
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [task myscreen] = getResponseCallback(task, myscreen)

end
    



end



