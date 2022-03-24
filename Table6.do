/***********************************************************************************
******************************* Replicating table 6 ********************************
***********************************************************************************/
eststo clear

* Bootstrapped: Weighted (est1), Unweighted (est2)
do hetero_robust.do

* IV (est3), FS (st1*) Weighted
eststo: xi: xtivreg2 urbrate (yearsref= fpresenceXpostXtrend) yr1750-yr1900 [aweight=totalpop1750], fe robust i(id) cluster(id) first savefirst savefprefix(st1)

* IV (est4), FS (st2*) Unweighted
eststo: xi: xtivreg2 urbrate (yearsref= fpresenceXpostXtrend) yr1750-yr1900, fe robust i(id) cluster(id) first savefirst savefprefix(st2)

* Intention-to-treat (est5) Weighted
eststo: reg urbrate fpresenceXpostXtrend i.id yr1750-yr1900 [aweight=totalpop1750]

* Intetion-to-treat (est6) Unweighted
eststo: reg urbrate fpresenceXpostXtrend i.id yr1750-yr1900
/***********************************************************************************
******************************* Table is build here ********************************
***********************************************************************************/
* Panel A
esttab est5 est1 est6 est2 using table_6.tex, se keep(f*) mtitles("TWFE" "DIDm" "TWFE" "DIDm") ///
rename(_bs_3 "fpresenceXpostXtrend") ///
coeflabels(fpresenceXpostXtrend "ITT") ///
noobs nogaps nonumbers ///
prehead("\begin{tabular}{l*{5}{c}} \hline\hline") ///
fragment ///
mgroups("Weighted" "Unweighted", ///
pattern(1 0 1 0) ///
span prefix(\multicolumn{@span}{c}{) suffix(})) ///
replace 

* Panel B
esttab st1* est1 st2* est2 using table_6.tex, se keep(f*) rename(_bs_2 "fpresenceXpostXtrend") ///
coeflabels(fpresenceXpostXtrend "FS") ///
noobs nogaps nonumbers ///
fragment append nomtitles 

* Panel C
esttab est3 est1 est4 est2 using table_6.tex, se keep(yearsref) rename(_bs_1 "yearsref") ///
coeflabels(yearsref "2SLS") noobs nogaps nonumbers ///
fragment append nomtitles ///
prefoot("\hline") ///
postfoot("\hline\hline \end{tabular}")