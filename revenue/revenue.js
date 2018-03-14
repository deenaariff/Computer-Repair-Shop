(function(scope) {

	console.log('revenue.js has been invoked')


	$(document).ready(function(){

		 var callback = function(result,message) {
		  	if(result == 0) {
		  		alert("New Machine '" + model + "' was Accepted");
		  	} else {
		  		alert("An Error Occured. " + message)
		  	}
		  }

		var data = {
			"date1": "2015-12-08",
			"date2": "2015-12-17"
		}

		scope.fetchPHPdata(data, "revenue.php", callback);

		$('.submit_button').click(function(e) {	

		  e.preventDefault()  

		  // debug
		  console.log("Revenue Generate button was clicked")

		  missing = false;
		  message = "";

		  model = "";

		  var data = $('.revenueForm').serializeArray().reduce(function(obj, item) {
		  	if (item.value == "") {
		  		message += "[FIELD]: " + item.name + " is missing. "
		  		missing = true;
		  	} else if (item.name == "model") {
		  		model = item.value;
			}
			obj[item.name] = item.value;
			return obj;
		  }, {});

		  if(missing == true) {
		  	alert(message)
		  	return;
		  }

		  // call function from dbTransactions.js
		  scope.fetchPHPdata(data, "revenue.php", callback);

		});

	});

})(this);
