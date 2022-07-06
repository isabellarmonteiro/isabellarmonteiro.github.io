*************************************************************
* Master's Thesis - Data Analysis for the Women's Database *
*************************************************************

* Isabella Rego Monteiro, May 2022

*File tasks: analyzes data and saves the regressions' output into Excel, produeces two graphs on the evolution of the share of firstborn daughters.

* Written in Stata 17 on a Windows


 
 
*-------------------------------------------------------------------------------
* Regression estimates: effect of fertility on women's bargaining power (Twin IV)
*-------------------------------------------------------------------------------

/////// Regression 1: Minimal Controls /////// 

*** First-Stage


eststo: regr num_children twin_first_pregnancy age age_first_pregnancy i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone [aweight = weight], vce(cluster ea) // Regression to be stored

esttab using 1st_stage_twin_iv_less_control.csv, se r2 keep ( twin_first_pregnancy age age_first_pregnancy ) star(* 0.10 ** 0.05 *** 0.01) // Savinvg results into Excel file



***Second-Stage Regressions

eststo clear //Clearing previous results stored

eststo: ivregress 2sls monthly_income age age_first_pregnancy i.year_survey polygamous_marriage previous_health_issues i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls any_work age age_first_pregnancy i.year_survey polygamous_marriage previous_health_issues i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls income_decision age age_first_pregnancy i.year_survey polygamous_marriage previous_health_issues i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls owner_manager_ age age_first_pregnancy i.year_survey polygamous_marriage previous_health_issues i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls consulted_doctor_if_sick age age_first_pregnancy i.year_survey polygamous_marriage previous_health_issues i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls check_up_not_sick age age_first_pregnancy i.year_survey polygamous_marriage previous_health_issues i.zone i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls any_unpaid_other age age_first_pregnancy i.year_survey polygamous_marriage previous_health_issues i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea) // Regression to be stored


eststo: ivregress 2sls unpaid_children_care age age_first_pregnancy i.year_survey polygamous_marriage previous_health_issues i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls hours_unpaid_other age age_first_pregnancy i.year_survey polygamous_marriage previous_health_issues i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea) // Regression to be stored


eststo: ivregress 2sls hours_children_care age age_first_pregnancy i.year_survey polygamous_marriage previous_health_issues i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea) // Regression to be stored


eststo: ivregress 2sls mobile_phone_own_if_access age age_first_pregnancy i.year_survey polygamous_marriage previous_health_issues i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea) // Regression to be stored


eststo: ivregress 2sls total_clothing_expenditures age age_first_pregnancy i.year_survey polygamous_marriage previous_health_issues i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls women_clothing_expenditures age age_first_pregnancy i.year_survey polygamous_marriage previous_health_issues i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls percentage_women_children age age_first_pregnancy i.year_survey polygamous_marriage previous_health_issues i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea) // Regression to be stored


esttab using 2nd_stage_twin_iv_less_control.csv, se r2 keep ( num_children ) star(* 0.10 ** 0.05 *** 0.01) // Transferring the regression outputs to Excel and keeping only the coefficients and standard errors for the variable number of children, establishes the significance values that will correspond to each symbol


eststo clear // Eliminating stored results from previous regressions




