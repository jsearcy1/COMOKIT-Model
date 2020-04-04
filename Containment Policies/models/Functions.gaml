/***
* Name: Functions
* Author: damien
* Description: 
* Tags: Tag1, Tag2, TagN
***/


model Functions
import "Constants.gaml"
import "Parameters.gaml"
import "Global.gaml"

/* Insert your model definition here */
 
global
{
	//Function to get a value from a random distribution (among Normal, Lognormal, Weibull, Gamma and Uniform)
	float get_rnd_from_distribution(string type, float param_1, float param_2)
	{
		return type=epidemiological_lognormal?lognormal_rnd(param_1,param_2):(type=epidemiological_weibull?weibull_rnd(param_1,param_2):(type=epidemiological_gamma?gamma_rnd(param_1,param_2):(type=epidemiological_normal?gauss_rnd(param_1,param_2):rnd(param_1,param_2))));
	}
	
	//Successful contact rate of an infectious individual, expect the age in the case we want to represent different contact rates for different age categories - MUST BE FIXED (i.e not relying on a distribution)
	float get_contact_rate_human(int age)
	{
		return float(map_epidemiological_parameters[age][epidemiological_successful_contact_rate_human][1])/nb_step_for_one_day;
	}
	
	//Successful contact rate of the building - MUST BE FIXED (i.e not relying on a distribution)
	float get_contact_rate_building
	{
		return successful_contact_rate_building/nb_step_for_one_day;
	}
	
	//Reduction of the successful contact rate for asymptomatic infectious individual of a given age - MUST BE FIXED (i.e not relying on a distribution)
	float get_reduction_contact_rate_asymptomatic(int age)
	{
		return float(map_epidemiological_parameters[age][epidemiological_reduction_asymptomatic][1]);
	}
	
	//Basic viral release in the environment of an infectious individual of a given age
	float get_basic_viral_release(int age)
	{
		if(map_epidemiological_parameters[age][epidemiological_basic_viral_release][0]=epidemiological_fixed)
		{
			return float(map_epidemiological_parameters[age][epidemiological_basic_viral_release][1])/nb_step_for_one_day;
		}
		else
		{
			return get_rnd_from_distribution(map_epidemiological_parameters[age][epidemiological_basic_viral_release][0],float(map_epidemiological_parameters[age][epidemiological_basic_viral_release][1]),float(map_epidemiological_parameters[age][epidemiological_basic_viral_release][2]))/nb_step_for_one_day;
		}
	}
	
	//Time between exposure and symptom onset of an individual of a given age
	float get_incubation_time(int age)
	{
		if(map_epidemiological_parameters[age][epidemiological_incubation_period][0]=epidemiological_fixed)
		{
			return float(map_epidemiological_parameters[age][epidemiological_incubation_period][1])*nb_step_for_one_day;
		}
		else
		{
			return get_rnd_from_distribution(map_epidemiological_parameters[age][epidemiological_incubation_period][0],float(map_epidemiological_parameters[age][epidemiological_incubation_period][1]),float(map_epidemiological_parameters[age][epidemiological_incubation_period][2]))*nb_step_for_one_day;
		}
	}
	
	//Time between onset of a primary case of a given age and onset of secondary case 
	float get_serial_interval(int age)
	{
		if(map_epidemiological_parameters[age][epidemiological_serial_interval][0]=epidemiological_fixed)
		{
			return float(map_epidemiological_parameters[age][epidemiological_serial_interval][1])*nb_step_for_one_day;
		}
		else
		{
			return get_rnd_from_distribution(map_epidemiological_parameters[age][epidemiological_serial_interval][0],float(map_epidemiological_parameters[age][epidemiological_serial_interval][1]),float(map_epidemiological_parameters[age][epidemiological_serial_interval][2]))*nb_step_for_one_day;
		}
	}
	
	//Time between onset and recovery for an infectious individual of a given age
	float get_infectious_time(int age)
	{
		if(map_epidemiological_parameters[age][epidemiological_onset_to_recovery][0]=epidemiological_fixed)
		{
			return float(map_epidemiological_parameters[age][epidemiological_onset_to_recovery][1])*nb_step_for_one_day;
		}
		else
		{
			return get_rnd_from_distribution(map_epidemiological_parameters[age][epidemiological_onset_to_recovery][0],float(map_epidemiological_parameters[age][epidemiological_onset_to_recovery][1]),float(map_epidemiological_parameters[age][epidemiological_onset_to_recovery][2]))*nb_step_for_one_day;
		}
	}
	
	//Reduction of the successful contact rate of an infectious individual of a given age
	float get_reduction_contact_rate_wearing_mask(int age)
	{
		return float(map_epidemiological_parameters[age][epidemiological_reduction_wearing_mask][1]);
	}
	
	//Give a boolean to say if an individual of a given age should be asymptomatic - MUST BE FIXED (i.e. not following a distribution)
	bool is_asymptomatic(int age)
	{
		return flip(float(map_epidemiological_parameters[age][epidemiological_proportion_asymptomatic][1]));
	}
	
	//Give a boolean to say if an infected individual of a given age is positive - MUST BE FIXED (i.e. not following a distribution)
	bool is_true_positive(int age)
	{
		return flip(float(map_epidemiological_parameters[age][epidemiological_probability_true_positive][1]));
	}
	
	//Give a boolean to say if a non-infected individual of a given age is negative - MUST BE FIXED (i.e. not following a distribution)
	bool is_true_negative(int age)
	{
		return flip(float(map_epidemiological_parameters[age][epidemiological_probability_true_negative][1]));
	}
	
	//Give a boolean to say if an individual of a given age should be hospitalized - MUST BE FIXED (i.e. not following a distribution)
	bool is_hospitalized(int age)
	{
		return flip(float(map_epidemiological_parameters[age][epidemiological_proportion_hospitalization][1]));
	}
	
	//Give a boolean to say if an individual of a given age should be in intensive care unit - MUST BE FIXED (i.e. not following a distribution)
	bool is_ICU(int age)
	{
		return flip(float(map_epidemiological_parameters[age][epidemiological_proportion_icu][1]));
	}
	
	//Give a boolean to say if an individual of a given age would die - MUST BE FIXED (i.e. not following a distribution)
	bool is_fatal(int age)
	{
		return flip(float(map_epidemiological_parameters[age][epidemiological_proportion_death_symptomatic][1]));
	}
	
	//Give a boolean to say if an individual of a given age should be wearing a mask - MUST BE FIXED (i.e. not following a distribution)
	float get_proba_wearing_mask(int age)
	{
		return (float(map_epidemiological_parameters[age][epidemiological_proportion_wearing_mask][1]));
	}
	
	
}