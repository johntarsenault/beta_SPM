function [roiBetaData conditionName] = perROI_Cond_by_Run(spm_matFile,roiDir,roiFiles,printDir,spm_version)

switch spm_version
	case '12'
        [roiBetaData conditionName] = perROI_Cond_by_Run_SPM12(spm_matFile,roiDir,roiFiles,printDir);	
    otherwise    
        error('this version of SPM is not supported.  Please add!');
	end