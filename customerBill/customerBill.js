(function(scope){

	/* Initial default model which to update dynamically */
	var model = {
		"customer_name" : "xxxxxx",
		"customer_phone" : "xxx-xxx-xxxx",
		"service_contract_id" : "xxxxxx",
		"model" : "xxxxxxx",
		"time" : (new Date()).toString(),
		"items" : [],
		"total" : 0
	}

	/* Helper function to generate html for customer info */
	var getCustInfo = function () {
			return "Name: " + model['customer_name']+
				   "<br>"+"Phone #: " + model['customer_phone'] +
				   "<br>"+"Model Repaired: " + model['model'] +
				   "<br>"+"Time Arrived: " + model['time']
	}

	/* Helper function to generate html for a table row of data*/
	var createRow = function (model,description,date,classr) {
		return "<tr class='row_entry "+classr+"'>" +
               "<td>" + model + "</td>" +
               "<td>" + description + "</td>" +
               "<td>" + date + "</td>" +
               "</tr>"
	}

	$(document).ready(function(){

		/* Update all the fields in the html based on new data in the model */
		function fieldUpdate() {
			$("#cust_info").html(getCustInfo());
			$('.row_entry').remove()
			$('#billTable').append(createRow("Description","Price","Date","heading"));
			var items = model['items']
			var sum = 0.0;
			for(var i = 0; i < items.length; i++) {
				var row = items[i];
				$('#billTable').append(createRow(row[0],row[1],row[2],"title"));
				sum += row[1];
			}
			$('#billTable').append(createRow("",sum,"total"));
		}

		/* upate with initial default model */
		fieldUpdate();

		/* update the model with a given array of data */
		function updateCustomerInfo(data) {
			model['customer_name'] = data[0];
			model['customer_phone'] = data[1];
			var matrix = [];
			for(var i = 2; i <= 5; i++) {
				matrix.push(data[i].split("|"))
			}
			model['items'] = [];
			for(var i = 0; i < matrix[0].length; i++) {
				var model = matrix[1][i] + " (" + matrix[0][i] + ")";
				var description = matrix[2][i];
				var date = matrix[3][i];
				model['items'].push([model,description,date]);
			}
			fieldUpdate();
		};

		/* callback to handle call to PHP file */
		var callback = function(result,data) {
		  	if(result == 0) {
		  		updateCustomerInfo(data);
		  	} else {
		  		alert("An Error Occured. " + data)
		  	}
	    }

	    var test_callback = function(result,data) {
	    	console.log(result);
	    	console.log(data);
	    }

	    /* call the php file and obtain results */
		function test (phone) {
			var data = {
				"number" : phone
			}
		    scope.fetchPHPdata(data, "getCustomerInfo.php", test_callback);
		}

		test("408-663-7143");
	});


})(this);