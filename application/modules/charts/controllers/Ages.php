<?php
defined('BASEPATH') or exit('No direct script access allowed!');

/**
* 
*/
class Ages extends MY_Controller
{
	
	function __construct()
	{
		parent:: __construct();
		$this->load->model('age_model');
	}

	function testing_trends($year=null,$age=null)
	{
		$data['trends'] = $this->age_model->age_testing_trends($year,$age);
		$data['div_name'] = "age_testing_trends";
		$data['export'] = TRUE;
		$link = $year . '/' . $age;

		$data['link'] = base_url('charts/ages/download_testing_trends/' . $link);
		
		$this->load->view('trends_outcomes_view', $data);
	}

	function download_testing_trends($year=NULL,$age=NULL)
	{
		$this->age_model->download_testing_trends($year,$age);
	}

	function age_breakdowns($year=null,$month=null,$toYear=null,$toMonth=null,$age=null,$county=null,$subCounty=null,$partner=null)
	{
		$data['outcomes'] = $this->age_model->get_agebreakdown($year,$month,$toYear,$toMonth,$age,$county,$subCounty,$partner);

		$this->load->view('breakdown_listing', $data);
	}

	function counties_age_group_breakdown($year=null,$month=null,$toYear=null,$toMonth=null,$age=null)
	{
		$data['trends'] = $this->age_model->get_counties_agebreakdown($year,$month,$toYear,$toMonth,$age);
		$data['div_name'] = "counties_agebreakdown";

		$this->load->view('trends_outcomes_view', $data);	
	}

	function get_age_summary($year=null,$month=null,$toYear=null,$toMonth=null,$county=null,$subCounty=null)
	{
		$data['agesSummary'] = $this->age_model->ages_summary($year,$month,$toYear,$toMonth,$county,$subCounty);

		$this->load->view('agegroupsummary_view', $data);
	}

	function get_age_positivity($year=null,$month=null,$toYear=null,$toMonth=null,$county=null,$subCounty=null)
	{
		$data['agesPositivity'] = $this->age_model->ages_positivity($year,$month,$toYear,$toMonth,$county,$subCounty);

		$this->load->view('agegroupspositivity_view', $data);
	}

	function get_age_outcomes($year=null,$month=null,$toYear=null,$toMonth=null,$county=null,$subCounty=null)
	{
		$data['agesOutcomes'] = $this->age_model->ages_outcomes($year,$month,$toYear,$toMonth,$county,$subCounty);

		$this->load->view('agegroupsoutcomes_view', $data);
	}

	function test($year=null,$month=null,$toYear=null,$toMonth=null,$county=null,$subCounty=null)
	{
		$test = $this->age_model->get_breakdown_data($year,$month,$toYear,$toMonth,$county,$subCounty);
		print_r($test);
	}
}

?>