/*******************************************************************************
******************************** MASTER DO.file ********************************
*******************************************************************************/
/***************************************************************
************************ Preliminaries *************************
***************************************************************/
clear
set more off
*version 10.0 /* I have commented this out to not make the regression stop at the 'replication with standard OLS' regressions.*/
eststo clear

* Insert path to data-set
local path "C:\Files\School\8_Semester\Adv._Metrics\Exam\Data\112481-V1" /* insert local path here */

cd "`path'"
use "20100816_replication_dataset.dta"

keep if year==1700 | year==1750 | year==1800 | year==1850 | year==1875 | year==1900
drop yr1880 yr1885 yr1895 yr1905 yr1910 

gen napoleon = (fpresence>0)
gen post = (year > 1800)
sort year 
format urbrate %9.2f
sort id year

* Insert path to where you wanna save your output.
cd "C:\Files\School\8_Semester\Adv._Metrics\Exam\Stata"

* Generating binary treatment dummies
local temp_var 1750 1800 1850 1875 1900
foreach var in `temp_var' {
	generate dummy_treat`var' = 0
	replace dummy_treat`var' = 1 if fpresence`var' > 0
}

set seed 12345
cls

* Replicating table 3
do Table3.do

* Creating plot of coefficients from table 3
do coef_plot.do

* Calculating TWFE-weights
do TWFEweights.do

* Creating a table from overall TWFE-estimation
do overallTWFE_table.do

* Creating table 6
 do Table6.do

* Creating a placebo test table for DID_M
do common_trends.do