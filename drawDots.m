function [ output_args ] = drawDots( descriptionMatrix )
%UNTITLED3 Summary of this function goes here
%   Draws dots in an mgl window with a red fixation cross, based on an Nx3
%   matrix describing x, y, and radius of each dot.

mglOpen;
mglVisualAngleCoordinates(20,[20 15]);%%Was originally 57 [40 30], probably scanner screen dims mgleditscreenparams and then initscreen
% clear the screen to gray
mglClearScreen([0.2 0.2 0.2]);
% draw a red fixation X
mglLines2(-.5*mglGetParam('deviceWidth'),-.5*mglGetParam('deviceHeight'),.5*mglGetParam('deviceWidth'),.5*mglGetParam('deviceHeight'),1,[1 0 0]);
mglLines2(.5*mglGetParam('deviceWidth'),-.5*mglGetParam('deviceHeight'),-.5*mglGetParam('deviceWidth'),.5*mglGetParam('deviceHeight'),1,[1 0 0]);
% draw points with 50 roundness (polygon edges) and color black
mglGluDisk(descriptionMatrix(:,1),descriptionMatrix(:,2),descriptionMatrix(1,3),[0 0 0],50);
mglFlush;

end