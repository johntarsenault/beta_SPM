function plot_MeanSem_ROIBetaData(roiBetaData,baselineCondition,flipCBV,conditionName,colorValues,roiFiles,printDir)

if ~exist(printDir)
    mkdir(printDir)
end

%remove baseline conditions
conditionName(baselineCondition) = [];
colorValues(baselineCondition) = [];

%get number of conditions
conditionNumber = length(conditionName);

%loop through rois
%subtract baseline if asked
%flip if CBV imaging

for i = 1:length(roiBetaData)
    if baselineCondition
        roiBetaData{i} = roiBetaData{i} - roiBetaData{i}(baselineCondition,:);
        roiBetaData{i}(baselineCondition,:) = [];
    end
    
    if flipCBV
        roiBetaData{i} =roiBetaData{i} * -1;
    end
end

%get mean and sem for each condition of each roi across runs
mean_roiBetaData = cell2mat(cellfun(@(x) mean(x,2),roiBetaData,'UniformOutput',false));
sem_roiBetaData  = cell2mat(cellfun(@(x) std(x,[],2)/sqrt(size(x,2)),roiBetaData,'UniformOutput',false));

%loop through ROIs and generate a figure
for currentROINumber = 1:length(roiBetaData)
    
    
    currentWindowSize = [121         473        1106         600];
    figure;
    set(gcf,'Position',currentWindowSize);

    
    for currentConditionNumber = 1:conditionNumber
        %plot bar graph of mean beta per cond
        h(currentConditionNumber) =bar(currentConditionNumber,mean_roiBetaData(currentConditionNumber,currentROINumber),...
        'FaceColor',colorValues{currentConditionNumber},'EdgeColor',[.2 .2 .2],'LineWidth',1.5 ); hold on;
        
        %plot sem across runs error bar per cond
        errorbar(currentConditionNumber,mean_roiBetaData(currentConditionNumber,currentROINumber),...
        sem_roiBetaData(currentConditionNumber,currentROINumber),'color',[.2 .2 .2],'linewidth',2);hold on;
    end
    
    xticklabels({''});
    xticks(['']);
    ylabel('mean beta value');

    legend(h,conditionName,'location','northeastoutside');

    box off
    set(gca,'linewidth',2);
    
    

    print(gcf,[printDir,roiFiles{currentROINumber}(1:end-4),'_betaBar.eps'],'-depsc','-tiff')
    delete(gcf);
end