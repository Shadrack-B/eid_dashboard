<?php
(defined('BASEPATH') or exit('No direct script access is allowed!'));

/**
* 
*/
class Hei extends MY_Controller
{
	
	function __construct()
	{
		parent:: __construct();
		$this->load->model('hei_model');
	}

	public function validation($year=null, $month=null, $to_year=null, $to_month=null, $type=null, $id=null)
	{
		if ($type == 0) $title = 'County';
		if ($type == 1) $title = 'Partner';
		if ($type == 2) $title = 'Sub-county';
		if ($type == 3) $title = 'Facility';
		$data['th'] = '<tr class="colhead">
							<th>#</th>
							<th>'.$title.'</th>
							<th>Actual Infants Tested Positive</th>
							<th>Actual Infants Validated at Site</th>
							<th>% Infants Validated at Site</th>
							<th>Actual Infants Confirmed Positive</th>
							<th>% Infants Confirmed Positive</th>
							<th>Enrolled</th>
							<th>Lost to follow up</th>
							<th>Adults</th>
							<th>Transfer Out</th>
							<th>Dead</th>
							<th>Others</th>
						</tr>';
		$data['outcomes'] = $this->hei_model->validation($year, $month, $to_year, $to_month, $type, $id);
		// echo "<pre>";print_r($data);die();
		$this->load->view('counties_details_view',$data);
	}
}

?>