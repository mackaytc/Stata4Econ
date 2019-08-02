cls
clear

/*
  Back to Fan's Stata4Econ:
  - http://fanwangecon.github.io
  - http://fanwangecon.github.io/Stata4Econ

  1. Same regression for two Subgroups
  2. Show alll subgroup coefficients in one regression
*/

set more off
sysuse auto, clear

tab rep78
tab foreign

* 1. Same regression for two Subgroups
eststo clear
eststo, title(dom): regress weight ib3.rep78 if foreign == 0
eststo, title(foreign): regress weight ib3.rep78 if foreign == 1
esttab, mtitle title("Foreign or Domestic")

* 2. Show alll subgroup coefficients in one regression
capture drop domestic
recode foreign ///
   (0 = 1 "domestic") ///1
   (1 = 0 "foreign") ///
   (else = .) ///
   , ///
   gen(domestic)
tab domestic foreign

* using factor for binary
eststo clear
eststo, title(both): quietly regress ///
    weight ///
    ib0.foreign ib0.domestic ///
    ib3.rep78#ib0.foreign ///
    ib3.rep78#ib0.domestic ///
    , noc
esttab, mtitle title("Foreign or Domestic")

* using cts for binary
eststo clear
eststo, title(both): quietly regress ///
    weight ///
    c.foreign c.domestic ///
    ib3.rep78#c.foreign ///
    ib3.rep78#c.domestic ///
    , noc
esttab, mtitle title("Foreign or Domestic")


translate @Results "~\Stata4Econ\reglin\discrete\fs_reg_d_interact.pdf", replace translator(Results2pdf)