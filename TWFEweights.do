/***********************************************************************************
******************************* Finding weights ***********************************
***********************************************************************************/

*This is the weights from the paper.
twowayfeweights urbrate id year fpresenceXpost, type(feTR)

	* dep_var: urbrate
twowayfeweights urbrate id year fpresenceXpost, type(feTR)
	* dep_var: yearsref
twowayfeweights yearsref id year fpresenceXpost, type(feTR) 

* Weights with a time trend
	* dep_var: urbrate
twowayfeweights urbrate id year fpresenceXpost, type(feTR) weight(totalpop1750)
	* dep_var: yearsref
twowayfeweights yearsref id year fpresenceXpost, type(feTR) weight(totalpop1750)

gen binary_treatment = napoleon * (year > 1800)
* Weights when treatment is binary.
twowayfeweights urbrate id year binary_treatment, type(feTR)
drop binary_treatment


twowayfeweights yearsref id year fpresence if year > 1700, type(feTR) weight(totalpop1750) path("C:\Files\Current_Project\slet.dta")