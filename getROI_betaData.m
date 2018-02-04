function roiBetaData = getROI_betaData(betaData,roiIndices,conditionNumber,runNumber);

clear roiBetaData

for i = 1:length(roiIndices)
    roiBetaData{i} = NaN(conditionNumber,runNumber);
end


    for j = 1:conditionNumber
        for k = 1:runNumber
                currentImage = squeeze(betaData{j}(:,:,:,k));
                
                for i = 1:length(roiIndices)
                    roiBetaData{i}(j,k)   =  mean(currentImage(roiIndices{i}));
                end

        end
    end

    