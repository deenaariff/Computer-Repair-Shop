(function(scope){

	/* Helper function to generate html for a table row of data*/
	var createRow = function (itemid,custphone,empno,timeofarrival,status) {
		return "<tr class='row_entry'>" +
               "<td>" + itemid + "</td>" +
               "<td>" + custphone + "</td>" +
               "<td>" + empno + "</td>" +
               "<td>" + timeofarrival + "</td>" +
               "<td>" + status + "</td>" +
               "</tr>"
	}

	$(document).ready(function(){

		/* update the model with a given array of data */
		var updateRepairJobs = function(total_data) {
			for(var i = 0; i < total_data.length; i ++) {
				var data = total_data[i].split("|");
				if(data.length > 1) {
					var html = createRow(data[0],data[1],data[2],data[3],data[4]);
					console.log(html);
					$('#repairTable').append(html);
				}
			}
		};

		/* callback to handle call to PHP file */
		var callback = function(result,data) {
		  	if(result == 0) {
		  		updateRepairJobs(data);
		  	} else {
		  		alert(data)
		  	}
	    }

	    scope.fetchPHPdata({}, "getRepairJobs.php", callback);

	});


})(this);