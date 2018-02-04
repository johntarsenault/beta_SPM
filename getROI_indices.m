function roiIndices = getROI_indices(roiDir,roiFiles)

addpath /fmri/apps/freesurfer-5.3.0/matlab/

threshold = 1;

roiIndices = cell(1,length(roiFiles));


for i = 1:length(roiFiles)
    currentImageName = [roiDir,roiFiles{i}];
    currentImage = MRIread(currentImageName);
    roiIndices{i} = find(currentImage.vol>=threshold);
end
