<div id="jstification_pie">

</div>
<div>
    <ul>
        <?php echo $outcomes['ul'];?>
    </ul>
</div>
<script type="text/javascript">
	$(function(){
	    $('#jstification_pie').highcharts({
	        chart: {
        plotBackgroundColor: null,
        plotBorderWidth: null,
        plotShadow: false,
        type: 'pie'
            },
            title: {
                text: ''
            },
            tooltip: {
                pointFormat: 'Percentage: <b>{point.percentage:.1f}%</b><br/>{series.name}:<b>{point.y:.1f}</b>'
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: false
                    },
                    showInLegend: true
                }
            },
            series: [<?php echo json_encode($outcomes['hei']); ?>]
        });
    });

</script>