eststo clear
/***********************************************************************************
*********************** Replicating with discrete treatment ************************
***********************************************************************************/
xtreg urbrate fpresence1750 fpresence1800 fpresence1850 fpresence1875 fpresence1900 yr* ///
if westelbe==1 [aweight=totalpop1750], fe i(id) cluster(id)
test fpresence1850 fpresence1875 fpresence1900
eststo, add(Obs e(N) Polities e(df_a)+1 P_value r(p))

xtreg urbrate fpresence1750 fpresence1800 fpresence1850 fpresence1875 fpresence1900 yr* ///
if westelbe==1, fe i(id) cluster(id)
test fpresence1850 fpresence1875 fpresence1900
eststo, add(Obs e(N) Polities e(df_a)+1 P_value r(p))

xtreg urbrate fpresence1750 fpresence1800 fpresence1850 fpresence1875 fpresence1900 yr* ///
[aweight=totalpop1750], fe i(id) cluster(id)
test fpresence1850 fpresence1875 fpresence1900
eststo, add(Obs e(N) Polities e(df_a)+1 P_value r(p))

xtreg urbrate fpresence1750 fpresence1800 fpresence1850 fpresence1875 fpresence1900 yr*, ///
fe i(id) cluster(id)
test fpresence1850 fpresence1875 fpresence1900
eststo, add(Obs e(N) Polities e(df_a)+1 P_value r(p))

/***********************************************************************************
************************* Replication with binary treatment ************************
***********************************************************************************/
xtreg urbrate dummy_treat* yr* ///
if westelbe==1 [aweight=totalpop1750], fe i(id) cluster(id)
test dummy_treat1850 dummy_treat1875 dummy_treat1900
eststo, add(Obs e(N) Polities e(df_a)+1 P_value r(p))

xtreg urbrate dummy_treat* yr* ///
if westelbe==1, fe i(id) cluster(id)
test dummy_treat1850 dummy_treat1875 dummy_treat1900
eststo, add(Obs e(N) Polities e(df_a)+1 P_value r(p))

xtreg urbrate dummy_treat* yr* ///
[aweight=totalpop1750], fe i(id) cluster(id)
test dummy_treat1850 dummy_treat1875 dummy_treat1900
eststo, add(Obs e(N) Polities e(df_a)+1 P_value r(p))

xtreg urbrate dummy_treat* yr*, ///
fe i(id) cluster(id)
test dummy_treat1850 dummy_treat1875 dummy_treat1900
eststo, add(Obs e(N) Polities e(df_a)+1 P_value r(p))

/***********************************************************************************
********************************* Outputting table 3 *******************************
***********************************************************************************/

esttab using replication_tables.tex, se stat(Obs Polities P_value) nogaps compress float drop(yr* _cons) replace `siggreen' ///
coeflabels( fpresence1750 "Year 1750" fpresence1800 "Year 1800" ///
			fpresence1850 "Year 1850" fpresence1875 "Year 1875" ///
			fpresence1900 "Year 1900") ///
mtitles("Weighted" "Unweighted" "Weighted" "Unweighted" ///
		"Weighted" "Unweighted" "Weighted" "Unweighted") ///
mgroups("West of the Elbe" "All" "West of the Elbe" "All", pattern(1 0 1 0 1 0 1 0) ///
		span prefix(\multicolumn{@span}{c}{)suffix(})) ///
title("Dependent variable: Urbanization rate" \label{replicationTWFE}) ///
rename(dummy_treat1750 fpresence1750 dummy_treat1800 fpresence1800 dummy_treat1850 		 fpresence1850 dummy_treat1875 fpresence1875 dummy_treat1900 fpresence1900) ///
addnote("Columns (1)-(4) uses a discrete treatment variable. Columns (5)-(8) uses a binary treatment variable." ///
		"Polities denotes the number of polities in the regression, and P_value is the P-value from a joint test of all the post-treatment years." ///
		"Weighted regressions are weighted by territories' total population in 1750.")