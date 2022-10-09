/*****************************************************************************************************
Program: 			WE_EMPW.do
Purpose: 			Code to compute decision making and justification of violence among in men and women
Data inputs: 		IR or MR dataset
Data outputs:		coded variables
Author:				Shireen Assaf
Date last modified: Oct 17, 2019 by Shireen Assaf 
Note:				The indicators below can be computed for men and women. 
					The indicators we_decide_all and we_decide_none have different variable labels for men compared to women. 
*****************************************************************************************************/

/*----------------------------------------------------------------------------
Variables created in this file:
we_decide_health			"Decides on own health care"
we_decide_hhpurch			"Decides on large household purchases"
we_decide_visits			"Decides on visits to family or relatives"
we_decide_health_self		"Decides on own health care either alone or jointly with partner"
we_decide_hhpurch_self		"Decides on large household purchases either alone or jointly with partner"
we_decide_visits_self		"Decides on visits to family or relatives either alone or jointly with partner"
we_decide_all				"Decides on all three: health, purchases, and visits  either alone or jointly with partner" (for women)
							"Decides on both health and purchases either alone or jointly with partner" (for men)
we_decide_none				"Does not decide on any of the three decisions either alone or jointly with partner" (for women)
							"Does not decide on health or purchases either alone or jointly with partner" (for men)
	
we_dvjustify_burn			"Agree that husband is justified in hitting or beating his wife if she burns food"
we_dvjustify_argue			"Agree that husband is justified in hitting or beating his wife if she argues with him"
we_dvjustify_goout			"Agree that husband is justified in hitting or beating his wife if she goes out without telling him"
we_dvjustify_neglect		"Agree that husband is justified in hitting or beating his wife if she neglects the children"
we_dvjustify_refusesex		"Agree that husband is justified in hitting or beating his wife if she refuses to have sexual intercourse with him"
we_dvjustify_onereas		"Agree that husband is justified in hitting or beating his wife for at least one of the reasons"
	
we_justify_refusesex		"Believe a woman is justified to refuse sex with her husband if she knows he's having sex with other women"
we_justify_cond				"Believe a women is justified in asking that her husband to use a condom if she knows that he has an STI"
we_havesay_refusesex		"Can say no to their husband if they do not want to have sexual intercourse"
we_havesay_condom			"Can ask their husband to use a condom"
	
we_num_decide				"Number of decisions made either alone or jointly with husband among women currently in a union"
we_num_justifydv			"Number of reasons for which wife beating is justified among women currently in a union"
----------------------------------------------------------------------------*/

** Settings for stata ** 
clear all
set more off
set mem 100m
set matsize 11000
set maxvar 32767

global dir "C:\Users\Nicholus Tint Zaw\Documents\GitHub\r_review"

use "$dir/ir_women.dta", replace 

* indicators from IR file
//if file=="IR" {

cap label define yesno 0"No" 1"Yes"

*** Decision making ***

//Decides on own health
gen we_decide_health= v743a if v502==1
label values we_decide_health V743A
label var we_decide_health "Decides on own health care"

//Decides on household purchases
gen we_decide_hhpurch= v743b if v502==1
label values we_decide_hhpurch V743B
label var we_decide_hhpurch "Decides on large household purchases"

//Decides on visits
gen we_decide_visits= v743d if v502==1
label values we_decide_visits V743D
label var we_decide_visits "Decides on visits to family or relatives"

//Decides on own health either alone or jointly
gen we_decide_health_self= inlist(v743a,1,2) if v502==1
label values we_decide_health_self yesno
label var we_decide_health_self "Decides on own health care either alone or jointly with partner"

//Decides on household purchases either alone or jointly
gen we_decide_hhpurch_self= inlist(v743b,1,2) if v502==1
label values we_decide_hhpurch_self yesno
label var we_decide_hhpurch_self "Decides on large household purchases either alone or jointly with partner"

//Decides on visits either alone or jointly
gen we_decide_visits_self= inlist(v743d,1,2) if v502==1
label values we_decide_visits_self yesno
label var we_decide_visits_self "Decides on visits to family or relatives either alone or jointly with partner"

//Decides on all three: health, purchases, and visits  either alone or jointly with partner
gen we_decide_all= inlist(v743a,1,2) & inlist(v743b,1,2) & inlist(v743d,1,2) if v502==1
label values we_decide_all yesno
label var we_decide_all "Decides on all three: health, purchases, and visits  either alone or jointly with partner"

//Does not decide on any of the three decisions either alone or jointly with partner
gen we_decide_none= 0 if v502==1
replace we_decide_none=1 if (v743a!=1 & v743a!=2) & (v743b!=1 & v743b!=2) & (v743d!=1 & v743d!=2)& v502==1
label values we_decide_none yesno
label var we_decide_none "Does not decide on any of the three decisions either alone or jointly with partner"



// generate table 
drop if v012<15 | v012>49

gen wt=v005/1000000

tab1 we_decide_health /*we_decide_hhpurch we_decide_visits*/ [iw=wt]


