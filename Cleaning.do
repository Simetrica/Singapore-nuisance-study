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

*---------------------------------------------------
* Import main data
*---------------------------------------------------

import excel using "$INPUT/Simetrica Jacob raw data - sent.xlsx", sheet("result") firstrow clear

*---------------------------------------------------
* Renaming
*---------------------------------------------------

* Pre-existing demographic questions
rename s1 female
rename s2 ageg
rename s3 ethnicity
rename s4 religion
rename s6 educ
rename s7 empvar
rename s15 income
rename s20 marital
rename s39 htype
rename s35 hsize

* Additional questions
rename q2r1 postcode
rename q2r2 mrt_station
rename q3 lfsato
rename q4 gen_health
rename q5 longstandingillness
rename q6 physicalhealth
rename q7 mentalhealth
rename q8r1 source_neighbours
rename q8r2 source_commeract
rename q8r3 source_entertvenues
rename q8r4 source_retail
rename q8r5 source_cleanpublic
rename q8r6 source_constrsites
rename q8r7 source_roadtraffic
rename q8r8 source_industrial
rename q8r9 source_other
rename q8r10 source_none
rename q9 text_source_other
rename q10 roads_distance
rename q11 transport_distance
rename q12 industry_distance
rename q13r1 dust
rename q13r2 noise
rename q13r3 odour
rename q13r4 nuisance_other
rename q13r5 nuisance_none
rename q14 text_nuisance_other
rename q15 dust_freq
rename q16 dust_intensity
rename q17 noise_freq
rename q18 noise_intensity
rename q19 odour_freq
rename q20 odour_intensity
rename q21r1 effect_sleep
rename q21r2 effect_recreation
rename q21r3 effect_focus
rename q21r4 effect_housework
rename q21r5 effect_windows
rename q21r6 effect_mood
rename q21r7 effect_symptoms
rename q21r8 effect_other
rename q21r9 effect_none
rename q22 text_effect_other
rename q23 vulnerable
rename q24 complaints
rename q25 lfsato_nuisance
rename q26 carer
rename q27 nchild


*--------------------------------------------------
* Labelling
*--------------------------------------------------

la var female 				"Female"
la var ageg 				"Age group"
la var ethnicity 			"Ethnicity"
la var religion 			"Religion"
la var educ 				"Level of education"
la var empvar 				"Employment status"
la var income 				"Monthly household income (categorical)"
la var marital 				"Relationship status"
la var htype 				"Housing type"
la var hsize 				"Household size"
la var postcode 			"2 digit postcode"
la var mrt_station 			"Closest MRT station"
la var lfsato				"Current life satisfaction (0-10)"
la var gen_health 			"General health"
la var longstandingillness	"Has long standing illness or impairment"
la var physicalhealth		"Physical health"
la var mentalhealth			"Mental health"
la var source_neighbours	"Neighbours"
la var source_commeract		"Community activities (e.g. playgrounds or exercise facilities)"
la var source_entertvenues	"Entertainment venues (e.g. sports arenas or concert halls)"
la var source_retail		"Retail commercial activities (e.g. shopping malls, food establishments) "
la var source_cleanpublic	"Cleaning of public areas"
la var source_constrsites	"Construction sites"
la var source_roadtraffic	"Road traffic or other transport"
la var source_industrial	"Industrial activities (e.g. warehousing and logistics; food and beverage manufacturing; wet labs; recycling plants; power plants or data centres)"
la var source_other			"Other"
la var source_none			"None of the above"
la var text_source_other 	"Other environment nuisance they are affected by"
la var roads_distance		"Distance of a busy road from home"
la var transport_distance	"Distance of a transport hub from home"
la var industry_distance	"Distance of an industrial industry from home"
la var dust 				"Dust/Smoke nuisance affecting you in your home"
la var noise 				"Noise nuisance affecting you in your home"
la var odour 				"Smell/Odour nuisance affecting you in your home"
la var nuisance_other 		"Other nuisance affecting you in your home"
la var nuisance_none 		"None nuisance affecting you in your home"
la var text_nuisance_other 	"Text for other type of nuisances affecting you in your home"
la var dust_freq			"Frequency of dust nuisance"
la var dust_intensity		"Intensity of dust nuisance"
la var noise_freq			"Frequency of noise nuisance"
la var noise_intensity		"Intensity of noise nuisance"
la var odour_freq			"Frequency of odour nuisance"
la var odour_intensity		"Intensity of odour nuisance"
la var effect_sleep			"It affects my sleep"
la var effect_recreation	"It affects my recreation and relaxing time at home"
la var effect_focus			"It affects my focus when studying or working at home"
la var effect_housework		"It affects my way of doing housework at my home (e.g. how often it is vacuumed, when are meals cooked, or how the laundry is done)"
la var effect_windows		"It affects when/how often I can open the windows at my home"
la var effect_mood			"It affects my mood, making me anxious or angrier than usual"
la var effect_symptoms		"It makes me prone to experiencing physiological symptoms, such as headaches, feeling dizzy or nauseous, respiratory infections, difficulty breathing, loss of appetite, etc."
la var effect_other			"Other effect"
la var effect_none			"Not at all"
la var text_effect_other 	"Text for other ways nuisances affect you"
la var vulnerable			"Members of your household particularly vulnerable to the nuisance exposure"
la var complaints			"Submitted a complaint regarding the nuisance experiencing"
la var lfsato_nuisance		"Life satisfaction - taking into consideration nuisance"
la var carer 				"Is a carer"
la var nchild 				"Parent (No. of children)"

