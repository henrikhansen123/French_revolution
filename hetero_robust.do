/***************************************************************
*********** Trying to do IV by hand with extensions ************
***************************************************************/
* Weighted!!! /*Nothing changes if we condition on a specific post-treatment year. This makes sense according to the estimator.*/
eststo clear
set seed 12345

capture: drop dIV dFS dITT newid
capture: program drop my2sls_Weighted
program my2sls_Weighted
*drop dIV dFS dITT
	capture: gen dIV = 0
	capture: gen dFS = 0
	capture: gen dITT = 0
	
	did_multiplegt yearsref id year fpresenceXpostXtrend, placebo(2) cluster(id)  weight(totalpop1750)  graphoptions(nodraw)
	replace dFS = e(effect_0)

	did_multiplegt urbrate id year fpresenceXpostXtrend, placebo(2) cluster(id)  weight(totalpop1750)  graphoptions(nodraw)
	replace dITT = e(effect_0)
	
	replace dIV = dITT/dFS
end

capture: drop dIV dFS dITT newid
capture: program drop my2sls_Unweighted
program my2sls_Unweighted
*drop dIV dFS dITT
	capture: gen dIV = 0
	capture: gen dFS = 0
	capture: gen dITT = 0
	
	did_multiplegt yearsref id year fpresenceXpostXtrend, placebo(2) cluster(id) graphoptions(nodraw)
	replace dFS = e(effect_0)

	did_multiplegt urbrate id year fpresenceXpostXtrend, placebo(2) cluster(id) graphoptions(nodraw)
	replace dITT = e(effect_0)
	
	replace dIV = dITT/dFS
end

* Something I need to do in order to compute panel data bootstrapped standard errors.
capture: gen newid = id
xtset newid year

eststo: bootstrap dIV dFS dITT, reps(200) cluster(id) idcluster(newid): my2sls_Weighted
eststo: bootstrap dIV dFS dITT, reps(200) cluster(id) idcluster(newid): my2sls_Unweighted
xtset, clear