***Reduced Form Regressions
foreach var in monthly_income any_work income_decision sole_money_decision owner_manager_ consulted_doctor_if_sick check_up_not_sick any_unpaid_other unpaid_children_care hours_unpaid_other hours_children_care time_fetching mobile_phone_own_if_access total_clothing_expenditures women_clothing_expenditures percentage_women_children  {
eststo: regr `var' twin_first_pregnancy age age_first_pregnancy i.year_survey polygamous_marriage previous_health_issues i.zone [aweight = weight], vce(cluster ea) 
} // Regressions to be stored



esttab using RF_stage_twin_iv_less_control.csv, se r2 keep ( twin_first_pregnancy ) star(* 0.10 ** 0.05 *** 0.01) // Transferring the regression outputs to Excel

eststo clear // Eliminating stored results from previous regressions





/////// Regression 2: Additional controls ///////

** First-Stage

eststo: regr num_children twin_first_pregnancy age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone [aweight = weight], vce(cluster ea)// Regressions to be stored


esttab using 1st_stage_twin_iv.csv, se r2 keep ( twin_first_pregnancy age age_first_pregnancy ) star(* 0.10 ** 0.05 *** 0.01) // Transferring the regression outputs to Excel




**Second-Stage Regressions

eststo clear // Eliminating stored results from previous regressions
 

eststo: ivregress 2sls monthly_income age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea) // Regression to be stored


eststo: ivregress 2sls any_work age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls income_decision age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls owner_manager_ age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls consulted_doctor_if_sick age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls check_up_not_sick age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls any_unpaid_other age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea) // Regression to be stored


eststo: ivregress 2sls unpaid_children_care age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls hours_unpaid_other age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea) // Regression to be stored


eststo: ivregress 2sls hours_children_care age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea) // Regression to be stored


eststo: ivregress 2sls mobile_phone_own_if_access age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea) // Regression to be stored


eststo: ivregress 2sls total_clothing_expenditures age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls women_clothing_expenditures age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls percentage_women_children age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = twin_first_pregnancy ) [aweight = weight], vce(cluster ea) // Regression to be stored


esttab using 2nd_stage_twin_iv.csv, se r2 keep ( num_children ) star(* 0.10 ** 0.05 *** 0.01) // Transferring the regression outputs to Excel

eststo clear // Eliminating stored results from previous regressions




** Reduced Form 

foreach var in monthly_income any_work income_decision sole_money_decision owner_manager_ consulted_doctor_if_sick check_up_not_sick any_unpaid_other unpaid_children_care hours_unpaid_other hours_children_care time_fetching mobile_phone_own_if_access total_clothing_expenditures women_clothing_expenditures percentage_women_children  {
eststo: regr `var' twin_first_pregnancy age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone [aweight = weight], vce(cluster ea)
} // Regression to be stored


esttab using RF_stage_twin_iv.csv, se r2 keep ( twin_first_pregnancy ) star(* 0.10 ** 0.05 *** 0.01)

eststo clear // Eliminating stored results from previous regressions








/////// Regression 3: Robustness Check - same-sex twins ///////
** First-Stage

eststo: regr num_children same_sex_twins2 age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone [aweight = weight], vce(cluster ea) //Regression to be stored

// Saving results into Excel file
esttab using 1st_stage_twin_iv_monozygotic.csv, se r2 keep ( same_sex_twins2 age age_first_pregnancy ) star(* 0.10 ** 0.05 *** 0.01)


**Second-Stage Regressions
eststo clear // Clearing results from previous regressions

eststo: ivregress 2sls monthly_income age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = same_sex_twins2) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls any_work age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = same_sex_twins2) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls income_decision age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = same_sex_twins2) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls owner_manager_ age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = same_sex_twins2) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls consulted_doctor_if_sick age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = same_sex_twins2) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls check_up_not_sick age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = same_sex_twins2) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls any_unpaid_other age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = same_sex_twins2) [aweight = weight], vce(cluster ea) // Regression to be stored


eststo: ivregress 2sls unpaid_children_care age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = same_sex_twins2) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls hours_unpaid_other age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = same_sex_twins2) [aweight = weight], vce(cluster ea) // Regression to be stored


eststo: ivregress 2sls hours_children_care age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = same_sex_twins2) [aweight = weight], vce(cluster ea) // Regression to be stored


eststo: ivregress 2sls mobile_phone_own_if_access age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = same_sex_twins2) [aweight = weight], vce(cluster ea) // Regression to be stored


eststo: ivregress 2sls total_clothing_expenditures age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = same_sex_twins2) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls women_clothing_expenditures age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = same_sex_twins2) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls percentage_women_children age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone (num_children = same_sex_twins2) [aweight = weight], vce(cluster ea) // Regression to be stored


