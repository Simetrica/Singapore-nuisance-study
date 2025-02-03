*----------------------------------------------------
* Set up
*----------------------------------------------------
clear all

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
* Regression results
*----------------------------------------------------
use "$OUTPUT/Data/Singapore Nuisance study survey data (clean).dta", clear

putexcel_wait set "$RESULTS", sheet("General regressions v2", replace) modify

global esttab_opts not label star(* 0.10 ** 0.05 *** 0.01) mtitles stats(N r2, labels("N" "R-sq"))

global controlshealth leq_hhincome female married degree i.employed_cat chinese children religious carer i.agecat source_neighbours source_commeract source_entertvenues source_retail source_cleanpublic ///
    source_constrsites source_roadtraffic /*source_other*/ roads_distance transport_distance physicalhealth mentalhealth
eststo clear

eststo: reg lfsato $controlshealth dust noise odour [pw=rakedweight], vce(r)
eststo: reg lfsato $controlshealth i.cat_dust_freq i.cat_noise_freq i.cat_odour_freq [pw=rakedweight], vce(r)
eststo: reg lfsato $controlshealth i.cat_dust_intensity i.cat_noise_intensity i.cat_odour_intensity [pw=rakedweight], vce(r)
eststo: reg lfsato $controlshealth i.dust_combined_dum i.noise_combined_dum i.odour_combined_dum [pw=rakedweight], vce(r)
eststo: reg lfsato $controlshealth i.dust_combined_cat i.noise_combined_cat i.odour_combined_cat [pw=rakedweight], vce(r)
eststo: reg lfsato $controlshealth i.nuisance [pw=rakedweight], vce(r)
eststo: reg lfsato $controlshealth i.nuisance_combined_dum [pw=rakedweight], vce(r)
eststo: reg lfsato $controlshealth i.nuisance i.nuisance_combined_dum [pw=rakedweight], vce(r)
eststo: reg lfsato $controlshealth i.nuisance_combined_cat [pw=rakedweight], vce(r)
*eststo: reg lfsato $controlshealth i.nuisance i.nuisance_combined_cat [pw=rakedweight], vce(r)
eststo: reg lfsato $controlshealth i.sum_nuisance [pw=rakedweight], vce(r)
eststo: reg lfsato $controlshealth i.sum_nuisance_combined [pw=rakedweight], vce(r)
eststo: reg lfsato $controlshealth i.sum_nuisance i.sum_nuisance_combined [pw=rakedweight], vce(r)
eststo: reg lfsato $controlshealth i.nuisance_effect [pw=rakedweight], vce(r)
eststo: reg lfsato $controlshealth i.nuisance_combined_dum_effect [pw=rakedweight], vce(r)
eststo: reg lfsato $controlshealth i.nuisance_effect i.nuisance_combined_dum_effect [pw=rakedweight], vce(r)
eststo: reg lfsato $controlshealth i.nuisance_combined_cat_effect [pw=rakedweight], vce(r)
*eststo: reg lfsato $controlshealth i.nuisance_effect i.nuisance_combined_cat_effect [pw=rakedweight], vce(r)
eststo: reg lfsato $controlshealth i.sum_nuisance_effect [pw=rakedweight], vce(r)
eststo: reg lfsato $controlshealth i.sum_nuisance_combined_effect [pw=rakedweight], vce(r)
eststo: reg lfsato $controlshealth i.sum_nuisance_effect i.sum_nuisance_combined_effect [pw=rakedweight], vce(r)
excel, name("Regressions") $esttab_opts replace
eststo clear

// Code in order to save the coefficient, se, p-value, and sample sizes

putexcel_wait set "$RESULTS", sheet("Sample sizes", replace) modify

global rownumber = 1

putexcel_wait ///
    A$rownumber = ("Variable") ///
    B$rownumber = ("Overall Mean") ///
    C$rownumber = ("Overall SE") ///
    D$rownumber = ("Overall P-value") ///
    E$rownumber = ("Overall N0") ///
    F$rownumber = ("Overall N1")

global rownumber = $rownumber + 1 // leaving a blank row to indicate new regression results

