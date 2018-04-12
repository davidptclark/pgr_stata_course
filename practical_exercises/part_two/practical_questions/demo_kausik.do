
clear 
set more off
* Demonstration of Histogram
use "C:\statatraining\course_slides\course_slides\kenyalabor.dta" 

tw histogram WAGE_LCU_HR
graph export "C:\statatraining\course_slides\course_slides\kenyawage.png", as(png) replace
xtile wagepct = WAGE_LCU_HR, nq(100)
keep if wagepct > 1 & wagepct < 100
tw histogram WAGE_LCU_HR
sum WAGE_LCU_HR, detail
return list
local mean = r(mean) 
local median = r(p50) 
tw histogram WAGE_LCU_HR, bin(100) xline(`mean', lcolor(red)) xline(`median', lcolor(blue))
tw kdensity WAGE_LCU_HR if EMP_CAT_1 == 13, lcolor(green) || kdensity WAGE_LCU_HR if EMP_CAT_1 == 12, lcolor(red) || kdensity WAGE_LCU_HR if EMP_CAT_1 == 11, lcolor(blue) ytitle("Density") /// 
xtitle("Wages per hour (KSH)") legend(lab(1 "Private Agriculture")  lab(2 "Private Non-agriculture")  lab(3 "Public Sector") ring(0) pos(1) col(1) )
graph export "C:\statatraining\course_slides\course_slides\kernel.png", as(png) replace
clear
* Demonstration of Scatter Diagrams and Line Plot
infile str14 country setting effort change using http://data.princeton.edu/wws509/datasets/effort.raw, clear
graph twoway scatter change setting, title("Fertility Decline by Social Setting") ytitle("Fertility Decline") xtitle("Social Setting")
graph twoway scatter change setting, title("Fertility Decline by Social Setting") ytitle("Fertility Decline") xtitle("Social Setting") mlabel(country)
gen pos=3
replace pos = 11 if country == "TrinidadTobago"
replace pos = 9 if country == "CostaRica"
replace pos = 2 if country == "Panama" | country == "Nicaragua"
graph twoway scatter change setting, mlabel(country) mlabv(pos) 

* Demonstration of Line Plot
ssc install wbopendata
wbopendata, indicator(NY.GDP.MKTP.KD.ZG; NY.GDP.DEFL.KD.ZG) clear long
graph tw line ny_gdp_mktp_kd_zg ny_gdp_defl_kd_zg year if iso2code=="IN", title("Growth and Inflation in India (1961-2016)") legend( order(1 "Growth" 2 "Inflation"))
clear

* Demonstration of Bar Plot

sysuse citytemp, clear
graph bar, over(region) horizontal
graph bar tempjan tempjul, over(region) bargap(10) intensity(70) ///
title(Mean Temperature) legend(order(1 "January" 2 "July")) 

* Demonstration of Anova
clear
use "C:\statatraining\course_slides\course_slides\hers_640anova.dta"
tabstat sbp, by(raceth) stat(n mean sd)
anova sbp raceth
oneway sbp raceth
robvar sbp, by(raceth)

* Demonstration of Local Macros
use "C:\statatraining\course_slides\course_slides\kenyalabor.dta" 

local controls AGEY AGEY_2 URBAN
reg lnwage EDYEARS `controls'
sum lnwage
return list

* Demonstration of Loops with Macros
levelsof PROVINCE, local(provinces)
foreach PROVINCE of local provinces { 
   quietly: regress lnwage EDYEARS `controls' if PROVINCE == `PROVINCE' 
   local rsq =  e(r2)
   di "`PROVINCE': rsquared == `rsq'" 
}