esttab using 2nd_stage_twin_iv_monozygotic.csv, se r2 keep ( num_children ) star(* 0.10 ** 0.05 *** 0.01) // Transferring the regression outputs to Excel


eststo clear // Eliminating stored results from previous regressions


** Reduced Form 
//Regressions:
foreach var in monthly_income any_work income_decision sole_money_decision owner_manager_ consulted_doctor_if_sick check_up_not_sick any_unpaid_other unpaid_children_care hours_unpaid_other hours_children_care time_fetching mobile_phone_own_if_access total_clothing_expenditures women_clothing_expenditures percentage_women_children  {
eststo: regr `var' same_sex_twins2 age age_first_pregnancy main_activity_non_ag own_house read_write years_educ i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone [aweight = weight], vce(cluster ea)
}


esttab using RF_stage_twin_iv_monozygotic.csv, se r2 keep ( same_sex_twins2 ) star(* 0.10 ** 0.05 *** 0.01) 
// Transferring the regression outputs to Excel


eststo clear // Eliminating stored results from previous regressions



*----------------------------------------------------------
* Exogeneity Tests with respect to controls: Twin IV
*----------------------------------------------------------
*** Any twin

eststo: regr twin_first_pregnancy age age_first_pregnancy i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone [aweight = weight], vce(cluster ea) // Regression to be stored


*** Same gender/"monozygotic" twin

eststo: regr same_sex_twins2 age age_first_pregnancy i.year_survey polygamous_marriage previous_health_issues dif_educ_husband urban i.religion2 i.zone [aweight = weight], vce(cluster ea) // Regression to be stored


esttab using twin_exogeneity_women.csv, se r2 keep ( age age_first_pregnancy polygamous_marriage previous_health_issues dif_educ_husband urban 1.religion2 ) star(* 0.10 ** 0.05 *** 0.01) // Transferring the regression outputs to Excel

eststo clear // Eliminating stored results from previous regressions


*------------------------------------------------
* T-test: Twin IV
*------------------------------------------------
*** All twins
//Regressions:
foreach var in age age_first_pregnancy read_write years_educ polygamous_marriage previous_health_issues dif_educ_husband urban { 
eststo: regr `var' twin_first_pregnancy  [aweight = weight]
} // Regression to be stored

esttab using ttest_iv_all_twins.csv, se r2 keep ( twin_first_pregnancy  _cons  ) star(* 0.10 ** 0.05 *** 0.01) // Transferring the regression outputs to Excel


***Same gender twins

eststo clear // Eliminating stored results from previous regressions

//Regressions:
foreach var in age age_first_pregnancy read_write years_educ polygamous_marriage previous_health_issues dif_educ_husband urban { 
eststo: regr `var' same_sex_twins2  [aweight = weight]
} // Regression to be stored

esttab using ttest_iv_same_gender_twins.csv, se r2 keep ( same_sex_twins2  _cons  ) star(* 0.10 ** 0.05 *** 0.01) // Transferring the regression outputs to Excel




*-------------------------------------------------------------------------------
*Regression estimates: effect of gender on women's bargaining power (Gender IV)
*-------------------------------------------------------------------------------


/////// Regression 4: Entire Sample of Women ///////
 


preserve // Preserving current dataset

keep if year_survey==2010 //Keeping only the 2010's survey responses


** First-Stage

eststo xi:regr any_sons male age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy [aweight = weight], vce(cluster ea) //Regression to be stored

esttab using 1st_stage_gender_iv_complete.csv, se r2 keep ( male age age_first_pregnancy ) star(* 0.10 ** 0.05 *** 0.01) // Saving results into Excel file



** Second-Stage Regressions
eststo clear // Eliminating stored results from previous regressions

eststo: ivregress 2sls monthly_income age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls any_work age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls income_decision age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls owner_manager_ age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls consulted_doctor_if_sick age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls check_up_not_sick age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls any_unpaid_other age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored


eststo: ivregress 2sls unpaid_children_care age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls hours_unpaid_other age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored


eststo: ivregress 2sls hours_children_care age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored


eststo: ivregress 2sls mobile_phone_own_if_access age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored


eststo: ivregress 2sls total_clothing_expenditures age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls women_clothing_expenditures age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls percentage_women_children age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored

esttab using 2nd_stage_gender_iv_complete.csv, se r2 keep (any_sons ) star(* 0.10 ** 0.05 *** 0.01) // Transferring the regression outputs to Excel

eststo clear // Eliminating stored results from previous regressions





** Reduced Form 
foreach var in monthly_income any_work income_decision sole_money_decision owner_manager_ consulted_doctor_if_sick check_up_not_sick any_unpaid_other unpaid_children_care hours_unpaid_other hours_children_care time_fetching mobile_phone_own_if_access total_clothing_expenditures women_clothing_expenditures percentage_women_children  {
eststo: regr `var' male age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy [aweight = weight], vce(cluster ea)
} //Regressions to be stored