*--------------------------------------------------
* Add survey questions to notes
*--------------------------------------------------

notes ethnicity: 			What is your race?
notes religion: 			What is your religion?
notes educ: 				What is your highest level of education?
notes empvar: 				What is your primary employment status?
notes income: 				What is your monthly household income? Monthly household income: Your total household income (the monthly income of everyone in the same household added together)
notes marital: 				What is your current relationship status?
notes htype: 				You currently live in a...
notes hsize: 				How many people other than yourself are living in your household?
notes postcode:				Could you please provide the first two digits of your 6-digit postcode?
notes mrt_station:			Could you please provide the name of the MRT station nearest to your home?
notes lfsato: 				Overall, how satisfied are you with your life nowadays?
notes gen_health:			In general, would you say your health is...
notes longstandingillness:	Do you have any long-standing physical or mental impairment, illness or disability?
notes physicalhealth:		Have you ever been diagnosed by a doctor or other health professional with any long-term health condition?
notes mentalhealth:			Have you ever been diagnosed by a doctor or other health professional with any long-term mental health condition?
notes roads_distance:		Approximately, how close do you live to a busy road or roads?
notes transport_distance:	Approximately, how close do you live to a transport hub such as an MRT/LRT station, bus interchange, ferry terminal, airport or port?
notes industry_distance:	Approximately, how close do you live to an industrial facility, such as a warehousing and logistics hub; automotive/vehicle repair shop; industrial building, machinery or storage; wafer and semiconductor fabrication plant; food and beverage manufacturing site; wet lab; recycling plant; power plant or a data centre? 
notes dust_freq:			How often do you experience dust nuisance in your home environment?
notes dust_intensity:		At the times you are experiencing a dust nuisance, how would you rate the intensity of this nuisance in your home environment?
notes noise_freq:			How often do you experience  noise nuisance in your home environment?
notes noise_intensity:		At the times you are experiencing a noise nuisance, how would you rate the intensity of this nuisance in your home environment?
notes odour_freq:			How often do you experience odour nuisance in your home environment?
notes odour_intensity:		At the times you are experiencing an odour nuisance, how would you rate the intensity of this nuisance in your home environment?
notes vulnerable:			Are any members of your household particularly vulnerable to the nuisance exposure - for example, young children, older adults, those who are at home throughout most of the day, persons with long-term health conditions or disabilities?
notes complaints:			In the last 12 months have you submitted a complaint to either a local government body or the National Environment Agency regarding a nuisance that you have experienced?
notes lfsato_nuisance:		Overall, taking all of the above factors around nuisance from industrial activities and utility infastracturue, how satisfied are youwith your life nowadays?
notes carer:				Do you look after a family member, partner or friend who needs help because of their illness, frailty, disability, a mental health problem or an addiction and cannot cope without your support?
notes nchild: 				How many children under the age of 16 live in your household? 

