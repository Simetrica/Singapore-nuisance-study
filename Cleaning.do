*---------------------------------------------------
* Set up
*---------------------------------------------------

clear all

* Set working directory
cd "$GIT/Singapore-nuisance-study"

* Set up globals
global CLIENT  "Jacobs - Singapore nuisance study"
global PROJECT "$SHAREPOINT/Simetrica - Projects/$CLIENT/Analysis/Main"
global INPUT   "$PROJECT/Input"
global OUTPUT  "$PROJECT/Output"

* Include Simetrica-created functions
include functions

*---------------------------------------------------
* Import main data
*---------------------------------------------------

import excel using "$INPUT/TBA.xlsx", sheet("TBA") firstrow clear

*---------------------------------------------------
* Renaming
*---------------------------------------------------

* Pre-existing demographic questions
rename TBA female
rename TBA ageg
rename TBA ethnicity
rename TBA religion
rename TBA educ
rename TBA empvar
rename TBA income
rename TBA marital
rename TBA htype
rename TBA tenure

* Additional questions
rename TBA postcode
rename TBA mrt_station
rename TBA lfsato
rename TBA goodneighbourhood
rename TBA gen_health
rename TBA longstandingillness
rename TBA physicalhealth
rename TBA mentalhealth
rename TBA nuisances
rename TBA dust_freq
rename TBA dust_intensity
rename TBA noise_freq
rename TBA noise_intensity
rename TBA odour_freq
rename TBA odour_intensity
rename TBA roads_distance
rename TBA transport_distance
rename TBA industry_distance
rename TBA nuisance_effect
rename TBA complaints
rename TBA carer
rename TBA nchild


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
la var tenure 				"Living situation"
la var postcode 			"2 digit postcode"
la var mrt_station 			"Closest MRT station"
la var lfsato				"Current life satisfaction (0-10)"
la var goodneighbourhood	"Likes present neighbourhood"
la var gen_health 			"General health"
la var longstandingillness	"Has long standing illness or impairment"
la var physicalhealth		"Physical health"
la var mentalhealth			"Mental health"
la var nuisances			"Nuisances affecting you in your home"
la var dust_freq			"Frequency of dust nuisance"
la var dust_intensity		"Intensity of dust nuisance"
la var noise_freq			"Frequency of noise nuisance"
la var noise_intensity		"Intensity of noise nuisance"
la var odour_freq			"Frequency of odour nuisance"
la var odour_intensity		"Intensity of odour nuisance"
la var roads_distance		"Distance of a busy road from home"
la var transport_distance	"Distance of a transport hub from home"
la var industry_distance	"Distance of an industrial industry from home"
la var nuisance_effect		"How nuisance affects you"
la var complaints			"Submitted a complaint regarding the nuisance experiencing"
la var carer 				 "Is a carer"
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
notes hsize: 				How many people other than yourself are living in your household?
notes htype: 				You currently live in a...
notes tenure: 				Which best describes the place you currently live in?
notes postcode:				Could you please provide the first two digits of your 6-digit postcode?
notes mrt_station:			Could you please provide the name of the MRT station nearest to your home?
notes lfsato: 				Overall, how satisfied are you with your life nowadays?
notes goodneighbourhood:	Overall, do you like living in your neighbourhood?
notes gen_health:			In general, would you say your health is...
notes longstandingillness:	Do you have any long-standing physical or mental impairment, illness or disability?
notes physicalhealth:		Have you ever been diagnosed by a doctor or other health professional with any long-term health condition?
notes mentalhealth:			Have you ever been diagnosed by a doctor or other health professional with any long-term mental health condition?
notes nuisances:			Which of the following types of nuisances affect you in your home? Please select all that apply.
notes dust_freq:			How often do you experience dust nuisance in your home environment?
notes dust_intensity:		At the times you are experiencing a dust nuisance, how would you rate the intensity of this nuisance in your home environment?
notes noise_freq:			How often do you experience  noise nuisance in your home environment?
notes noise_intensity:		At the times you are experiencing a noise nuisance, how would you rate the intensity of this nuisance in your home environment?
notes odour_freq:			How often do you experience odour nuisance in your home environment?
notes odour_intensity:		At the times you are experiencing an odour nuisance, how would you rate the intensity of this nuisance in your home environment?
notes roads_distance:		Approximately, how close do you live to a busy road or roads?
notes transport_distance:	Approximately, how close do you live to a transport hub such as an MRT/LRT station, bus interchange, ferry terminal, airport or port?
notes industry_distance:	Approximately, how close do you live to an industrial facility, such as a warehousing and logistics hub; automotive/vehicle repair shop; industrial building, machinery or storage; wafer and semiconductor fabrication plant; food and beverage manufacturing site; wet lab; recycling plant; power plant or a data centre? 
notes nuisance_effect:		In what way does the nuisance you experience affect you and other members of your household?
notes complaints:			In the last 12 months have you submitted a complaint to either a local government body or the National Environment Agency regarding a nuisance that you have experienced?
notes carer:				Do you look after a family member, partner or friend who needs help because of their illness, frailty, disability, a mental health problem or an addiction and cannot cope without your support?
notes nchild: 				How many children under the age of 16 live in your household? 