esttab using RF_stage_gender_iv_complete.csv, se r2 keep ( male ) star(* 0.10 ** 0.05 *** 0.01) //   Transferring the regression outputs to Excel

eststo clear // Eliminating stored results from previous regressions




/////// Regression 5: Sample of Younger Women (42 and younger) ///////

drop if age>42 //Keeping only women within the age range

** First-Stage

eststo xi:regr any_sons male age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy [aweight = weight], vce(cluster ea) //Regression to be stored

esttab using 1st_stage_gender_iv_42_under.csv, se r2 keep ( male age age_first_pregnancy ) star(* 0.10 ** 0.05 *** 0.01) // Saving results into Excel file



** Second-Stage Regressions
eststo clear // Eliminating stored results from previous regressions

eststo: ivregress 2sls monthly_income age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls any_work age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls income_decision age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls owner_manager_ age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls consulted_doctor_if_sick age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls check_up_not_sick age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls any_unpaid_other age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored


eststo: ivregress 2sls unpaid_children_care age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls hours_unpaid_other age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored


eststo: ivregress 2sls hours_children_care age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored


eststo: ivregress 2sls mobile_phone_own_if_access age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored


eststo: ivregress 2sls total_clothing_expenditures age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls women_clothing_expenditures age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls percentage_women_children age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored


esttab using 2nd_stage_gender_iv_42_under.csv, se r2 keep ( any_sons ) star(* 0.10 ** 0.05 *** 0.01) // Transferring the regression outputs to Excel

eststo clear // Eliminating stored results from previous regressions





** Reduced Form 
foreach var in monthly_income any_work income_decision sole_money_decision owner_manager_ consulted_doctor_if_sick check_up_not_sick any_unpaid_other unpaid_children_care hours_unpaid_other hours_children_care time_fetching mobile_phone_own_if_access total_clothing_expenditures women_clothing_expenditures percentage_women_children  {
eststo: regr `var' male age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy [aweight = weight], vce(cluster ea)
} //Regressions to be stored

esttab using RF_stage_gender_iv_42_under.csv, se r2 keep ( male ) star(* 0.10 ** 0.05 *** 0.01) // Transferring the regression outputs to Excel

eststo clear // Eliminating stored results from previous regressions






/////// Regression 6: Sample of Young Women (27 and younger) ///////
eststo clear // Eliminating stored results from previous regressions

drop if age>27 //Keeping only women within the age range


** First-Stage

eststo xi:regr any_sons male age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy [aweight = weight], vce(cluster ea) //Regression to be stored

esttab using 1st_stage_gender_iv_young_women.csv, se r2 keep ( male age age_first_pregnancy ) star(* 0.10 ** 0.05 *** 0.01) // Saving results into Excel file



** Second-Stage Regressions
eststo clear // Eliminating stored results from previous regressions

eststo: ivregress 2sls monthly_income age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls any_work age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls income_decision age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls owner_manager_ age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls consulted_doctor_if_sick age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls check_up_not_sick age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls any_unpaid_other age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored


eststo: ivregress 2sls unpaid_children_care age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls hours_unpaid_other age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls hours_children_care age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored


eststo: ivregress 2sls mobile_phone_own_if_access age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored


eststo: ivregress 2sls total_clothing_expenditures age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls women_clothing_expenditures age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored

eststo: ivregress 2sls percentage_women_children age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy (any_sons = male ) [aweight = weight], vce(cluster ea) // Regression to be stored

esttab using 2nd_stage_gender_iv_young_women.csv, se r2 keep ( any_sons ) star(* 0.10 ** 0.05 *** 0.01) // Transferring the regression outputs to Excel

eststo clear // Eliminating stored results from previous regressions





** Reduced Form 
foreach var in monthly_income any_work income_decision sole_money_decision owner_manager_ consulted_doctor_if_sick check_up_not_sick any_unpaid_other unpaid_children_care hours_unpaid_other hours_children_care time_fetching mobile_phone_own_if_access total_clothing_expenditures women_clothing_expenditures percentage_women_children  {
eststo: regr `var' male age age dif_educ_husband dif_age_husband years_educ i.zone per_capita_income main_activity_non_ag polygamous_marriage max age_first_pregnancy [aweight = weight], vce(cluster ea)
} //Regressions to be stored