*--------------------------------------------------
* Recoding
*--------------------------------------------------
global yesnovars longstandingillness physicalhealth mentalhealth vulnerable complaints carer source_* dust noise odour nuisance_other nuisance_none effect_*
foreach var in $yesnovars {
	recode `var' (2=0) (3=.)
}

recode female 	    (1=0) (2=1)
recode nchild (1=0) (2=1) (3=2) (4=3) (5=4) (6=.)
recode *_intensity (5=.) // adds the ones that have selected the nuisance but answered "Don't know" for the intensity with the overall missing-which also include those that dont qualify for this question since they didnt select that type of nuisance
recode *_freq (6=.)  // adds the ones that have selected the nuisance but answered "Don't know" for the frequency with the overall missing-which also include those that dont qualify for this question since they didnt select that type of nuisance
recode *_distance (7=.)
recode income (10=.)

*--------------------------------------------------
* Encoding
*--------------------------------------------------

* Gender
la def female ///
	0 "Male" ///
	1 "Female"
la val female female

*Age group
la def ageg ///
	1 "16-24" ///
	2 "25-34" ///
	3 "35-44" ///
	4 "45-54" ///
	5 "55+"
la val ageg ageg

* Ethnicity
la def ethnicity ///
	1  "Chinese" ///
	2  "Indian" ///
	3  "Malay" ///
	4  "Caucasian" ///
	5  "Others" ///
	.a "Rather not say"
la val ethnicity ethnicity

* Religion
la def religion ///
	1 "Christianity" ///
	2 "Buddhism" ///
	3 "Islam" ///
	4 "Taoism" ///
	5 "Hinduism" ///
	6 "Other Religion" ///
	7 "Agnostic (existence of God cannot be known)" ///
	8 "Atheist (lack of belief in the existence of God)" ///
	9 "Free thinker (own opinions on religion)"
la val religion religion

* Education
la def educ ///
	1 "No formal education" ///
	2 "O Levels and below" ///
	3 "Diploma/A Levels/Other Professional Certification" ///
	4 "University (Bachelor) Degree" ///
	5 "Post-Graduate/Masters" ///
	6 "PhD"
la val educ educ

* Employment status
la def empvar ///
	1 "Permanent Staff" ///
	2 "Temporary/Contract-Staff" ///
	3 "Part-time" ///
	4 "Self-employed" ///
	5 "Freelancer (e.g. Designers and Photographer)" ///
	6 "Gig-economy (e.g. Grab drivers and Food deliverers)" ///
	7 "Business owner (running a company)" ///
	8 "Student" ///
	9 "Homemaker" ///
	10 "Retired" ///
	11 "Unemployed - looking for opportunities" ///
	12 "Unemployed - not looking for opportunities" ///
	13 "Others"
la val empvar empvar

* Monthly household income
la def income ///
	1  "$0 - $2,999" ///
	2  "$3,000 - $3,999" ///
	3  "$4,000 - $5,999" ///
	4  "$6,000 - $8,999" ///
	5  "$9,000 - $9,999" ///
	6  "$10,000 - $11,999" ///
	7  "$12,000 - $14,999" ///
	8  "$15,000 - $17,999" ///
	9  "$18,000+" ///
	.a	"I am not sure"
la val income income

* Marital status
la def marital ///
	1 "Single, actively looking" ///
	2 "Single, not actively looking" ///
	3 "In a Relationship" ///
	4 "Engaged" ///
	5 "Married" ///
	6 "Divorce/Separated" ///
	7 "Widowed"
la val marital marital

* Household type
la def htype ///
	1 "HDB 1-2 room" ///
	2 "HDB 3-room" ///
	3 "HDB 4-room" ///
	4 "HDB 5-room / Executive Flat" ///
	5 "Executive Condominium/ HUDC Flat" ///
	6 "Private Property (e.g. private apartment, condominium, landed property)" ///
	7 "Others not listed" 
la val htype htype

* Household size
la def hsize ///
	1 "None, I live by myself" ///
	2 "1" ///
	3 "2" ///
	4 "3 to 4" ///
	5 "5 to 7" ///
	6 "8 or more"
la val hsize hsize

* General health
la def gen_health ///
	1 "Poor" ///
	2 "Fair" ///
	3 "Good" ///
	4 "Very good" ///
	5 "Excellent"
la val gen_health gen_health

* Long standing illness, physical and mental health, submitted a complaint and carer vars
global yesnovars longstandingillness physicalhealth mentalhealth vulnerable complaints carer source_* nuisance_other nuisance_none effect_*
la def yesno ///
	0  "No" ///
	1  "Yes" ///
	.a "Don't know/Rather not say"
la val $yesnovars yesno

la def dust ///
	0  "No dust nuisance" ///
	1  "Yes for dust nuisance" ///
	.a "Don't know/Rather not say"
la val dust dust

la def noise ///
	0  "No noise nuisance" ///
	1  "Yes for noise nuisance" ///
	.a "Don't know/Rather not say"
la val noise noise

la def odour ///
	0  "No odour nuisance" ///
	1  "Yes for odour nuisance" ///
	.a "Don't know/Rather not say"
la val odour odour

* Frequency of nuisances
global freq dust_freq noise_freq odour_freq

la def freq ///
	1 "At least once a day" ///
	2 "Not daily but at least once a week" ///
	3 "Not weekly but at least once a month" ///
	4 "Not monthly but at least once a year" ///
	5 "Never" 
la val $freq freq

* Intensity of nuisances
global intensity dust_intensity noise_intensity odour_intensity

la def intensity ///
	1 "Light to moderate but not problematic" ///
	2 "Somewhat problematic but not sufficient to interfere" ///
	3 "Problematic and tends to interfere" ///
	4 "Highly problematic and potentially harmful to health"
la val $intensity intensity

* Distance of sources of nuisances
global distance roads_distance transport_distance industry_distance

la def distance ///
	1 "Less than 50m" ///
	2 "50-100m" ///
	3 "100-500m" ///
	4 "500m-1km" ///
	5 "1-2km" ///
	6 "More than 2km"
la val $distance distance

* Number of children 
la def nchild ///
	0 "No children" ///
	1 "1 child" ///
	2 "2 children" ///
	3 "3 children" ///
	4 "4 or more"
la val nchild nchild

*---------------------------------------------------
* Generating variables
*---------------------------------------------------

* Age squared
gen age2 = age*age
la var age2 "Age squared"

* Age categories (for split-sample regressions)
recode ageg (1=1) (2/4=2) (5=3), gen(agecat)
la var agecat "Age (3 cat)"

la def agecat ///
	1 "16-24" ///
	2 "25-54" ///
	3 "55+"
la val agecat agecat

* Chinese (dummy)
gen chinese = ethnicity == 1 if ethnicity < .
la var chinese "Is Chinese"
la val chinese yesno

* Christian (dummy)
gen religious = religion < 7 if religion < .
la var religious "Is religious"
la val religious yesno

* Has a degree (dummy)
gen degree = educ > 3 if educ < .
la var degree "Has a degree or higher"
la val degree yesno

* Employed (dummy)
gen employed = empvar < 8 if empvar < .
la var employed "Is currently employed"
la val employed yesno

* Employed (categorical)
gen employed_cat=0
replace employed_cat=1 if (empvar<11 & empvar>7 & empvar<.)  | (empvar>11 & empvar<.)
replace employed_cat=2 if empvar<8 & empvar<.
la var employed_cat "Is currently employed categorical"

la def employed_cat ///
	0 "Unemployed" ///
	1 "Student, retired, unemployed not looking etc." ///
	2 "Employed"
la val employed_cat employed_cat

* Married (dummy)
gen married = marital == 5 if marital < .
la var married "Is married"
la val married yesno

* Marital (truncated categorical)
recode marital (1/2=0) (3/4=1) (5=2) (6=3) (7=4), gen(marital_trunc)
la var marital_trunc "Marital status (truncated)"

la def marital_trunc ///
	0 "Single" ///
	1 "In a Relationship" ///
	2 "Married" ///
	3 "Divorced/Separated" ///
	4 "Widowed"
la val marital_trunc marital_trunc

* Employment status (truncated categorical)
recode empvar (11/12=11) (13=12), gen(empvar_trunc)
la var empvar_trunc "Employment status (truncated)"

la def empvar_trunc ///
	1 "Permanent Staff" ///
	2 "Temporary/Contract-Staff" ///
	3 "Part-time" ///
	4 "Self-employed" ///
	5 "Freelancer (e.g. Designers and Photographer)" ///
	6 "Gig-economy (e.g. Grab drivers and Food deliverers)" ///
	7 "Business owner (running a company)" ///
	8 "Student" ///
	9 "Homemaker" ///
	10 "Retired" ///
	11 "Unemployed" ///
	12 "Others"
la val empvar_trunc empvar_trunc

* Has children (dummy)
gen children = nchild != .
la var children "Has children"
la val children yesno


* Good health (dummy)
gen ghealth = gen_health > 3 if gen_health < .
la var ghealth "Has very good or excellent health"
la val ghealth yesno


// What we used in the other Singapore project

* Annual household income
decode income, gen(inc_cat) 						  // Convert to a string
replace inc_cat = subinstr(inc_cat,"+"," - 17,999",.) // Replace the "+" with the maximum in the below category
split inc_cat, p("-") 								  // Split before and after the "-", creating two variables
destring inc_cat1 inc_cat2, i(", $") replace 		  // Convert these to integers
gen hmincome = (inc_cat1 + inc_cat2 +1) / 2           // Find the midpoints
gen hhincome = hmincome*12 						      // Convert from monthly household income to annual household income
la var hhincome "Annual household income"
la var hmincome "Monthly household income"

* Log of annual household income
gen lhhincome = ln(hhincome)
la var lhhincome "Natural logarithm of annual household income"

* Equivalised income
* Number of adults in the household for the lower bound of the categories
gen adults_a=.
replace adults_a= 1 if hsize==1 | (hsize==2 & (nchild>0 | nchild==.) )| (hsize==3 & nchild>1 & nchild<.) | (hsize==4 & nchild>2 & nchild<.) 
replace adults_a= 2 if (hsize==2 & (nchild==. | nchild==0)) | (hsize==3 & nchild==1)  | (hsize==4 & nchild==2) | (hsize==5 & nchild==4)
replace adults_a= 3 if (hsize==3 & (nchild==. | nchild==0)) | (hsize==4 & nchild==1) | (hsize==5 & nchild==3)
replace adults_a= 4 if (hsize==4 & (nchild==. | nchild==0)) | (hsize==5 & nchild==2)
replace adults_a= 5 if (hsize==5 & (nchild==. | nchild==1)) | (hsize==6 & nchild==4)
replace adults_a= 6 if (hsize==5 & (nchild==. | nchild==0)) | (hsize==6 & nchild==3)
replace adults_a= 7 if hsize==6 & (nchild==. | nchild==2) 
replace adults_a= 8 if hsize==6 & (nchild==. | nchild==1)
replace adults_a= 9 if hsize==6 & (nchild==. | nchild==0)
la var adults_a "Lower bound of adults in the household"

la def adults ///
	1 "1 adult in the household" ///
	2 "2 adults in the household" ///
	3 "3 adults in the household" ///
	4 "4 adults in the household" ///
	5 "5 adults in the household" ///
	6 "6 adults in the household" ///
	7 "7 adults in the household" ///
	8 "8 adults in the household" ///
	9 "9 adults in the household"
la val adults_a adults

* Number of adults in the household for the upper bound of the categories
gen adults_b=.
replace adults_b= 1 if hsize==1 | (hsize==2 & nchild>0) | (hsize==3 & nchild>1 & nchild<.) | (hsize==4 & nchild==4)  | nchild==.
replace adults_b= 2 if (hsize==2 & (nchild==. | nchild==0)) | (hsize==3 & nchild==1) | (hsize==4 & nchild==3) 
replace adults_b= 3 if (hsize==3 & (nchild==. | nchild==0)) | (hsize==4 & nchild==2) 
replace adults_b= 4 if (hsize==4 & (nchild==. | nchild==1)) | (hsize==5 & nchild==4) 
replace adults_b= 5 if (hsize==4 & (nchild==. | nchild==0)) | (hsize==5 & nchild==3) | (hsize==6 & nchild==4)
replace adults_b= 6 if (hsize==5 & (nchild==. | nchild==2)) | (hsize==6 & nchild==3)
replace adults_b= 7 if (hsize==5 & (nchild==. | nchild==1)) | (hsize==6 & nchild==2) 
replace adults_b= 8 if (hsize==5 & (nchild==. | nchild==0)) | (hsize==6 & nchild==1)
replace adults_b= 9 if hsize==6 & (nchild==. | nchild==0)
la var adults_b "Lower bound of adults in the household"
la val adults_b adults

* Number of children in the household
gen child_inc=.
replace child_inc=0 if hsize==1 | nchild==0 | nchild==.
replace child_inc=1 if (hsize==2 & nchild>0) | (hsize>2 & nchild==1)
replace child_inc=2 if (hsize==3 & nchild>1) | (hsize>3 & nchild==2)
replace child_inc=3 if (hsize>3 & nchild==3)
replace child_inc=4 if (hsize>3 & nchild==4)
la var child_inc "Number of children in the household"

la def child_inc ///
	1 "1 child in the household" ///
	2 "2 children in the household" ///
	3 "3 children in the household" ///
	4 "4 children in the household" 
la val child_inc child_inc

/* Using the definition of Powdthavee_Lekfuanglu_Wooden_2015
Equivalised real annual household income is calculated using the following formula:
real annual household income/(1 + 0.5*(number of adult household members
- 1) + 0.3*(number of children aged less than 15 in the household)).
*/
	
gen eq_hhincome = hhincome / ( 1 + 0.5*(adults_a - 1) + 0.3*child_inc) // adults defined as 14+ so some overlap
la var eq_hhincome "Equivalised household income"

gen leq_hhincome = log(eq_hhincome + 1)
la var leq_hhincome "Log equivalised household income (+1 correction)"

// Generating variables of interest

// Living within 1km of an industrial site
gen living_close_1km= industry_distance<5 if industry_distance<.
la var living_close_1km "Lives within 1km"

la def living_close_1km ///
	0 "Lives further than 1km" ///
	1 "Lives close <1km"
la val living_close_1km living_close_1km


// Living within 500m of an industrial site
gen living_close_500m= industry_distance<4 if industry_distance<.
la var living_close_500m "Lives within 500m"

la def living_close_500m ///
	0 "Lives further than 500m" ///
	1 "Lives close <500m"
la val living_close_500m living_close_500m

*---------------------
* Alternative 1
*---------------------
// High intensity vars for the three sources
gen dust_highintensity= dust_intensity>2 if dust_intensity<.
replace dust_highintensity=0 if dust_intensity==.
la var dust_highintensity "Problematic to highly problematic"

la def dust_highintensity ///
	0 "No intense dust" ///
	1 "Dust with high intensity"
la val dust_highintensity dust_highintensity


gen noise_highintensity=noise_intensity>2 if noise_intensity<.
replace noise_highintensity=0 if noise_intensity==.
la var noise_highintensity "Problematic to highly problematic"

la def noise_highintensity ///
	0 "No intense noise" ///
	1 "Noise with high intensity"
la val noise_highintensity noise_highintensity

gen odour_highintensity=odour_intensity>2 if odour_intensity<.
replace odour_highintensity=0 if odour_intensity==.
la var odour_highintensity "Problematic to highly problematic"

la def odour_highintensity ///
	0 "No intense odour" ///
	1 "Odour with high intensity"
la val odour_highintensity odour_highintensity

// High frequency vars for the three sources
gen dust_highfreq=dust_freq<3 if dust_freq<.
replace dust_highfreq=0 if dust_freq==.
la var dust_highfreq "At least once a week"

la def dust_highfreq ///
	0 "No frequent dust" ///
	1 "Dust with high frequency"
la val dust_highfreq dust_highfreq

gen noise_highfreq=noise_freq<3 if noise_freq<.
replace noise_highfreq=0 if noise_freq==.
la var noise_highfreq "At least once a week"

la def noise_highfreq ///
	0 "No frequent noise" ///
	1 "Noise with high frequency"
la val noise_highfreq noise_highfreq

gen odour_highfreq=odour_freq<3 if odour_freq<.
replace odour_highfreq=0 if odour_freq==.
la var odour_highfreq "At least once a week"

la def odour_highfreq ///
	0 "No frequent odour" ///
	1 "Odour with high frequency"
la val odour_highfreq odour_highfreq

* Dummies for the combination of high frequency and high intensity
gen dust_combined_dum=0
replace dust_combined_dum=1 if dust_highfreq==1 & dust_highintensity==1
la var dust_combined_dum "Dummy dust high frequency and intensity"

la def dust_combined_dum ///
	0 "No intense or freq dust" ///
	1 "Dust with high freq & intensity"
la val dust_combined_dum dust_combined_dum


gen noise_combined_dum=0
replace noise_combined_dum=1 if noise_highfreq==1 & noise_highintensity==1
la var noise_combined_dum "Dummy noise high frequency and intensity"

la def noise_combined_dum ///
	0 "No intense or freq noise" ///
	1 "Noise with high freq & intensity"
la val noise_combined_dum noise_combined_dum

gen odour_combined_dum=0
replace odour_combined_dum=1 if odour_highfreq==1 & odour_highintensity==1
la var odour_combined_dum "Dummy odour high frequency and intensity"

la def odour_combined_dum ///
	0 "No intense or freq odour" ///
	1 "Odour with high freq & intensity"
la val odour_combined_dum odour_combined_dum

// Categorical for the combination of high frequency and high intensity
gen dust_combined_cat=dust*2
replace dust_combined_cat=1 if dust==1 & dust_highfreq!=1 & dust_highintensity!=1
replace dust_combined_cat=3 if dust_highfreq==1 & dust_highintensity==1
la var dust_combined_cat "Categorical dust for high frequency and intensity"

la def dust_cat ///
	0 "No dust experienced" ///
	1 "Dust and low intensity and low frequency" ///
	2 "Dust and either high intensity or high frequency" ///
	3 "Dust and high intensity and frequency" 
la val dust_combined_cat dust_cat

gen noise_combined_cat=noise*2
replace noise_combined_cat=1 if noise==1 & noise_highfreq!=1 & noise_highintensity!=1
replace noise_combined_cat=3 if noise_highfreq==1 & noise_highintensity==1
la var noise_combined_cat "Categorical noise for high frequency and intensity"

la def noise_cat ///
	0 "No noise experienced" ///
	1 "Noise and low intensity and low frequency" ///
	2 "Noise and either high intensity or high frequency" ///
	3 "Noise and high intensity and frequency" 
la val noise_combined_cat noise_cat

gen odour_combined_cat=odour*2
replace odour_combined_cat=1 if odour==1 & odour_highfreq!=1 & odour_highintensity!=1
replace odour_combined_cat=3 if odour_highfreq==1 & odour_highintensity==1
la var odour_combined_cat "Categorical odour for high frequency and intensity"

la def odour_cat ///
	0 "No odour experienced" ///
	1 "Odour and low intensity and low frequency" ///
	2 "Odour and either high intensity or high frequency" ///
	3 "Odour and high intensity and frequency" 
la val odour_combined_cat odour_cat

// Each source interaction with distance
gen dust_distance=dust_combined_dum
replace dust_distance=7-industry_distance if dust_combined_dum==1 & industry_distance<=6
la def dust_distance_lbl ///
	0 "No dust experienced" ///
	1 "Dust and More than 2km from industry" ///
	2 "Dust and 1-2km from industry" ///
	3 "Dust and 500m-1km from industry" ///
	4 "Dust and 100-500m from industry" ///
	5 "Dust and 50-100m from industry" ///
	6 "Dust and Less than 50m from industry"
la val dust_distance dust_distance_lbl

gen noise_distance=noise_combined_dum
replace noise_distance=7-industry_distance if noise_combined_dum==1 & industry_distance<=6
la def noise_distance_lbl ///
	0 "No noise experienced" ///
	1 "Noise and More than 2km from industry" ///
	2 "Noise and 1-2km from industry" ///
	3 "Noise and 500m-1km from industry" ///
	4 "Noise and 100-500m from industry" ///
	5 "Noise and 50-100m from industry" ///
	6 "Noise and Less than 50m from industry"
la val noise_distance noise_distance_lbl

gen odour_distance=odour_combined_dum
replace odour_distance=7-industry_distance if odour_combined_dum==1 & industry_distance<=6
la def odour_distance_lbl ///
	0 "No odour experienced" ///
	1 "Odour and More than 2km from industry" ///
	2 "Odour and 1-2km from industry" ///
	3 "Odour and 500m-1km from industry" ///
	4 "Odour and 100-500m from industry" ///
	5 "Odour and 50-100m from industry" ///
	6 "Odour and Less than 50m from industry"
la val odour_distance odour_distance_lbl

//Nuisance sources combined
gen nuisance=(dust==1|noise==1|odour==1)
la var nuisance "Any of the three nuisances"
la def nuisance_lbl ///
	0 "No nuisance experienced" ///
	1 "At least one nuisance"
la val nuisance nuisance_lbl

gen sum_nuisance=dust+noise+odour
la var sum_nuisance "Number of nuisances experienced"
la def sum_nuisance ///
	0 "No nuisance experienced" ///
	1 "One nuisance experienced" ///
	2 "Two nuisance experienced" ///
	3 "Three nuisance experienced" 
la val sum_nuisance sum_nuisance

gen sum_nuisance_combined=dust_combined_dum+noise_combined_dum+odour_combined_dum
la var sum_nuisance_combined "Number of high frequency and high intensity nuisances experienced"
la def sum_nuisance_combined ///
	0 "No frequent or intense nuisance experienced" ///
	1 "One high frequency and intense nuisance experienced" ///
	2 "Two high frequency and intense nuisances experienced" ///
	3 "Three high frequency and intense nuisances experienced" 
la val sum_nuisance_combined sum_nuisance_combined

gen nuisance_combined_dum=(sum_nuisance_combined>=1)
la var nuisance_combined_dum "Dummy any nuisance with high frequency and intensity"
la def nuisance_combined_dum_lbl ///
	0 "No frequent and intense nuisance experienced" ///
	1 "At least one frequent and intense nuisance"
la val nuisance_combined_dum nuisance_combined_dum_lbl

gen nuisance_combined_cat=nuisance
replace nuisance_combined_cat=2 if sum_nuisance_combined==1
replace nuisance_combined_cat=3 if sum_nuisance_combined>=2
la var nuisance_combined_cat "Categorical any nuisance by frequency and intensity"
la def nuisance_combined_cat_lbl ///
	0 "No frequent and intense nuisance experienced" ///
	1 "Some nuisance but none that is intense and frequent" ///
	2 "Some nuisance with one frequent and intense" ///
	3 "At least two frequent and intense nuisances"
la val nuisance_combined_cat nuisance_combined_cat_lbl

*Accounting for effects response
gen effect_sum = effect_sleep + effect_recreation + effect_focus + effect_housework + effect_windows + effect_mood + effect_symptoms + effect_other

gen nuisance_effect=nuisance
replace nuisance_effect=0 if effect_none==1 | effect_sum==0
la var nuisance_effect "Experiencing an effect through any of the three nuisances"
la def nuisance_effect ///
	0 "No effect through any nuisance" ///
	1 "Effect through any nuisance"
la val nuisance_effect nuisance_effect

gen nuisance_combined_dum_effect=nuisance_combined_dum
replace nuisance_combined_dum_effect=0 if effect_none==1 | effect_sum==0
la var nuisance_combined_dum_effect "Experiencing an effect through high frequency and intense nuisances"
la def nuisance_combined_dum_effect ///
	0 "No effect through any high frequency and intense nuisance" ///
	1 "Effect through any high and intense nuisance"
la val nuisance_combined_dum_effect nuisance_combined_dum_effect

gen nuisance_combined_cat_effect=nuisance_combined_cat
replace nuisance_combined_cat_effect=0 if effect_none==1 | effect_sum==0
la var nuisance_combined_cat_effect "Effect with nuisances by frequency and intensity"
la def nuisance_combined_cat_effect ///
	0 "No effect from any frequent and intense nuisance experienced" ///
	1 "Effect from some but none intense and frequent nuisance" ///
	2 "Effect from some with at least one frequent and intense nuisance" ///
	3 "Effect from at least two frequent and intense nuisances"
la val nuisance_combined_cat_effect nuisance_combined_cat_effect

gen sum_nuisance_effect=sum_nuisance
replace sum_nuisance_effect=0 if effect_none==1 | effect_sum==0
la var sum_nuisance_effect "Effect with the number of nuisances"
la def sum_nuisance_effect ///
	0 "No effect from any nuisances experienced" ///
	1 "Effect from one nuisance" ///
	2 "Effect from two nuisances" ///
	3 "Effect from three nuisances"
la val sum_nuisance_effect sum_nuisance_effect


gen sum_nuisance_combined_effect=sum_nuisance_combined
replace sum_nuisance_combined_effect=0 if effect_none==1 | effect_sum==0
la var sum_nuisance_combined_effect "Effect with the number of frequent and intense nuisances"
la def sum_nuisance_combined_effect ///
	0 "No effect from any frequent and intense nuisance experienced" ///
	1 "Effect from one frequent and intense nuisance" ///
	2 "Effect from two frequent and intensen nuisances" ///
	3 "Effect from three frequent and intense nuisances"
la val sum_nuisance_combined_effect sum_nuisance_combined_effect


***

gen nuisance_distance=nuisance
replace nuisance_distance=7-industry_distance if nuisance==1 & industry_distance<=6
la var nuisance_distance "Distance from any nuisance"
la def nuisance_distance_lbl ///
	0 "No nuisance experienced" ///
	1 "At least one nuisance and More than 2km from industry" ///
	2 "At least one nuisance and 1-2km from industry" ///
	3 "At least one nuisance and 500m-1km from industry" ///
	4 "At least one nuisance and 100-500m from industry" ///
	5 "At least one nuisance and 50-100m from industry" ///
	6 "At least one nuisance and Less than 50m from industry"
la val nuisance_distance nuisance_distance_lbl

gen nuisance_combined_distance=nuisance_combined_dum
replace nuisance_combined_distance=7-industry_distance if nuisance_combined_cat==1 & industry_distance<=6
la var nuisance_combined_distance "Distance from nuisance with high frequency and intensity"
la def nuisance_combined_distance_lbl ///
	0 "No frequent/intense nuisance experienced" ///
	1 "At least one frequent/intense nuisance and More than 2km from industry" ///
	2 "At least one frequent/intense nuisance and 1-2km from industry" ///
	3 "At least one frequent/intense nuisance and 500m-1km from industry" ///
	4 "At least one frequent/intense nuisance and 100-500m from industry" ///
	5 "At least one frequent/intense nuisance and 50-100m from industry" ///
	6 "At least one frequent/intense nuisance and Less than 50m from industry"
la val nuisance_combined_distance nuisance_combined_distance_lbl

gen industry_distance2 = industry_distance
replace industry_distance2=9 if industry_distance==.

gen industry_distance_2km = (industry_distance<=5)
replace industry_distance_2km=9 if industry_distance==.

gen industry_distance_1km = (industry_distance<=4)
replace industry_distance_1km=9 if industry_distance==.

gen industry_distance_500m = (industry_distance<=3)
replace industry_distance_500m=9 if industry_distance==.

gen industry_distance_100m = (industry_distance<=2)
replace industry_distance_100m=9 if industry_distance==.

*---------------------
* Alternative 2
*---------------------

// Intensity vars for the three sources
gen cat_dust_intensity= 0
replace cat_dust_intensity=1 if (dust==1 & dust_intensity<3 & dust_intensity<.) | (dust==1 & dust_intensity==.) 
replace cat_dust_intensity=2 if dust==1 & dust_intensity>2 & dust_intensity<.
la var cat_dust_intensity "Dust categorical for intensity"

la def cat_dust_intensity ///
	0 "No dust" ///
	1 "Dust with low intensity" ///
	2 "Dust with high intensity"
la val cat_dust_intensity cat_dust_intensity

gen cat_noise_intensity= 0
replace cat_noise_intensity=1 if (noise==1 & noise_intensity<3 & noise_intensity<.) | (noise==1 & noise_intensity==.) 
replace cat_noise_intensity=2 if noise==1 & noise_intensity>2 & noise_intensity<.
la var cat_noise_intensity "Noise categorical for intensity"

la def cat_noise_intensity ///
	0 "No noise" ///
	1 "Noise with low intensity" ///
	2 "Noise with high intensity"
la val cat_noise_intensity cat_noise_intensity

gen cat_odour_intensity= 0
replace cat_odour_intensity=1 if (odour==1 & odour_intensity<3 & odour_intensity<.) | (odour==1 & odour_intensity==.) 
replace cat_odour_intensity=2 if odour==1 & odour_intensity>2 & odour_intensity<.
la var cat_odour_intensity "Odour categorical for intensity"

la def cat_odour_intensity ///
	0 "No odour" ///
	1 "Odour with low intensity" ///
	2 "Odour with high intensity"
la val cat_odour_intensity cat_odour_intensity


// Frequency vars for the three sources
gen cat_dust_freq= 0
replace cat_dust_freq=1 if (dust==1 & dust_freq>2 & dust_freq<.) | (dust==1 & dust_freq==.) 
replace cat_dust_freq=2 if dust==1 & dust_freq<3 & dust_freq<.
la var cat_dust_freq "Dust categorical for frequency"

la def cat_dust_freq ///
	0 "No dust" ///
	1 "Dust with low frequency" ///
	2 "Dust with high frequency"
la val cat_dust_freq cat_dust_freq

gen cat_noise_freq= 0
replace cat_noise_freq=1 if (noise==1 & noise_freq>2 & noise_freq<.) | (noise==1 & noise_freq==.) 
replace cat_noise_freq=2 if noise==1 & noise_freq<3 & noise_freq<.
la var cat_noise_freq "Noise categorical for frequency"

la def cat_noise_freq ///
	0 "No noise" ///
	1 "Noise with low frequency" ///
	2 "Noise with high frequency"
la val cat_noise_freq cat_noise_freq

gen cat_odour_freq= 0
replace cat_odour_freq=1 if (odour==1 & odour_freq>2 & odour_freq<.) | (odour==1 & odour_freq==.) 
replace cat_odour_freq=2 if odour==1 & odour_freq<3 & odour_freq<.
la var cat_odour_freq "Odour categorical for frequency"

la def cat_odour_freq ///
	0 "No odour" ///
	1 "Odour with low frequency" ///
	2 "Odour with high frequency"
la val cat_odour_freq cat_odour_freq


// For the crosstabs - categorical for the high frequency only across the 3 nuisances
gen noise_freq_dum=0
replace noise_freq_dum=1 if noise_highfreq==1
la var noise_freq_dum "Dummy noise high frequency"

la def noise_freq_dum ///
	0 "No freq noise" ///
	1 "Noise with high freq"
la val noise_freq_dum noise_freq_dum

gen dust_freq_dum=0
replace dust_freq_dum=1 if dust_highfreq==1
la var dust_freq_dum "Dummy dust high frequency"

la def dust_freq_dum ///
	0 "No freq dust" ///
	1 "dust with high freq"
la val dust_freq_dum dust_freq_dum

gen odour_freq_dum=0
replace odour_freq_dum=1 if odour_highfreq==1
la var odour_freq_dum "Dummy odour high frequency"

la def odour_freq_dum ///
	0 "No freq odour" ///
	1 "odour with high freq"
la val odour_freq_dum odour_freq_dum

gen sum_nuisance_freq=dust_freq_dum+noise_freq_dum+odour_freq_dum
la var sum_nuisance_freq "Number of high frequency nuisances experienced"
la def sum_nuisance_freq ///
	0 "No frequent nuisance experienced" ///
	1 "One high frequency nuisance experienced" ///
	2 "Two high frequency nuisances experienced" ///
	3 "Three high frequency nuisances experienced" 
la val sum_nuisance_freq sum_nuisance_freq


// categorical for the high intensity only across the 3 nuisances
gen noise_intensity_dum=0
replace noise_intensity_dum=1 if noise_highintensity==1
la var noise_intensity_dum "Dummy noise high intensity"

la def noise_intensity_dum ///
	0 "No intensity noise" ///
	1 "Noise with high intensity"
la val noise_intensity_dum noise_intensity_dum

gen dust_intensity_dum=0
replace dust_intensity_dum=1 if dust_highintensity==1
la var dust_intensity_dum "Dummy dust high intensity"

la def dust_intensity_dum ///
	0 "No intensity dust" ///
	1 "dust with high intensity"
la val dust_intensity_dum dust_intensity_dum

gen odour_intensity_dum=0
replace odour_intensity_dum=1 if odour_highintensity==1
la var odour_intensity_dum "Dummy odour high intensity"

la def odour_intensity_dum ///
	0 "No intensity odour" ///
	1 "odour with high intensity"
la val odour_intensity_dum odour_intensity_dum

gen sum_nuisance_intensity=dust_intensity_dum+noise_intensity_dum+odour_intensity_dum
la var sum_nuisance_intensity "Number of high intensity nuisances experienced"
la def sum_nuisance_intensity ///
	0 "No intensity nuisance experienced" ///
	1 "One high intensity nuisance experienced" ///
	2 "Two high intensity nuisances experienced" ///
	3 "Three high intensity nuisances experienced" 
la val sum_nuisance_intensity sum_nuisance_intensity

*--------------------------------------------------
* Dropping
*--------------------------------------------------

// Note that the panel provider that we're using (Milieu) has a survey platform that automatically excludes speedsters, hence we don't need to do it here. 

* Drop respondents that are under 15 years old
drop if age < 15
// 0 respondents dropped


* Drop unneeded variables
drop q1 q8r11 q13r6 q21r10 inc_cat1 inc_cat2

*--------------------------------------------------
* Save cleaned data
*--------------------------------------------------

compress

save "$OUTPUT/Data/Singapore Nuisance study survey data (clean).dta", replace
