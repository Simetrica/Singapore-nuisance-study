*---------------------------------------------------
* Set up
*---------------------------------------------------

clear all

* Set working directory
cd "$GIT/Singapore-nuisance-study"

* Set up globals
global CLIENT  "Jacobs - Singapore nuisance study (J000434)"
global PROJECT "$SHAREPOINT/Simetrica - Projects/$CLIENT/Analysis/Main"
global INPUT   "$PROJECT/Input"
global OUTPUT  "$PROJECT/Output"

* Include Simetrica-created functions
adopath ++ "$GIT/stata_functions"
include functions

*---------------------------------------------------
* Import cleaned data
*---------------------------------------------------

use "$OUTPUT/Data/Singapore Nuisance study survey data (clean).dta", clear

* Drop certain variables to allow code to re-run
capture drop ethnicity_recode
capture drop rakedweight

*--------------------------------------------------
* Pre-raking cleaning
*--------------------------------------------------

* Recode ethncity to match Census data
recode ethnicity (4/5=4), gen(ethnicity_recode)
la var ethnicity_recode "Ethnicity for raking"

label define ethnicity_recode ///
	1  "Chinese" ///
	2  "Indian" ///
	3  "Malay" ///
	4  "Others" ///
	.a "Rather not say", modify
la val ethnicity_recode ethnicity_recode

*--------------------------------------------------
* Raking
*--------------------------------------------------
//The percentages are taken from here: \Simetrica - Projects\Jacobs - Singapore nuisance study (J000434)\Analysis\Singapore Census Population 2020.xlsx

* Create raked weights
svycal rake i.female i.agecat i.ethnicity_recode, gen(rakedweight) totals(_cons=1 0.female=0.485 1.female=0.515 ///
	   		1.agecat=0.133 2.agecat=0.518 3.agecat=0.349 1.ethnicity_recode=0.755 2.ethnicity_recode=0.086 ///
	   		3.ethnicity_recode=0.128 4.ethnicity_recode=0.031)

* Set the raking weight as our survey weight
svyset [pw=rakedweight]

* Label variable
la var rakedweight "Weights (raked on gender, age & ethncity)"

*--------------------------------------------------
* Save and replace
*--------------------------------------------------

compress

save "$OUTPUT/Data/Singapore Nuisance study survey data (clean).dta", replace
