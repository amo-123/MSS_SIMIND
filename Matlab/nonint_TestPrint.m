img = read_interfile("/cs/academic/phd3/amorahan/simind/MSS_SIMIND/MSS","test_fileoutput%1.h00");

[FWHM] = SumAndFit(img.dat,1);

fileID = fopen('Test_output.txt','w');

fprintf(fileID, 'Test\n');

fprintf(fileID, '%f', FWHM);

fclose(fileID);