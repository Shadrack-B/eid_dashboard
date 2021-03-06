<style type="text/css">
	/*.display_date {
		width: 130px;
		display: inline;
	}
	.display_range {
		width: 130px;
		display: inline;
	}*/
	.title-name {
		color: blue;
	}
	#title {
		padding-top: 1.5em;
	}
	
</style>

<!--<div class="row">
	<div class="col-md-6 col-sm-12 col-xs-12">
		<div class="panel panel-default">
		  <div class="panel-heading">
		  	Summary <div class="display_date" ></div>
		  </div>
		  <div class="panel-body" id="summary">
		  	<center><div class="loader"></div></center>
		  </div>
		  
		</div>
	</div>

	<div class="col-md-6 col-sm-12 col-xs-12">
		<div class="panel panel-default">
		  <div class="panel-heading">
			  Positivity by Age Group <div class="display_date"></div>
		  </div>
		  <div class="panel-body" id="positivity" style="/*height:500px;">
		    <center><div class="loader"></div></center>
		  </div>
		</div>
	</div>

</div>-->
<div id="first">
	<div class="row">
		<!-- Map of the country -->
		<div class="col-md-12 col-sm-12 col-xs-12">
			<div class="panel panel-default">
			  <div class="panel-heading" id="heading">
			  	Outcomes by Age Group <div class="display_date"></div>
			  </div>
			  <div class="panel-body" id="age_outcomes">
			    <center><div class="loader"></div></center>
			  </div>
			</div>
		</div>
	</div>
</div>

<div id="second">
	<div class="row">
		<div class="col-md-12 col-sm-12 col-xs-12">
			<div class="panel panel-default">
			  <div class="panel-heading" id="heading">
			  	Age Group Testing Trends <div class="display_date"></div>
			  </div>
			  <div class="panel-body" id="outcomesAgeGroup">
			    <center><div class="loader"></div></center>
			  </div>
			</div>
		</div>
	</div>

	<div class="row">
		<div class="col-md-4 col-sm-12 col-xs-12">
			<div class="panel panel-default">
			  <div class="panel-heading" id="heading">
			  	Age Group Outcomes by County <div class="display_date"></div>
			  </div>
			  <div class="panel-body" id="outcomesBycounty">
			    <center><div class="loader"></div></center>
			  </div>
			</div>
		</div>
		<div class="col-md-4 col-sm-12 col-xs-12">
			<div class="panel panel-default">
			  <div class="panel-heading" id="heading">
			  	Age Group Outcomes by Sub-county<div class="display_date"></div>
			  </div>
			  <div class="panel-body" id="outcomesBysubcounty">
			    <center><div class="loader"></div></center>
			  </div>
			</div>
		</div>
		<div class="col-md-4 col-sm-12 col-xs-12">
			<div class="panel panel-default">
			  <div class="panel-heading" id="heading">
			  	Age Group Outcomes by Partner<div class="display_date"></div>
			  </div>
			  <div class="panel-body" id="outcomesBypartner">
			    <center><div class="loader"></div></center>
			  </div>
			</div>
		</div>
	</div>

	<div class="row">
		<!-- Map of the country -->
		<div class="col-md-12 col-sm-12 col-xs-12">
			<div class="panel panel-default">
			  <div class="panel-heading" id="heading">
			  	Age Group County Outcomes <div class="display_date"></div>
			  </div>
			  <div class="panel-body" id="coutnyAgeOutcomes">
			    <center><div class="loader"></div></center>
			  </div>
			</div>
		</div>
	</div>
</div>

<?= $this->load->view('age/age_view_footer'); ?>