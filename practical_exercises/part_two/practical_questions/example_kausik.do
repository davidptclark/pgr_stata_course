* 1 
tw histogram lnwage
sum lnwage, detail
return list
local mean = r(mean) 
local median = r(p50) 
tw histogram lnwage, xline(`mean', lcolor(red)) xline(`median', lcolor(blue))
tw histogram lnwage, bin(100) xline(`mean', lcolor(red)) xline(`median', lcolor(blue))
tw kdensity lnwage if EMP_CAT_1 == 13, lcolor(red) || kdensity lnwage if EMP_CAT_1 == 12, lcolor(blue) || kdensity lnwage if EMP_CAT_1 == 11, lcolor(green) ytitle("Density") /// 
xtitle("Log Wages per hour") legend(lab(1 "Private Agriculture")  lab(2 "Private Non-agriculture")  lab(3 "Public Sector") ring(0) pos(1) col(1) )
graph bar lnwage, over( PROVINCE )

* 2
tabstat lnwage, by( PROVINCE ) stat(n mean sd)
tab PROVINCE, g(pdummy)
anova lnwage pdummy1-pdummy7
* Demonstration of Loops with Macros
levelsof PROVINCE, local(provinces)
foreach PROVINCE of local provinces { 
   oneway lnwage MALE if PROVINCE == `PROVINCE' 
   }

* 3.

local controls AGEY MALE pdummy1-pdummy7
reg lnwage EDYEARS `controls'

* Demonstration of Loops with Macros
local controls AGEY MALE pdummy1-pdummy7
levelsof INDUSTRY_1, local(industry)
foreach INDUSTRY_1 of local industry { 
   regress WAGE_LCU_HR_PPP EDYEARS `controls' if INDUSTRY_1 == `INDUSTRY_1' 
   local rsq =  e(r2)
   di "`INDUSTRY_1': rsquared == `rsq'" 
}

