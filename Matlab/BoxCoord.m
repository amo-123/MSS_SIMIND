function [x1,x2,y1,y2] = BoxCoord(img,shape)
% Ask user to pick coordinates to ROI in image input
% Input:
% img : img data loaded for imshow compatible format
% shape : specify if the user requires a line(1) of a box (2) 
% Output:
% [x1,x2,y1,y2] = coordinates spanning the rectangular ROI
% Author: Ashley Morahan, UCL 
figure, 
imshow(imcomplement(img),[])

title('Select Two Points to span ROI')
if shape < 3
    [Y,X] = ginput(shape);
    
    XC = round(X);
    x1 = XC(1);
    if exist('XC(2)','var')
        x2 = XC(2);
    end
    
    YC = round(Y);
    y1 = YC(1);
    if exist('XC(2)','var')
        y2 = YC(2);
    end
end
end

