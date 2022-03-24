eststo clear

eststo: quietly xtreg urbrate fpresence1750 fpresence1800 fpresence1850 fpresence1875 fpresence1900 yr* [aweight=totalpop1750], fe i(id) cluster(id)

eststo: quietly xtreg urbrate fpresence1750 fpresence1800 fpresence1850 fpresence1875 fpresence1900 yr*, fe i(id) cluster(id)

/*
eststo: quietly xtreg urbrate fpresence1750 fpresence1800 fpresence1850 fpresence1875 fpresence1900 yr* if westelbe==1, fe i(id) cluster(id)
*/



/*
eststo: quietly xtreg urbrate fpresence1750 fpresence1800 fpresence1850 fpresence1875 fpresence1900 yr* [aweight=totalpop1750] if westelbe==1, fe i(id) cluster(id)
*/

coefplot est1 est2, drop(_cons yr*) vertical yline(0.00, lp(dash)) ///
coeflabels( fpresence1750 = "1750" fpresence1800 = "1800" ///
			fpresence1850 = "1850" fpresence1875 = "1875" fpresence1900 = "1900") ///
legend( label(2 "Weighted") ///
		label(4 "Unweighted") ) ///
		legend(ring(0) position(11)) ytitle("Estimated coefficients") ///
		addplot(function y=0.004389004*50*(x)+0.004389004*1700-8.1685259, range(0.5 5.5) lp(dash)) 


graph export coefplot_reduced.png, replace