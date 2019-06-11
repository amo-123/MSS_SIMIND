folder =uigetdir([cd,';.h00'],'Select Acquisition...');

files = dir(fullfile(folder, '*.h00'));


for i = 1:length(files)
    %playFile = [folder,'\',files(i).name];
    
    img = read_interfile(folder,['\' files(i).name]);
    save([folder,'\',num2str(files(i).name(1:end-4))],'img');
end