esttab using RF_stage_gender_iv_young_women.csv, se r2 keep ( male ) star(* 0.10 ** 0.05 *** 0.01) // Transferring the regression outputs to Excel

eststo clear // Eliminating stored results from previous regressions

restore //Restoring the original dataset 




*----------------------------------------------------------
* Exogeneity Tests with respect to controls: Gender IV
*----------------------------------------------------------
preserve //Preserving the original dataset 

keep if year_survey==2010 //Keeping only 2010 survey responses


** All women

eststo: regr male age age_first_pregnancy i.year_survey polygamous_marriage dif_educ_husband urban i.religion2 i.zone [aweight = weight], vce(cluster ea) // Regression to be stored


** Younger women

drop if age>42 //Keeping only Young Mothers under 42

eststo: regr male age age_first_pregnancy i.year_survey polygamous_marriage dif_educ_husband urban i.religion2 i.zone [aweight = weight], vce(cluster ea) // Regression to be stored


** Youngest women
drop if age>27 //Keeping only Young Mothers under 27

eststo: regr male age age_first_pregnancy i.year_survey polygamous_marriage dif_educ_husband urban i.religion2 i.zone [aweight = weight], vce(cluster ea) // Regression to be stored


esttab using gender_iv_exogeneity.csv, se r2 keep ( age age_first_pregnancy polygamous_marriage dif_educ_husband urban 1.religion2 ) star(* 0.10 ** 0.05 *** 0.01) // Transferring the regression outputs to Excel

eststo clear // Eliminating stored results from previous regressions

restore //Restoring the original dataset 





*------------------------------------------------
* T-test: Gender IV
*------------------------------------------------

preserve //Preserving the original dataset 

keep if year_survey==2010 //Keeping only 2010 survey responses


** All women
foreach var in age age_first_pregnancy read_write years_educ polygamous_marriage  dif_educ_husband urban { 
eststo: regr `var' male  [aweight = weight]
} //Regressions to be stored

esttab using ttest_iv_gender_all.csv, se r2 keep ( male  _cons  ) star(* 0.10 ** 0.05 *** 0.01)


**Younger women
drop if age>42 // Dropping women older than 42
eststo clear // Eliminating stored results from previous regressions

foreach var in age age_first_pregnancy read_write years_educ polygamous_marriage dif_educ_husband urban { 
eststo: regr `var' male  [aweight = weight]
} //Regressions to be stored

esttab using ttest_iv_gender_young_women42.csv, se r2 keep ( male  _cons ) star(* 0.10 ** 0.05 *** 0.01) // Transferring the regression outputs to Excel


**Youngest women

drop if age>27 // Dropping women older than 27

eststo clear // Eliminating stored results from previous regressions

