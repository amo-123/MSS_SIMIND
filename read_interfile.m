function [img] = read_interfile( fp, fn )
%Read interfile data
% Input: 
%       fp = file path
%       fn = file name 
% output:
%       img = image structure
% Number of bytes per pixel gives these data types 
    prec = { 'uchar', 'int16', '', 'single', '', '', '', 'double' };

    if ( nargin < 1 ), fp=''; end %no input given 
    if ( nargin < 2 ), [fn,fp]=uigetfile([fp '*.h00']); end % select fil from ui input     
    hdr = read_if_hdr( fp, fn ); % call fnc to create hdr str
% assign from hdr file
    img.fp = hdr.fp;
    img.fn = hdr.fn_dat;
    img.hdr = hdr;
    
    disp(['Reading file: ' img.fn])
    fid = fopen([img.fp '\' img.fn],'r');  ok = ( fid > (-1) ); % open file given the correct file type 
    if ( ~ok ), errordlg('Error opening file'); return; end
    
    img.dat = fread(fid,prod(hdr.dim),prec{hdr.n_byt}); % read file id with img size and pixel size
    fclose(fid);
    img.dat = reshape( img.dat, hdr.dim );

end
