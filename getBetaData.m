function [betaData] = getBetaData(spmResultsDir,betaImageIndices,conditionNumber,runNumber)

addpath /fmri/apps/freesurfer-5.3.0/matlab/


testImage           = MRIread([spmResultsDir,'/beta_0001.nii']);
[sizeX sizeY sizeZ] = size(testImage.vol);


betaData = cell(1,conditionNumber);


for i = 1:conditionNumber
    betaData{i} = zeros(sizeX,sizeY,sizeZ,runNumber);
    
    for j = 1:runNumber
        
        currentImageName    = sprintf('%s/beta_%04d.nii',spmResultsDir,betaImageIndices(i,j));
        currentImage        = MRIread(currentImageName);
        betaData{i}(:,:,:,j) = currentImage.vol;
        
    end
end

