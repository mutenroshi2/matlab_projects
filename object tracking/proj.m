function [] = proj()
clc;
close all;
pause on;

% URL of the live video stream
%url = 'http://[2601:b:c582:4277:c2ee:fbff:fe32:a932]:8080/shot.jpg';
%url = 'http://10.0.0.12:8080/shot.jpg';
url = 'http://192.168.173.203:8080/shot.jpg';
%movieFrames = moviein();
vidObj = VideoWriter('movie.avi', 'Uncompressed AVI');
vidObj.FrameRate = 4;
open(vidObj);
index = 1;
im = figure('Name', 'Objct Tracking', 'Numbertitle', 'off');
finishup = onCleanup(@() myCleanupFun(vidObj, im));
a = 10;     % Initial value to counter url not found error
while(1)
    
    % The following try-catch block of code provides try again/quit 
    %   options in case the URL is invalid
    
    try
        ss1 = imread(url);
    catch
        clc;
        set(gcf,'Visible', 'off'); 
        if(a == 10)
            fprintf(['Video stream not detected at ' url '\n']);
            y = 1;
            n = 0;
            a = input('Wait for stream? (y/n): ');
            if(a)
                fprintf( ...
                    'Application will resume when streaming starts.\n');
                continue;
            else
                fprintf('Goodbye!\n');
                return;
            end
        else
            fprintf(['Video stream not detected at ' url '\n']);
            fprintf(['Application will resume when streaming starts.' ...
                '(Hit Ctrl+C to stop waiting)\n']);
        end
        continue;
    end
    
    figure(im);
    %set(gca,'nextplot','replacechildren');
    set(gcf,'Renderer','zbuffer');
    %pause(1 / 60);  % Wait a few milliseconds before capturing next frame
    ss2 = imread(url);
    
    % Frame Differencing
    d(:, :, 1) = imabsdiff(ss1(:, :, 1), ss2(:, :, 1));
    thresh = 0.05;                   % graythresh() gives poor results
    bw1 = (d >= thresh * 255);      % Thresholding the image
    bw1 = bwareaopen(bw1, 10, 8);   % Opening B/W image to remove 
                                    %   small objects
    se = strel('disk',4);           % Disk structuring element for dilation
    bw1 = imdilate(bw1, se);        % Dilating image to get better boundary
    imshow(ss2);
    title('Frame Differencing');
    hold on;
    ImDrawBox(bw1, 1);              % Refer to ImDrawBox documentation
    hold off;
    frame = getframe;
    writeVideo(vidObj, frame);
    %print(im,'-dpng','-r120',['im-' num2str(index)]);
    index = index + 1;
end
end