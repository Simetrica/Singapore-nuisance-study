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
adopath ++ "$GIT/stata_functions"

*----------------------------------------------------
* Wellbeing values
*----------------------------------------------------
use "$OUTPUT/Data/Singapore Nuisance study survey data (clean).dta", clear

putexcel_wait set "$RESULTS", sheet("Nuisance study", replace) modify

global esttab_opts not label star(* 0.10 ** 0.05 *** 0.01) mtitles stats(N r2, labels("N" "R-sq"))

//To double check

global controls lhhincome i.female i.married i.degree i.employed i.chinese i.children i.religious i.carer i.agecat

*---------------------
* Dust
*---------------------

* Standard 1km (weighted)
eststo: reg lfsato dust living_close_1km $controls [pw=rakedweight], vce(r)
excel, name("Dust 1km - Standard (weighted)") $esttab_opts replace
eststo clear

* Standard 1km + add. controls (weighted)
eststo: reg lfsato dust dust_highfreq dust_highintensity living_close_1km $controls [pw=rakedweight], vce(r)
excel, name("Dust 1km & highfrequency and highintensity- Standard (weighted)") $esttab_opts replace
eststo clear

* Standard 1km + add. controls (weighted)
eststo: reg lfsato dust dust_highfreq living_close_1km $controls [pw=rakedweight], vce(r)
excel, name("Dust 1km & highfrequency - Standard (weighted)") $esttab_opts replace
eststo clear

* Standard 1km + add. controls (weighted)
eststo: reg lfsato dust dust_highintensity living_close_1km $controls [pw=rakedweight], vce(r)
excel, name("Dust 1km & highintensity- Standard (weighted)") $esttab_opts replace
eststo clear

* Standard 500m (weighted)
eststo: reg lfsato dust living_close_500m $controls [pw=rakedweight], vce(r)
excel, name("Dust 500m - Standard (weighted)") $esttab_opts replace
eststo clear

* Standard 500m + add. controls (weighted)
eststo: reg lfsato dust dust_highfreq dust_highintensity living_close_500m $controls [pw=rakedweight], vce(r)
excel, name("Dust 500m & highfrequency and highintensity- Standard (weighted)") $esttab_opts replace
eststo clear

* Standard 500m + add. controls (weighted)
eststo: reg lfsato dust dust_highfreq living_close_500m $controls [pw=rakedweight], vce(r)
excel, name("Dust 500m & highfrequency - Standard (weighted)") $esttab_opts replace
eststo clear

* Standard 500m + add. controls (weighted)
eststo: reg lfsato dust dust_highintensity living_close_500m $controls [pw=rakedweight], vce(r)
excel, name("Dust 500m & highintensity- Standard (weighted)") $esttab_opts replace
eststo clear



*---------------------
* Noise
*---------------------

* Standard 1km (weighted)
eststo: reg lfsato noise living_close_1km $controls [pw=rakedweight], vce(r)
excel, name("Noise 1km - Standard (weighted)") $esttab_opts replace
eststo clear

* Standard 1km + add. controls (weighted)
eststo: reg lfsato noise noise_highfreq noise_highintensity living_close_1km $controls [pw=rakedweight], vce(r)
excel, name("Noise 1km & highfrequency and highintensity- Standard (weighted)") $esttab_opts replace
eststo clear

* Standard 1km + add. controls (weighted)
eststo: reg lfsato noise noise_highfreq living_close_1km $controls [pw=rakedweight], vce(r)
excel, name("Noise 1km & highfrequency - Standard (weighted)") $esttab_opts replace
eststo clear

* Standard 1km + add. controls (weighted)
eststo: reg lfsato noise noise_highintensity living_close_1km $controls [pw=rakedweight], vce(r)
excel, name("Noise 1km & highintensity- Standard (weighted)") $esttab_opts replace
eststo clear

* Standard 500m (weighted)
eststo: reg lfsato noise living_close_500m $controls [pw=rakedweight], vce(r)
excel, name("Noise 500m - Standard (weighted)") $esttab_opts replace
eststo clear

* Standard 500m + add. controls (weighted)
eststo: reg lfsato noise noise_highfreq noise_highintensity living_close_500m $controls [pw=rakedweight], vce(r)
excel, name("Noise 500m & highfrequency and highintensity- Standard (weighted)") $esttab_opts replace
eststo clear

* Standard 500m + add. controls (weighted)
eststo: reg lfsato noise noise_highfreq living_close_500m $controls [pw=rakedweight], vce(r)
excel, name("Noise 500m & highfrequency - Standard (weighted)") $esttab_opts replace
eststo clear

* Standard 500m + add. controls (weighted)
eststo: reg lfsato noise noise_highintensity living_close_500m $controls [pw=rakedweight], vce(r)
excel, name("Noise 500m & highintensity- Standard (weighted)") $esttab_opts replace
eststo clear


*---------------------
* Odour
*---------------------

* Standard 1km (weighted)
eststo: reg lfsato odour living_close_1km $controls [pw=rakedweight], vce(r)
excel, name("Odour 1km - Standard (weighted)") $esttab_opts replace
eststo clear

* Standard 1km + add. controls (weighted)
eststo: reg lfsato odour odour_highfreq odour_highintensity living_close_1km $controls [pw=rakedweight], vce(r)
excel, name("Odour 1km & highfrequency and highintensity- Standard (weighted)") $esttab_opts replace
eststo clear

* Standard 1km + add. controls (weighted)
eststo: reg lfsato odour odour_highfreq living_close_1km $controls [pw=rakedweight], vce(r)
excel, name("Odour 1km & highfrequency - Standard (weighted)") $esttab_opts replace
eststo clear

* Standard 1km + add. controls (weighted)
eststo: reg lfsato odour odour_highintensity living_close_1km $controls [pw=rakedweight], vce(r)
excel, name("Odour 1km & highintensity- Standard (weighted)") $esttab_opts replace
eststo clear

* Standard 500m (weighted)
eststo: reg lfsato odour living_close_500m $controls [pw=rakedweight], vce(r)
excel, name("Odour 500m - Standard (weighted)") $esttab_opts replace
eststo clear

* Standard 500m + add. controls (weighted)
eststo: reg lfsato odour odour_highfreq odour_highintensity living_close_500m $controls [pw=rakedweight], vce(r)
excel, name("Odour 500m & highfrequency and highintensity- Standard (weighted)") $esttab_opts replace
eststo clear

* Standard 500m + add. controls (weighted)
eststo: reg lfsato odour odour_highfreq living_close_500m $controls [pw=rakedweight], vce(r)
excel, name("Odour 500m & highfrequency - Standard (weighted)") $esttab_opts replace
eststo clear

* Standard 500m + add. controls (weighted)
eststo: reg lfsato odour odour_highintensity living_close_500m $controls [pw=rakedweight], vce(r)
excel, name("Odour 500m & highintensity- Standard (weighted)") $esttab_opts replace
eststo clear