// Defining the program to export the coefficients, SE, and p-values from our regressions
program define overall_coeff
    scalar pvalue = round(2 * (1 - normal(abs(_b[`1']/_se[`1']))),0.001)
    // Extract sample size
    count if `1' == 0 & e(sample)
    local no0 = r(N)
    count if `1' == 1 & e(sample)
    local no1 = r(N)
    putexcel_wait ///
        A$rownumber = ("`1'") ///
        B$rownumber = _b[`1'] ///
        C$rownumber = _se[`1'] ///
        D$rownumber = pvalue ///
        E$rownumber = `no0' ///
        F$rownumber = `no1' 
    global rownumber = $rownumber + 1 // leaving a blank row to indicate new regression results
end

qui eststo: reg lfsato $controlshealth dust noise odour [pw=rakedweight], vce(r)
overall_coeff dust
overall_coeff noise
overall_coeff odour

global rownumber = $rownumber + 1 // leaving a blank row to indicate new regression results

forval i=1/2 {
qui eststo: reg lfsato $controlshealth i.cat_dust_freq i.cat_noise_freq i.cat_odour_freq [pw=rakedweight], vce(r)
overall_coeff `i'.cat_dust_freq 
overall_coeff `i'.cat_noise_freq 
overall_coeff `i'.cat_odour_freq
}

global rownumber = $rownumber + 1 // leaving a blank row to indicate new regression results

forval i=1/2 {
qui eststo: reg lfsato $controlshealth i.cat_dust_intensity i.cat_noise_intensity i.cat_odour_intensity [pw=rakedweight], vce(r)
overall_coeff `i'.cat_dust_intensity
overall_coeff `i'.cat_noise_intensity
overall_coeff `i'.cat_odour_intensity
}

global rownumber = $rownumber + 1 // leaving a blank row to indicate new regression results

qui eststo: reg lfsato $controlshealth dust_combined_dum noise_combined_dum odour_combined_dum [pw=rakedweight], vce(r)
overall_coeff dust_combined_dum
overall_coeff noise_combined_dum
overall_coeff odour_combined_dum

global rownumber = $rownumber + 1 // leaving a blank row to indicate new regression results

forval i=1/3 {
qui eststo: reg lfsato $controlshealth i.dust_combined_cat i.noise_combined_cat i.odour_combined_cat [pw=rakedweight], vce(r)
overall_coeff `i'.dust_combined_cat
overall_coeff `i'.noise_combined_cat
overall_coeff `i'.odour_combined_cat
}

global rownumber = $rownumber + 1 // leaving a blank row to indicate new regression results

qui eststo: reg lfsato $controlshealth nuisance [pw=rakedweight], vce(r)
overall_coeff nuisance

global rownumber = $rownumber + 1 // leaving a blank row to indicate new regression results

qui eststo: reg lfsato $controlshealth nuisance_combined_dum [pw=rakedweight], vce(r)
overall_coeff nuisance_combined_dum

global rownumber = $rownumber + 1 // leaving a blank row to indicate new regression results

qui eststo: reg lfsato $controlshealth nuisance nuisance_combined_dum [pw=rakedweight], vce(r)
overall_coeff nuisance
overall_coeff nuisance_combined_dum

global rownumber = $rownumber + 1 // leaving a blank row to indicate new regression results

forval i=1/3 {
qui eststo: reg lfsato $controlshealth i.nuisance_combined_cat [pw=rakedweight], vce(r)
overall_coeff `i'.nuisance_combined_cat
}

global rownumber = $rownumber + 1 // leaving a blank row to indicate new regression results

forval i=1/3 {
*qui eststo: reg lfsato $controlshealth i.nuisance i.nuisance_combined_cat [pw=rakedweight], vce(r)
qui eststo: reg lfsato $controlshealth i.sum_nuisance [pw=rakedweight], vce(r)
overall_coeff `i'.sum_nuisance
}

global rownumber = $rownumber + 1 // leaving a blank row to indicate new regression results

forval i=1/3 {
qui eststo: reg lfsato $controlshealth i.sum_nuisance_combined [pw=rakedweight], vce(r)
overall_coeff `i'.sum_nuisance_combined
}

global rownumber = $rownumber + 1 // leaving a blank row to indicate new regression results

forval i=1/3 {
qui eststo: reg lfsato $controlshealth i.sum_nuisance i.sum_nuisance_combined [pw=rakedweight], vce(r)
overall_coeff `i'.sum_nuisance
overall_coeff `i'.sum_nuisance_combined
}

global rownumber = $rownumber + 1 // leaving a blank row to indicate new regression results

qui eststo: reg lfsato $controlshealth nuisance_effect [pw=rakedweight], vce(r)
overall_coeff nuisance_effect

global rownumber = $rownumber + 1 // leaving a blank row to indicate new regression results

qui eststo: reg lfsato $controlshealth nuisance_combined_dum_effect [pw=rakedweight], vce(r)
overall_coeff nuisance_combined_dum_effect

global rownumber = $rownumber + 1 // leaving a blank row to indicate new regression results

qui eststo: reg lfsato $controlshealth nuisance_effect nuisance_combined_dum_effect [pw=rakedweight], vce(r)
overall_coeff nuisance_effect
overall_coeff nuisance_combined_dum_effect

global rownumber = $rownumber + 1 // leaving a blank row to indicate new regression results

forval i=1/3 {
qui eststo: reg lfsato $controlshealth i.nuisance_combined_cat_effect [pw=rakedweight], vce(r)
overall_coeff `i'.nuisance_combined_cat_effect
}

global rownumber = $rownumber + 1 // leaving a blank row to indicate new regression results

forval i=1/3 {
*qui eststo: reg lfsato $controlshealth i.nuisance_effect i.nuisance_combined_cat_effect [pw=rakedweight], vce(r)
qui eststo: reg lfsato $controlshealth i.sum_nuisance_effect [pw=rakedweight], vce(r)
overall_coeff `i'.sum_nuisance_effect
}

global rownumber = $rownumber + 1 // leaving a blank row to indicate new regression results

forval i=1/3 {
qui eststo: reg lfsato $controlshealth i.sum_nuisance_combined_effect [pw=rakedweight], vce(r)
overall_coeff `i'.sum_nuisance_combined_effect
}

global rownumber = $rownumber + 1 // leaving a blank row to indicate new regression results

forval i=1/3 {
qui eststo: reg lfsato $controlshealth i.sum_nuisance_effect i.sum_nuisance_combined_effect [pw=rakedweight], vce(r)
overall_coeff `i'.sum_nuisance_effect
overall_coeff `i'.sum_nuisance_combined_effect
}

putexcel_wait set "$RESULTS", sheet("General & distance regs v2", replace) modify

* Variables of interest with the industry_distance interactions
eststo: reg lfsato $controlshealth dust noise odour i.industry_distance [pw=rakedweight], vce(r)
eststo: reg lfsato $controlshealth dust##industry_distance noise##industry_distance odour##industry_distance [pw=rakedweight], vce(r)
eststo: reg lfsato $controlshealth 0.dust##industry_distance 0.noise##industry_distance 0.odour##industry_distance [pw=rakedweight], vce(r)
eststo: reg lfsato $controlshealth i.dust_distance i.noise_distance i.odour_distance [pw=rakedweight], vce(r)
eststo: reg lfsato $controlshealth i.nuisance_distance [pw=rakedweight], vce(r)
eststo: reg lfsato $controlshealth i.nuisance_combined_distance [pw=rakedweight], vce(r)
eststo: reg lfsato $controlshealth ib6.industry_distance i.dust_distance i.noise_distance i.odour_distance [pw=rakedweight], vce(r)
eststo: reg lfsato $controlshealth ib6.industry_distance i.nuisance_distance [pw=rakedweight], vce(r)
eststo: reg lfsato $controlshealth ib6.industry_distance i.nuisance_combined_distance [pw=rakedweight], vce(r)
excel, name("General & distance regs v2") $esttab_opts replace

/*
eststo: reg lfsato $controlshealth cat_dust_freq##industry_distance cat_noise_freq##industry_distance cat_odour_freq##industry_distance [pw=rakedweight], vce(r)
eststo: reg lfsato $controlshealth cat_dust_intensity##industry_distance cat_noise_intensity##industry_distance cat_odour_intensity##industry_distance [pw=rakedweight], vce(r)

* Combination of high frequency and high intensity as a dummy, where 1 is for high intensity & frequency, and 0 otherwise
eststo: reg lfsato $controlshealth dust_combined_dum##industry_distance noise_combined_dum##industry_distance odour_combined_dum##industry_distance [pw=rakedweight], vce(r)

* Combination of high frequency and high intensity as a categorical, where 2 is for high intensity & frequency, 1 for either high intensity or frequency and 0 otherwise
eststo: reg lfsato $controlshealth dust_combined_cat##industry_distance noise_combined_cat##industry_distance odour_combined_cat##industry_distance [pw=rakedweight], vce(r)

excel, name("Regressions") $esttab_opts replace
eststo clear


putexcel_wait set "$RESULTS", sheet("General & vulnerable regs", replace) modify

* Variables of interest with the vulnerable variable interactions
eststo: reg lfsato $controlshealth cat_dust_freq##vulnerable cat_noise_freq##vulnerable cat_odour_freq##vulnerable [pw=rakedweight], vce(r)
eststo: reg lfsato $controlshealth cat_dust_intensity##vulnerable cat_noise_intensity##vulnerable cat_odour_intensity##vulnerable [pw=rakedweight], vce(r)

* Combination of high frequency and high intensity as a dummy, where 1 is for high intensity & frequency, and 0 otherwise
eststo: reg lfsato $controlshealth dust_combined_dum##vulnerable noise_combined_dum##vulnerable odour_combined_dum##vulnerable [pw=rakedweight], vce(r)

* Combination of high frequency and high intensity as a categorical, where 2 is for high intensity & frequency, 1 for either high intensity or frequency and 0 otherwise
eststo: reg lfsato $controlshealth dust_combined_cat##vulnerable noise_combined_cat##vulnerable odour_combined_cat##vulnerable [pw=rakedweight], vce(r)

excel, name("Regressions") $esttab_opts replace
*/
