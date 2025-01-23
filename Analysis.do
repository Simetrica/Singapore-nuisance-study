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
* Wellbeing values
*----------------------------------------------------
use "$OUTPUT/Data/Singapore Nuisance study survey data (clean).dta", clear

* Set up the Excel file and sheet for Descriptives
putexcel_wait set "$RESULTS", sheet("Descriptives") modify 

* Adding a local for the rownumber (1 is for the names)
local rownumber = 2

global descriptives dust noise odour dust_highfreq noise_highfreq odour_highfreq dust_highintensity noise_highintensity odour_highintensity dust_freq noise_freq odour_freq dust_intensity noise_intensity odour_intensity ///
    dust_combined_dum noise_combined_dum odour_combined_dum dust_combined_cat noise_combined_cat odour_combined_cat industry_distance roads_distance transport_distance living_close_1km living_close_500m vulnerable

* Setting column headers
putexcel A1 = "Variable Name" B1 = "Category" C1 = "Frequency" D1 = "Percent" 

* Loop over the list of variables
foreach var in $descriptives {
    putexcel A`rownumber' = "`var'" 
    ta `var', matcell(freq) matrow(names)
    local total = 0
    forval i = 1/`=rowsof(freq)' {
        local total = `total' + freq[`i',1]
    }
    
    * In order to write the categories in column B, frequencies in column C, and adding the percentages in column D
    local rowcounter = `rownumber' + 1  // starts writing from the next row so no overwriting the previous
    forval i = 1/`=rowsof(freq)' {
        putexcel B`rowcounter' = names[`i',1] 
        putexcel C`rowcounter' = freq[`i',1] 
        
        * Calculate and write the percentage in column D
        local percent = (freq[`i',1] / `total') * 100
        putexcel D`rowcounter' = `percent' 
        
        * Increment the row number by 1 for the next category
        local rowcounter = `rowcounter' + 1
    }
    
    * Write the total frequency at the end of each table in column C
    putexcel B`rowcounter' = "Total" 
    putexcel C`rowcounter' = `total' 
    
    * Increment the row number by 2 (to leave a blank row between tables)
    local rownumber = `rowcounter' + 2
}



putexcel_wait set "$RESULTS", sheet("General regressions", replace) modify

global esttab_opts not label star(* 0.10 ** 0.05 *** 0.01) mtitles stats(N r2, labels("N" "R-sq"))

global controlshealth leq_hhincome female married degree employed chinese children religious carer i.agecat source_neighbours source_commeract source_entertvenues source_retail source_cleanpublic ///
    source_constrsites source_roadtraffic source_other roads_distance transport_distance physicalhealth mentalhealth 


eststo: reg lfsato $controlshealth dust noise odour [pw=rakedweight], vce(r)
eststo: reg lfsato $controlshealth dust##dust_highfreq noise##noise_highfreq odour##odour_highfreq [pw=rakedweight], vce(r)
eststo: reg lfsato $controlshealth dust##dust_highintensity noise##noise_highintensity odour##odour_highintensity [pw=rakedweight], vce(r)
eststo: reg lfsato $controlshealth dust_highfreq##dust_highintensity noise_highfreq##noise_highintensity odour_highfreq##odour_highintensity [pw=rakedweight], vce(r)

excel, name("Regressions") $esttab_opts replace
eststo clear


putexcel_wait set "$RESULTS", sheet("General & distance regs", replace) modify

* Variables of interest with the industry_distance interactions
eststo: reg lfsato $controlshealth dust##industry_distance noise##industry_distance odour##industry_distance [pw=rakedweight], vce(r)
eststo: reg lfsato $controlshealth dust_highfreq##industry_distance noise_highfreq##industry_distance odour_highfreq##industry_distance [pw=rakedweight], vce(r)
eststo: reg lfsato $controlshealth dust_highintensity##industry_distance noise_highintensity##industry_distance odour_highintensity##industry_distance [pw=rakedweight], vce(r)

* Combination of high frequency and high intensity as a dummy, where 1 is for high intensity & frequency, and 0 otherwise
eststo: reg lfsato $controlshealth dust_combined_dum##industry_distance noise_combined_dum##industry_distance odour_combined_dum##industry_distance [pw=rakedweight], vce(r)

* Combination of high frequency and high intensity as a categorical, where 2 is for high intensity & frequency, 1 for either high intensity or frequency and 0 otherwise
eststo: reg lfsato $controlshealth dust_combined_cat##industry_distance noise_combined_cat##industry_distance odour_combined_cat##industry_distance [pw=rakedweight], vce(r)

excel, name("Regressions") $esttab_opts replace
eststo clear


putexcel_wait set "$RESULTS", sheet("General & vulnerable regs", replace) modify

* Variables of interest with the vulnerable variable interactions
eststo: reg lfsato $controlshealth dust_highfreq##vulnerable noise_highfreq##vulnerable odour_highfreq##vulnerable [pw=rakedweight], vce(r)
eststo: reg lfsato $controlshealth dust_highintensity##vulnerable noise_highintensity##vulnerable odour_highintensity##vulnerable [pw=rakedweight], vce(r)

* Combination of high frequency and high intensity as a dummy, where 1 is for high intensity & frequency, and 0 otherwise
eststo: reg lfsato $controlshealth dust_combined_dum##vulnerable noise_combined_dum##vulnerable odour_combined_dum##vulnerable [pw=rakedweight], vce(r)

* Combination of high frequency and high intensity as a categorical, where 2 is for high intensity & frequency, 1 for either high intensity or frequency and 0 otherwise
eststo: reg lfsato $controlshealth dust_combined_cat##vulnerable noise_combined_cat##vulnerable odour_combined_cat##vulnerable [pw=rakedweight], vce(r)

excel, name("Regressions") $esttab_opts replace

