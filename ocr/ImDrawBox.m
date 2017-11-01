function rect = ImDrawBox(bw_image, n)
%
%    This function draws a bounding box around objects in a black and white
%    image.
%       
%       bw_image = a logical matrix containing pixel values
%       n = Number of connected elements to consider for boundary plotting.
%           If n is greater than the total number of objects in the
%           image, all the objects are tracked with a bounding box
%

    s = regionprops(bw_image, 'basic');
    c = [s.BoundingBox];
    if n > (numel(c) / 4)
        n = (numel(c) / 4);
    end
    if(~isempty(c))
        %{-
        c = reshape(c, [4, length(c) / 4])';
        xmin = floor(min(c(:, 1)));
        ymin = floor(min(c(:, 2)));
        idx = find(c(:, 1) == max(c(:, 1)));
        idx = idx(1);
%         idy = find(c(:, 2) == max(c(:, 2)));
        [~, idy] = max(c(:, 2) + c(:, 4));
        idy = idy(1);
        xwidth = c(idx, 1) + c(idx, 3) - xmin;
        ywidth = c(idy, 2) + c(idy, 4) - ymin;
%         rect = [floor(0.9*xmin), floor(0.95*ymin), ...
%             ceil(1.1*xwidth), ceil(1.3*ywidth)];
        rect = [xmin, ymin, xwidth, ywidth];
        figure(gcf);
        hold on;
        rectangle('Position', rect, 'EdgeColor', 'r');
        hold off;
        %}
        %{       
        for count = 1 : n
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
            c = c(5 : end);              
        end
        %}
    else
        rect = [0 0 0 0];
    end
end