*--------------------------------------------------
* Recoding
*--------------------------------------------------

//TBA if needed

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

* Household size
la def hsize ///
	1 "None, I live by myself" ///
	2 "1" ///
	3 "2" ///
	4 "3 to 4" ///
	5 "5 to 7" ///
	6 "8 or more"
la val hsize hsize

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

* Living situation
la def tenure ///
	1  "Bought personally (1st time buyer)" ///
	2  "Bought personally (not 1st time buyer)" ///
	3  "Paying rent personally" ///
	4  "Living in parents'/relatives' house" ///
	5  "I (or my parents) am not financially responsible for the place I stay" ///
	.a  "I'm not sure"
la val tenure tenure

* General health
la def gen_health ///
	1 "Poor" ///
	2 "Fair" ///
	3 "Good" ///
	4 "Very good" ///
	5 "Excellent"
la val gen_health gen_health

* Good neighbourhood, long standing illness, physical and mental health, submitted a complaint and carer vars
global yesnovars goodneighbourhood longstandingillness physicalhealth mentalhealth complaints carer
la def yesno ///
	0  "No" ///
	1  "Yes" ///
	.a "Don't know/Rather not say"
la val yesnovars yesno

* Nuisance
la def nuisances ///
	1 "Dust/Smoke" ///
	2 "Noise" ///
	3 "Smell/Odour" ///
	4 "Other" ///
	5 "None" 
la val nuisances nuisances

* Frequency of nuisances
global freq dust_freq noise_freq odour_freq

la def freq ///
	1 "At least once a week" ///
	2 "Less than once a day but at least 3 times a week" ///
	3 "Once or twice a week" ///
	4 "Less than that but more than twice a month" ///
	5 "Once or twice a month" ///
	6 "Less than that but more than twice a year" ///
	7 "Once or twice a year" ///
	8 "Less than that or never" 
la val freq freq

* Intensity of nuisances
global intensity dust_intensity noise_intensity odour_intensity

la def intensity ///
	1 "Light to moderate but not objectionable" ///
	2 "Somewhat objectionable but not sufficient to interfere" ///
	3 "Objectionable and tends to interfere" ///
	4 "Highly objectionable and potentially harmful"
la val intensity intensity

* Distance of sources of nuisances
global distance roads_distance transport_distance industry_distance

la def distance ///
	1 "Less than 50m" ///
	2 "50-100m" ///
	3 "100-500m" ///
	4 "500m-1km" ///
	5 "1-2km" ///
	6 "More than 2km"
la val distance distance

* How nuisance affects you
la def nuisance_effect ///
	1 "Affects my sleep" ///
	2 "Affects my recreation and relaxing time at home" ///
	3 "Affects my focus when studying or working at home" ///
	4 "Affects my way of doing housework at my home" ///
	5 "Affects when/how often I can open the windows at my home" ///
	6 "Affects my mood, making me anxious or angrier than usually" ///
	7 "It makes me prone to experiencing physiological symptoms" ///
	8 "Other"
la val nuisance_effect nuisance_effect

* Number of children 
la def nchild ///
	1 "1" ///
	2 "2" ///
	3 "3" ///
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

* Tenure (replacing the 6th category "I am not sure" as missing )
replace tenure=. if tenure==6

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

* Owns house (dummy)
gen ownhouse = tenure < 3 if tenure < .
la var ownhouse "Owns house"
la val ownhouse yesno

* Good health (dummy)
gen ghealth = gen_health > 3 if gen_health < .
la var ghealth "Has very good or excellent health"
la val ghealth yesno

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


*--------------------------------------------------
* Dropping
*--------------------------------------------------

// Note that the panel provider that we're using (Milieu) has a survey platform that automatically excludes speedsters, hence we don't need to do it here. 

* Drop respondents that are under 15 years old
drop if age < 15
// 0 respondents dropped


* Drop unneeded variables
drop 

*--------------------------------------------------
* Save cleaned data
*--------------------------------------------------

compress

save "$OUTPUT/Data/Singapore Nuisance study survey data (clean).dta", replace
