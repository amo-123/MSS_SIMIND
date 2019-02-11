function [FWHM] = SumAndFit(img,dir,x1,x2,y1,y2)
% Sum over image data
% Input
% img : the image data in the 2D matrix form
% dir : direction of sumation, 1 or 2 
% x1: starting x coordinate for data set
% x2: ending x coordinate for data set 
% y1: starting y coordinate for data set
% y2: ending y coordinate for data set 
% Output
% dat : data array
% Author: Ashley Morahan, UCL
if exist('x1','var') && exist('x2','var') && ~exist('y1','var') && ~exist('y1','var')
    dat = sum(img(x1:x2,:),dir);
elseif ~exist('x1','var') && ~exist('x2','var') && exist('y1','var') && exist('y1','var')
    dat = sum(img(:,y1:y2),dir);
elseif exist('x1','var') && exist('x2','var') && exist('y1','var') && exist('y1','var')
    dat = sum(img(x1:x2,y1:y2),dir);
else
    dat = sum(img,dir);
end

X = (0:length(dat)-1)*0.25;

[xData, yData] = prepareCurveData( X, dat);

% Set up fittype and options.
ft = fittype( 'gauss1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [0 -Inf 0];
opts.StartPoint = [0.162076065204019 43.5 1.94523334739479];

% Fit model to data.
[fitresult, ~] = fit( xData, yData, ft, opts );
% Plot fit with data.
% figure( 'Name', 'untitled fit 1' );
% h = plot( fitresult, xData, yData );
% legend( h, 'datx vs. X_dim', 'untitled fit 1', 'Location', 'NorthEast' );
% % Label axes
% xlabel X_dim
% ylabel datx
% grid on

order = fitresult.c1;
sigma = order/sqrt(2);
FWHM = 2*sqrt(2*(log(2)))*sigma;



