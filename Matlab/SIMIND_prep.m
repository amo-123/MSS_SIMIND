function [img] = SIMIND_prep( img )
%SIMIND data pre-processing

    sf = 3/2;
   
    nn = img.dim;
    dd = reshape( img.dat, [2,nn(1)/2,nn(2:end)] );
    dd(2,:,:,:,:) = sf * dd(2,:,:,:,:);
    dd = reshape( dd, [nn(1),2,nn(2)/2,nn(3:end)] );
    dd(:,2,:,:,:) = sf * dd(:,2,:,:,:);
    img.dat = reshape( dd, img.dim );

end