function [hdr] = read_if_hdr( fp, fn )
% Read interfile header file
% This function is required to extract the metadata from the image 
% Input: 
%       fp = file path
%       fn = file name 
% output:
%       hdr = header file (structure) 

% lab : the labels of interest contained within the header file
    lab = { 'name of data file', 'data description',... 
            'number of bytes per pixel', 'image duration',... 
            'total number of images',... 
            'matrix size [1]', 'matrix size [2]', 'matrix size [3]',... 
            'scaling factor (mm/pixel) [1]', 'scaling factor (mm/pixel) [2]',... 
            'scaling factor (mm/pixel) [3]' };
% tag : the associated tag for each label 
    tag = { 'fn_dat', 'desc', 'n_byt', 'dt',... 
            'n_img', 'nx', 'ny', 'nz', 'vx', 'vy', 'vz' };

    n1 = 4;

    disp(['Reading file: ' fn])
%   fid : define the file id from the path and name given 
    fid = fopen( [fp fn], 'r' );  ok = ( fid > (-1) ); % determine the fid is correct 
    if ( ~ok ), errordlg('Error opening file'); hdr=[]; return; end
% while the file is open read each line 
    while ~feof( fid )
        lin = fgetl( fid ); % each line is retrieved 
        for i=1:numel(lab)
            i0 = strfind( lin, lab{i} ); % each label is searched for 
            if ~isempty( i0 )
                ss = strsplit( lin, ':=' ); % if a label is found the data is seperated 
                if ( numel(ss) > 1 )
                    tmp.(tag{i}) = d_val( ss{2} ); % the tag is used to assign a value from hdr file 
                end
            end
        end
    end
    fclose( fid );
% determine if the image is volumetric
    if ~isfield( tmp, 'nz' ), tmp.nz=1; end 
    if ~isfield( tmp, 'vz' ), tmp.vz=0; end
    % assign values to the hdr structure
    hdr.fp = fp;
    hdr.fn = fn;

    for i=1:n1
        if isfield( tmp, tag{i} ) % determine the data tags and assign to hdr 
            hdr.(tag{i}) = tmp.(tag{i});
        end
    end
    
    hdr.dim = [ tmp.nx, tmp.ny, tmp.nz ]; % define dimensions of hdr 
    if isfield( tmp, 'n_img' ), hdr.dim(3)=tmp.n_img; end % 3rd dim may be num of images 
    
    hdr.vox = [ tmp.vx, tmp.vy, tmp.vz ];
    
end


function [val] = d_val( s2 )
% converts the line read from the file to a numerical value 
    val = str2num( s2 );
    if isempty( val ), val = strtrim( s2 ); end

end
