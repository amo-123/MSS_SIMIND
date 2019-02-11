img = read_interfile();
%%
img2 = read_interfile();
%%
img3 = read_interfile();

img4 = read_interfile();
%%
img5 = read_interfile();
%%
img6 = read_interfile();

img7 = read_interfile();
%%
img8 = read_interfile();
%%
img9 = read_interfile();
%%
[x1,x2,y1,y2] = BoxCoord(img.dat,2);

%%
[FWHM] = SumAndFit(img.dat,1,x1,x2,y1,y2);
%%
[FWHM2] = SumAndFit(img2.dat,1);
[FWHM3] = SumAndFit(img3.dat,1);
[FWHM4] = SumAndFit(img4.dat,1);
[FWHM5] = SumAndFit(img5.dat,1);
[FWHM6] = SumAndFit(img6.dat,1);
[FWHM7] = SumAndFit(img7.dat,1);
[FWHM8] = SumAndFit(img8.dat,1);
[FWHM9] = SumAndFit(img9.dat,1);

%%

Z = (1860:-25:1660);

Res = [FWHM,FWHM2,FWHM3,FWHM4,FWHM5,FWHM6,FWHM7,FWHM8,FWHM9];

figure;
plot(Z,Res,'.r');
title('Resolution against Distance')
xlabel('distance from coll mm')
ylabel('resolution mm')

