function myCleanupFun(vidObj, im)
close(vidObj);
close(im);
clc;
fprintf('Program Terminated\n');
end