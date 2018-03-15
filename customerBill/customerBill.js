(function(scope){


	$(document).ready(function(){

		/* Initial default model which to update dynamically */
		var model = {
			"customer_name" : "xxxxxx",
			"customer_phone" : "xxx-xxx-xxxx",
			"total" : 0,
			"items" : []
		}

		/* Helper function to generate html for customer info */
		var getCustInfo = function (m) {
			return "Customer Name: " + m['customer_name']+
				   "<br>"+"Phone #: " + m['customer_phone'] +
				   "<br>"+"Total Price: $" + m['total'] 	
		}

		/* Helper function to generate html for a table row of data*/
		var createRow = function (model,price,cost,hours,description,date,classr) {
			return "<tr class='row_entry "+classr+"'>" +
	               "<td>" + model + "</td>" +
	               "<td>" + contract + "</td>" +
	               "<td>" + price + "</td>" +
	               "<td>" + cost + "</td>" +
	               "<td>" + hours + "</td>" +
	               "<td>" + description + "</td>" +
	               "<td>" + date + "</td>" +
	               "</tr>"
		}

		/* Update all the fields in the html based on new data in the model */
		function fieldUpdate(m) {
			$("#cust_info").html(getCustInfo(m));
			$('.row_entry').remove()
			$('#billTable').append(createRow("Model (Contract ID)","Price","Parts cost","Labor Hours","Description","Date","heading"));
			var items = m['items']
			var sum = 0.0;
			for(var i = 0; i < items.length; i++) {
				var row = items[i];
				$('#billTable').append(createRow(row[0],row[1],row[2],row[3],row[4],row[5],"title"));
				sum += row[1];
			}
		}

		/* upate with initial default model */
		fieldUpdate(model);

		/* update the model with a given array of data */
		function updateCustomerInfo(m,data) {
			console.log("Logging data");
			console.log(data);
			m['customer_name'] = data[0];
			m['customer_phone'] = data[1];
			var matrix = [];
			for(var i = 2; i <= 8; i++) {
				matrix.push(data[i].split("|"))
			}
			m['items'] = [];
			for(var i = 0; i < matrix[0].length; i++) {
				var contract = matrix[0][i];
				var model =  matrix[1][i] + " (" + contract + ")"
				var description = matrix[2][i];
				var date = matrix[3][i];
				var price = "$" + matrix[4][i];
				var costs = "$" + matrix[5][i];
				var hours = matrix[6][i];
				m['items'].push([model,price,costs,hours,description,date]);
			}
			m['total'] = data[9];
			fieldUpdate(m);
		};

		/* callback to handle call to PHP file */
		var callback = function(result,data) {
		  	if(result == 0) {
		  		updateCustomerInfo(model,data);
		  	} else {
		  		alert(data)
		  	}
	    }

	    /* call the php file and obtain results */
		function getData (phone) {
			var data = {
				"number" : phone
			}
		    scope.fetchPHPdata(data, "getCustomerInfo.php", callback);
		}

		$("#getBillBtn").click(function(){
			var number = $('#input').val();
			console.log(number);
        	getData(number);
    	}); 
	});


})(this);