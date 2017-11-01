function ImDrawBox(bw_image, n)
%    This function draws a bounding box around objects in a black and white
%    image.
%       
%       bw_image = a logical matrix containing pixel values
%       n = Number of connected elements to consider for boundary plotting.
%           If n is greater than the total number of objects in the
%           image, all the objects are tracked with a bounding box

    s = regionprops(logical(bw_image(:,:,1)), 'basic');
    c = [s.BoundingBox];
    if n > (numel(c) / 4)
        n = (numel(c) / 4);
    end
    for count = 1 : n
        if(~isempty(c))
            x1 = ([c(1), c(1)]);
            y1 = ([c(2), c(2) + c(4)]);
            x2 = ([c(1), c(1) + c(3)]);
            y2 = ([c(2) + c(4), c(2) + c(4)]);
            x3 = ([c(1) + c(3), c(1) + c(3)]);
            y3 = ([c(2) + c(4), c(2)]);
            x4 = ([c(1) + c(3), c(1)]);
            y4 = ([c(2), c(2)]);
            line(x1, y1, 'Color', 'r');
            line(x2, y2, 'Color', 'r');
            line(x3, y3, 'Color', 'r');
            line(x4, y4, 'Color', 'r');            
        end
        c = c(5 : end);        
    end
end