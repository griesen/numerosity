function [ descriptionMatrix ] = generateDots( nDots, controlType )
%UNTITLED Summary of this function goes here
%   Produces an nDots x 3 matrix describing x, y, and radius for each dot
%   such that they roughly homogeneously cover an area with radius .75
%   degrees from the center of the screen.
%   Control type sets which variable is being kept constant:
%   1: Constant area (smaller dots for larger Ns)
%   2: Constant dot size
%   3: Constant circumference (smaller dots for larger Ns)

baseDotSize = .2;

if(controlType == 1)%Constant area
    dotSize = baseDotSize/sqrt(nDots);
elseif(controlType == 2)%Constant dot size
    dotSize = baseDotSize/2;
elseif(controlType == 3)%Constant circumference
    dotSize = 5*baseDotSize/nDots;
end

minSeparation = 1.5/sqrt(nDots)*.5; %Minimum allowable distance between dots - we're 
%placing n dots into a 1.5 degree square so a square array might have about 
%sqrt(n)/1.5 between each dot. The .75 is just to relax the standard and 
%decrease the amount of fail cases to sort through.


failed = true;
while failed
    xs = [rand(1)*1.5-.75];
    ys = [rand(1)*1.5-.75];
    if(nDots>1)
        for i=2:nDots
            failed = false;
            closest=0;
            failCount = 0;
            while closest<minSeparation%Generate sets of dot x and y positions until the closest pair isn't too close.
                xs = [xs,rand(1)*1.5-.75];
                ys = [ys,rand(1)*1.5-.75];
                pairs = nchoosek(1:i,2);
                dist = sqrt((diff(xs(pairs),1,2).^2 + diff(ys(pairs),1,2)).^2);
                closest = min(dist);
                if(closest<minSeparation)
                    xs = xs(1:i-1);
                    ys = ys(1:i-1);
                end
                failCount = failCount+1;
                if(failCount>1000)
                    failed = true;
                    break;
                end
            end
            if(failed)
                break;
            end
        end
    else
        failed = false;
    end
end

% closest=0;
% while closest<minSeparation %Generate sets of dot x and y positions until the closest pair isn't too close.
%     xs = rand(1,nDots)*1.5-.75;
%     ys = rand(1,nDots)*1.5-.75;
%     pairs = nchoosek(1:nDots,2);
%     dist = sqrt((diff(xs(pairs),1,2).^2 + diff(ys(pairs),1,2)).^2);
%     closest = min(dist);
% end

descriptionMatrix = [xs',ys',repmat(dotSize,[nDots 1])];

end

