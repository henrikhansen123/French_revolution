/*****************************************************************************
***					The placebo-test for the DID-M estimator			   ***
******************************************************************************/
eststo clear
set seed 12345

* ITT: Weighted
eststo: bootstrap e(placebo_1) e(placebo_2), reps(200) : did_multiplegt urbrate id year fpresenceXpostXtrend, placebo(2) cluster(id) weight(totalpop1750) graphoptions(nodraw)

* ITT: Unweighted
eststo: bootstrap e(placebo_1) e(placebo_2), reps(200) : did_multiplegt urbrate id year fpresenceXpostXtrend, placebo(2) cluster(id) graphoptions(nodraw)

* FS: Weighted
eststo: bootstrap e(placebo_1) e(placebo_2), reps(200) : did_multiplegt yearsref id year fpresenceXpostXtrend, placebo(2) cluster(id)  weight(totalpop1750) graphoptions(nodraw)

* FS: Unweighted
eststo: bootstrap e(placebo_1) e(placebo_2), reps(200) : did_multiplegt yearsref id year fpresenceXpostXtrend, placebo(2) cluster(id) graphoptions(nodraw)

esttab using placebo.tex, se coeflabels(_bs_1 "1800" _bs_2 "1750") noobs nogaps mtitles("Weighted" "Unweighted" "Weighted" "Unweighted") mgroups("Intention-To-Treat" "First-Stage", pattern(1 0 1 0) span prefix(\multicolumn{@span}{c}{)suffix(})) ///
title("Placebo-tests for the DIDm estimator" \label{placebo}) replace