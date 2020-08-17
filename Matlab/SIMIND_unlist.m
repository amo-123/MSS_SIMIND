function [img] = SIMIND_unlist( fp, fn )
%Un-list SIMIND list-mode data.

    E_max = 200;  dE = 1;    % keV
    E_win = 140.5 * ( 1 + [-1,1] * 0.1 );                                  % energy window, Tc-99m, 20%
    dim = [400,200,4];  
    dim1 = [400,400,4];  c_xy = (1+dim1(1:2))/2;
    mm = ( dim1 - dim ) / 2;
    vox = [0.025,0.025,0.15];
    Rad = 20.7;                                                            % detector radius, crystal surface (cm)

    ns = fix( E_max / dE );
    E_sp.ee = 0.5 + (0:ns-1)*dE;
    E_sp.dat = zeros( ns, 1 );                                             % energy spectrun

    %fp = '';
    %[fn,fp] = uigetfile([fp '*.lmf']);
    fn1 = [ fn(1:end-4) '.mat' ];
   
    fra = read_lmf( fp, fn );                                              % Read data block

    img.dim = dim;  img.vox = vox;  img.dat = zeros( dim );
    ip = 1;  L_eof = 0;
   
    while ( ~L_eof )
   
        % update spectrum
%        ii = find( fra.ee < E_max );
        ii = find( (fra.ee>0) & (fra.ee<E_max) );
        ee = fra.ee(ii);
        wei = fra.wei(ii);
        iie = fix( ee / dE ) + 1;
        for i1=min(iie):max(iie)
            ii = find( iie == i1 );
            if ~isempty( ii ), E_sp.dat(i1) = E_sp.dat(i1) + sum( wei(ii) ); end
        end

        % update image
        ii = find( (fra.ee>=E_win(1)) & (fra.ee<=E_win(2))  );
        ee = fra.ee(ii);
        xyz = fra.xyz(ii,:);
        wei = fra.wei(ii);

        iix = round( xyz(:,1) / vox(1) + c_xy(1) );
        iiy = round( xyz(:,2) / vox(2) + c_xy(2) );
        iiz =  fix( ( xyz(:,3) - Rad ) / vox(3) ) + 1;
        iiz( iiz > dim1(3) ) = dim1(3);
        iid = ( (iiz-1)*dim1(2) + (iiy-1) ) * dim1(1) + iix;

        dat = zeros( dim1 );
        while ~isempty( iid )
            [iiu,iia] = unique( iid );
            dat(iiu) = dat(iiu) + wei(iia);
            iid(iia) = NaN;  jjd = ~isnan(iid);
            iid = iid( jjd );
            wei = wei( jjd );
        end
        dat = dat( (1:dim(1))+mm(1), (1:dim(2))+mm(2), (1:dim(3))+mm(3) );

        if ( fra.ip > ip )                                                 % new projection
            ip = fra.ip;
            img.dat(:,:,:,ip) = zeros( dim );
        end

        img.dat(:,:,:,ip) = img.dat(:,:,:,ip) + dat;

        L_eof = fra.L_eof;
        if ( ~L_eof ), fra=read_lmf(); end                                 % read next block
       
    end

    img.dim = [ img.dim, ip ];
    img.vox = [ img.vox, 1 ];

    disp(['Saving file: ' fn1])
    %save([fp fn1],'E_sp','img')                                            % save spectrum and image
    figure;
    for i = 1 : 4
    subplot(2,2,i)
    dd = img.dat(:,:,i);
    imagesc(dd,[0,max(dd(:))/3]); colorbar
    xlabel(['DOI Layer: ',int2str(i)]);
    end
end
