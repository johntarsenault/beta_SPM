function betaImageIndices = findBetaImageIndices(betaDescripts,conditionName,conditionNumber,runNumber)

%assign betaImage number to each run condition number
%rows    = condition #
%columns = run # 
betaImageIndices = zeros(conditionNumber,runNumber);

for i = 1:conditionNumber   
    currentBetaID       = [') ',conditionName{i},'*bf('];
    currentIndicesCell  = strfind(betaDescripts,currentBetaID);
    currentIndices      = find(~cellfun(@isempty,currentIndicesCell));
    betaImageIndices(i,:) = currentIndices;
end

    