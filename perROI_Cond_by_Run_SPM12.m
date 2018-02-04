function [roiBetaData conditionName] = perROI_Cond_by_Run_SPM12(spm_matFile,roiDir,roiFiles,printDir)

%make print directory if it doesn't exist
    if ~exist(printDir)
        mkdir(printDir)
    end

%load SPM.mat file 
fprintf('started reading SPM.mat \n');
load(spm_matFile);
fprintf('finished reading SPM.mat \n');

%get data SPM.mat

spmResultsDir       = SPM.swd;
runNumber           = size(SPM.Sess,2);
conditionNumber     = size(SPM.Sess([1]).U,2);
conditionName       = cell(1,conditionNumber);

for i = 1:conditionNumber
    conditionName{i} = SPM.Sess([1]).U(i).name{1};
end

%get description of contents of each beta file
betaDescripts = {SPM.Vbeta(:).descrip};

%find out beta number associated with each condition
%betaImageIndices = condition(rows) x runs(columns)
betaImageIndices = findBetaImageIndices(betaDescripts,conditionName,conditionNumber,runNumber);

%gather 3D beta images
%betaData{conditionNumber}(sizeX,sizeY,sizeZ,runNumber)
[betaData] = getBetaData(spmResultsDir,betaImageIndices,conditionNumber,runNumber);    

%get 1D indices of rois
%roiIndices{roiNumber}(indicesvalues)
roiIndices = getROI_indices(roiDir,roiFiles);

%get per ROI per condition per run  beta values
%roiBetaData{roiNumber}(conditionNumber,runNumber)
roiBetaData = getROI_betaData(betaData,roiIndices,conditionNumber,runNumber);

save([printDir,'roiBetaData.mat'],'roiBetaData','conditionName');