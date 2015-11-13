nPresentationsPerNum = 6;

setup = repmat([20],[1 16]);
up = 1:7;
up = repelem(up,nPresentationsPerNum);
down = fliplr(up);
flat = repmat([20],[1 36]);

cycle = [up,flat,down,flat];
numList = [setup,cycle,cycle,cycle];

