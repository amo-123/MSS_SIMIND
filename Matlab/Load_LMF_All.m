% SIMIND script loader 
folder = 'C:\Users\Ashley\Google Drive\UNIWORK\UCL\PhD Year 1\SIMIND\INSERT_Simind\PythonProj\SIMIND Projects\MSS\Planar_LM';

files = dir(fullfile(folder,'*.lmf'));

for i = 1:length(files)
    
fn = files(i).name;
fp = [folder,'/'];

SIMIND_unlist(fp,fn);

end