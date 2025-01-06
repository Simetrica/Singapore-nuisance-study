*----------------------------------------------------
* Set up
*----------------------------------------------------

* Include Stata functions
adopath ++ "$GIT/stata_functions"

* Set up globals
global CLIENT  "Jacobs - Singapore nuisance study (J000434)"
global PROJECT "$SHAREPOINT/Simetrica - Projects/$CLIENT/Analysis/Main"
global INPUT   "$PROJECT/Input"
global OUTPUT  "$PROJECT/Output"
global RESULTS "$OUTPUT/Singapore Nuisance - Results.xlsx"

* Include Simetrica-created functions
include functions

*----------------------------------------------------
* Wellbeing values
*----------------------------------------------------
use "$OUTPUT/Data/Singapore Nuisance study survey data (clean).dta", clear

putexcel_wait set "$RESULTS", sheet("Nuisance study", replace) modify

global esttab_opts not label star(* 0.10 ** 0.05 *** 0.01) mtitles stats(N r2, labels("N" "R-sq"))

//To double check

global controls lhhincome i.female i.married i.degree i.employed i.chinese i.children i.religious i.carer i.agecat

* Standard + add. controls (weighted)
eststo: reg lfsato  $controls [pw=rakedweight], vce(r)
excel, name("Standard (weighted)") $esttab_opts replace
eststo clear