foreach var in age age_first_pregnancy read_write years_educ polygamous_marriage dif_educ_husband urban { 
eststo: regr `var' male  [aweight = weight]
} //Regressions to be stored

esttab using ttest_iv_gender_young_women35.csv, se r2 keep ( male  _cons ) star(* 0.10 ** 0.05 *** 0.01)

restore //Restoring the original dataset 






*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
* Graphs
*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*** Entire Sample - Missing Adult women
preserve //Preserving the dataset

gen female=0 if male==1 //Generating a "Firstborn is a daughter" variable
replace female=1 if male==0

collapse female, by (age) //Collapsing the data

drop if age<20 //dropping women that are too young

twoway qfitci female age, alwidth(none) || scatter female age, title("Share of Women with a firstborn Daughter by Women's age")  xtitle("Women's Age at the Time of the Survey'") //Plotting
 
restore //Restoring the data


*** Subsample 2010 - Missing Adult Women

preserve //Preserving the dataset
keep if year_survey==2010 // keeping only 2010 dataset
gen female=0 if male==1 //Generating a "Firstborn is a daughter" variable
replace female=1 if male==0
 
collapse female, by (age) //Collapsing the data

drop if age<20 // dropping women that are too young for analysis (due to low number of obs)
drop if age>60 // dropping women that are too old for analysis (due to low number of obs)

twoway qfitci female age, alwidth(none) || scatter female age, title("Share of Women with a firstborn Daughter by Women's age (2010 Sample)", size(medsmall))  xtitle("Women's Age at the Time of the Survey'") //Plotting
 
restore //Restoring the data






*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
*Summary Statistics
*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

** Women - entire sample
summarize age age_first_pregnancy num_children twins twin_first_pregnancy same_sex_twins same_sex_twins2 polygamous_marriage previous_health_issues monthly_income any_work income_decision owner_manager_ consulted_doctor_if_sick check_up_not_sick any_unpaid_other unpaid_children_care hours_unpaid_other hours_children_care mobile_phone_own_if_access total_clothing_expenditures  women_clothing_expenditures percentage_women_children main_activity_non_ag own_house read_write years_educ dif_educ_husband urban religion2 male any_sons [aweight = weight] //creating summary statistics



** Women - 2010 sample
*** Ages 13-65:
preserve // Preserving dataset

keep if year_survey==2010 // Dropping other years of survey
summarize age age_first_pregnancy num_children twins twin_first_pregnancy same_sex_twins same_sex_twins2 polygamous_marriage previous_health_issues monthly_income any_work income_decision owner_manager_ consulted_doctor_if_sick check_up_not_sick any_unpaid_other unpaid_children_care hours_unpaid_other hours_children_care mobile_phone_own_if_access total_clothing_expenditures  women_clothing_expenditures percentage_women_children main_activity_non_ag own_house read_write years_educ dif_educ_husband urban religion2 male any_sons [aweight = weight] //creating summary statistics


*** Ages 13-42:
drop if age>42 // dropping ages above threshold

summarize age age_first_pregnancy num_children twins twin_first_pregnancy same_sex_twins same_sex_twins2 polygamous_marriage previous_health_issues monthly_income any_work income_decision owner_manager_ consulted_doctor_if_sick check_up_not_sick any_unpaid_other unpaid_children_care hours_unpaid_other hours_children_care mobile_phone_own_if_access total_clothing_expenditures  women_clothing_expenditures percentage_women_children main_activity_non_ag own_house read_write years_educ dif_educ_husband urban religion2 male any_sons [aweight = weight] //creating summary statistics

*** Ages 13-27:
drop if age>27 // dropping ages above threshold
summarize age age_first_pregnancy num_children twins twin_first_pregnancy same_sex_twins same_sex_twins2 polygamous_marriage previous_health_issues monthly_income any_work income_decision owner_manager_ consulted_doctor_if_sick check_up_not_sick any_unpaid_other unpaid_children_care hours_unpaid_other hours_children_care mobile_phone_own_if_access total_clothing_expenditures  women_clothing_expenditures percentage_women_children main_activity_non_ag own_house read_write years_educ dif_educ_husband urban religion2 male any_sons [aweight = weight] //creating summary statistics

restore //restoring data


