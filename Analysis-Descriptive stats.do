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
* Descriptive stats
*----------------------------------------------------
use "$OUTPUT/Data/Singapore Nuisance study survey data (clean).dta", clear

* Set up the Excel file and sheet for Descriptives
putexcel_wait set "$RESULTS", sheet("Descriptives") modify 

* Adding a local for the rownumber (1 is for the names)
local rownumber = 2

global descriptives dust noise odour dust_highfreq noise_highfreq odour_highfreq dust_highintensity noise_highintensity odour_highintensity noise_daily dust_daily odour_daily ///
    noise_highintensity dust_highintensity odour_highintensity noise_hhintensity dust_hhintensity odour_hhintensity noise_combined_dum dust_combined_dum odour_combined_dum ///
    nuisance nuisance_highfreq nuisance_daily nuisance_combined_dum sum_nuisance_v2 sum_nuisance_highfreq_v2 sum_nuisance_daily_v2 sum_nuisance_combined_v2 ///
    industry_distance roads_distance transport_distance living_close_1km living_close_500m vulnerable

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

putexcel_wait set "$RESULTS", sheet("Descriptives cross") modify 

* Adding a local for the rownumber (1 is for the names)
local rownumber = 2

global sources source_neighbours source_commeract source_entertvenues source_retail source_cleanpublic source_constrsites source_roadtraffic source_other

* Setting column headers
putexcel A1 = "Variables Name" B1 = "Source industrial" C1 = "No" D1 = "Yes" E1 = "Total"

* Initialize rownumber for the first table
local rownumber = 2

* Loop over the list of variables
foreach var in $sources {
    * Insert the variable name in column A
    putexcel A`rownumber' = "`var'"
    
    * Perform the cross-tabulation (here with source_industrial, adjust as needed for your context)
    ta `var' source_industrial, matcell(freq) matrow(names)
    
    * Get the frequencies for "No", "Yes" and calculate the totals for each row
    local no_freq = freq[1,1] + freq[2,1]  // Frequency for 'No' category across rows
    local yes_freq = freq[1,2] + freq[2,2]  // Frequency for 'Yes' category across rows
    local total_freq = `no_freq' + `yes_freq'  // Total frequency
    
    local rowcounter = `rownumber' + 1  
    
    * Write "No" category frequencies in column C 
    putexcel B`rowcounter' = "No"
    putexcel C`rowcounter' = freq[1,1] 
    putexcel D`rowcounter' = freq[1,2] 
    
    * Increment rowcounter for the next category
    local rowcounter = `rowcounter' + 1
    
    * Write "Yes" category frequencies in column C 
    putexcel B`rowcounter' = "Yes"
    putexcel C`rowcounter' = freq[2,1] 
    putexcel D`rowcounter' = freq[2,2]
    
    * Increment rowcounter for the next category/next crosstab
    local rowcounter = `rowcounter' + 1
    
    * Write the totals at the end of the table
    putexcel B`rowcounter' = "Total"
    putexcel C`rowcounter' = `no_freq' 
    putexcel D`rowcounter' = `yes_freq' 
    putexcel E`rowcounter' = `total_freq' 
    
    * Increment rownumber for the next table (to leave a blank row between tables)
    local rownumber = `rowcounter' + 2
}
