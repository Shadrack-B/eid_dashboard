<?php
defined('BASEPATH') or exit('No direct script access allowed');
/**
* 
*/
class Template_model extends MY_Model
{
	
	function __construct()
	{
		parent:: __construct();
	}

	function get_counties_dropdown()
	{
		$dropdown = '';
		$this->db->from('countys');
		$this->db->order_by("name", "asc");
		$county_data = $this->db->get()->result_array();
		
		foreach ($county_data as $key => $value) {
			$dropdown .= '<option value="'.$value['ID'].'">'.$value['name'].' County</option>';
		}
		
		return $dropdown;
	}

	function get_sub_county_dropdown()
	{
		$dropdown = '';
		$this->db->from('districts');
		$this->db->order_by("name", "asc");
		$county_data = $this->db->get()->result_array();
		
		foreach ($county_data as $key => $value) {
			$dropdown .= '<option value="'.$value['id'].'">'.$value['name'].' Sub-County</option>';
		}
		
		return $dropdown;
	}

	function get_partners_dropdown()
	{
		$dropdown = '';
		$partner_data = $this->db->query('SELECT `ID`, `name` FROM `partners` ORDER BY `name` ASC')->result_array();

		foreach ($partner_data as $key => $value) {
			$dropdown .= '<option value="'.$value['ID'].'">'.$value['name'].'</option>';
		}
		
		return $dropdown;
	}

	function get_lab_dropdown()
	{
		$dropdown = '';
		$this->db->order_by("name","asc");
		$lab_data = $this->db->get('labs')->result_array();

		foreach ($lab_data as $key => $value) {
			$dropdown .= '<option value="'.$value['ID'].'">'.$value['labname'].'</option>';
		}
		$dropdown .= '<option value="11">POC Sites</option>';
		
		return $dropdown;
	}

	function get_regimen_dropdown()
	{
		$dropdown = '';
		$this->db->where('ptype',2);
		$this->db->order_by("name","asc");
		$lab_data = $this->db->get('prophylaxis')->result_array();

		foreach ($lab_data as $key => $value) {
			$dropdown .= '<option value="'.$value['ID'].'">'.$value['name'].'</option>';
		}
		
		return $dropdown;
	}

	function get_ages_dropdown()
	{
		$dropdown = '';
		$this->db->order_by("ID","asc");
		$lab_data = $this->db->get('age_bands')->result_array();

		foreach ($lab_data as $key => $value) {
			$dropdown .= '<option value="'.$value['ID'].'">'.$value['name'].'</option>';
		}
		
		return $dropdown;
	}

	function get_site_dropdown()
	{
		$dropdown = '';
		$site_data = $this->db->query('SELECT DISTINCT `view_facilitys`.`ID`, `view_facilitys`.`name` FROM `site_summary` JOIN `view_facilitys` ON `site_summary`.`facility` = `view_facilitys`.`ID`')->result_array();

		foreach ($site_data as $key => $value) {
			$dropdown .= '<option value="'.$value['ID'].'">'.$value['name'].'</option>';
		}

		return $dropdown;
	}

	function get_county_name($county_id)
	{
		$this->db->where('ID', $county_id);
		$data = $this->db->get('countys')->result_array();
		$name = $data[0]["name"];

		return $name;
	}

	function get_sub_county_name($sub_county_id)
	{
		$this->db->where('ID', $sub_county_id);
		$data = $this->db->get('districts')->result_array();
		$name = $data[0]["name"];

		return $name;
	}

	function get_partner_name($partner_id)
	{
		$this->db->where('ID', $partner_id);
		$data = $this->db->get('partners')->result_array();
		$name = $data[0]["name"];

		return $name;
	}

	function get_site_name($site_id)
	{
		$this->db->where('ID', $site_id);
		$data = $this->db->get('view_facilitys')->result_array();
		$name = $data[0]["name"];

		return $name;
	}

	function get_regimen_name($regimen_id)
	{
		$this->db->where('ID', $regimen_id);
		$data = $this->db->get('prophylaxis')->result_array();
		$name = $data[0]["name"];

		return $name;
	}

	function get_age_name($age_id)
	{
		$this->db->where('ID', $age_id);
		$data = $this->db->get('age_bands')->result_array();
		$name = $data[0]["name"];

		return $name;
	}
}
?>