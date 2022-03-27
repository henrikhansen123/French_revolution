/***********************************************************
*********************** Overall TWFE ***********************
***********************************************************/
eststo clear
* Discrete case
eststo: reg urbrate c.fpresence##1.post i.id yr1750-yr1900, cluster(id) /* This is equivalent with the ITT, except that we don't have a time trend */

* Binary case
eststo: reg urbrate 1.napoleon##1.post i.id yr1750-yr1900, cluster(id)

* New table with results
esttab using discrete_binary.tex, keep(1*.post*) drop(1.post) noobs nogaps se rename(1.napoleon#1.post 1.post#c.fpresence) coeflabels(1.post#c.fpresence "French invasion") mtitles("Discrete" "Binary") note("Standard errors in parentheses") nonotes title("Dependent variable: Urbanization rate" \label{overallTWFE}) replace