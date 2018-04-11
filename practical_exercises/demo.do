********************************
*PGR Stata Course: Demo Do-file*
********************************

**Demo 1: Changing and creating directories**

pwd

cd

ls

mkdir
**Demo 2: Importing datafiles**

use

import delimited
*specify the encoding of the text file being imported

save

import excel 

save 
**Demo 3: Using Conditionals**

sysuse auto.dta, clear

browse

browse make price mpg foreign

browse make price mpg foreign if mpg<20

browse make price mpg foreign if foreign=="Domestic"

*encoding
browse make price mpg foreign

tab foreign

levelsof foreign

browse make price mpg foreign if foreign==1

browse make price mpg foreign if mpg<20 | foreign==1

browse make price mpg foreign if mpg<20 & foreign==1

browse in 1/25

rename price Price

label var Price "Price of the car"

keep make price mpg foreign

sysuse auto.dta, clear

keep make price mpg foreign if foreign == 0

*drop (better to use keep - less work)

**Demo 4: Descriptive Statisitcs**

sysuse auto.dta, clear

describe

describe, simple

summarize
*ask why variable make is 0)

summarize, detail

summarize price mpg

summarize price mpg if price<5000

tabulate
*doesn't work alone

tabulate foreign

tabulate price
*useful?

tabulate foreign rep78

tabulate foreign if mpg<20

correlate
*Why?

correlate mpg price

correlate mpg price trunk weight length

correlate mpg price trunk weight length,covariance
*(not preferred)

pwcorr mpg price trunk weight length

pwcorr mpg price trunk weight length, sig star(0.01) 

