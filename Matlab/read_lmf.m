function [fra] = read_lmf( fp1, fn1 )
%Read SIMIND list-mode file 

    persistent fp fn ip offs L_eof

    nn = 1e6;     % max number of events
    npr = -99;    % new projection code
    
    if ( nargin > 0 )
        fp = fp1;  fn = fn1;  ip = 1;  offs = 0;  L_eof = 0;
        disp(['Path: ' fp])
    end

    if ( L_eof ), disp('No more data in file.'), fra=[]; return, end
    
    disp(['Reading file: ' fn])
    disp(['Offset: ' num2str(offs)])
    fid = fopen( [fp fn], 'r' );
    if ( fid < 0 ), errordlg('Error opening file'); fra=[]; return; end
    fseek( fid, offs, 'bof' );
    
    fra.n_ev = 0;  fra.L_eof = 0;
    fra.ip = ip;
    fra.xyz = single(zeros(nn,3));
    fra.ee = single(zeros(nn,1));
    fra.wei = zeros(nn,1);
    fra.ord = uint8(zeros(nn,1));
    
    for i_ev=1:nn
        
        %xyze = fread( fid, 10, 'int16' );
        xyze = fread( fid, 4, 'int16' );
        wei = fread( fid, 1, 'double' );
        ord = fread( fid, 1, 'uint8' );
        if feof( fid ), L_eof=1; break, end
        %if ( xyze(10) == npr ), ip=ip+1; break, end
        if ( xyze(4) == npr ), ip=ip+1; break, end
        
        
        fra.n_ev = i_ev;
        %fra.xyz(i_ev,:) = single( xyze(7:9)' / 100 );
        %fra.ee(i_ev) = single( xyze(10) / 10 );
        fra.xyz(i_ev,:) = single( xyze(1:3)' / 100 );
        fra.ee(i_ev) = single( xyze(4) / 10 );
        fra.wei(i_ev) = wei;
        fra.ord(i_ev) = ord;
        
    end
    offs = ftell( fid );
    fclose( fid );
    fra.L_eof = L_eof;
    
    if ( fra.n_ev < nn )
        fra.xyz = fra.xyz(1:fra.n_ev,:);
        fra.ee = fra.ee(1:fra.n_ev);
        fra.wei = fra.wei(1:fra.n_ev);
        fra.ord = fra.ord(1:fra.n_ev);
    end
        
    disp(['Number of events: ' num2str(fra.n_ev)])
    if ( L_eof ), disp('End of file reached.'), end
    
end
