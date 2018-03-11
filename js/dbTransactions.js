(function(scope) {

	console.log('dbTransactions.js has been invoked')

	// this is a private method
	function generatePHPparamaters (dict) {
		var result = "?"
		Object.keys(dict).forEach(function(key) {
	    	result = result + "&" + key + "=" + dict[key];
		});
		return result;
	}

	// expose this function externally
	scope.fetchPHPdata = function (form, php, callback) {

		/* incoming data looks like this

		var form = {
			"name" : ***,
			"model" : ***,
			"service_contract" : **8
		}*/

		URL = php + generatePHPparamaters(form);

		$.ajax({
		   url: URL,
		   success: function (response) {
		   	 data = response.split(",")
		   	 if(data[0] == "0") {
		   	 	console.log(response);
		   	 	callback(0,data.slice(1));
		   	 } else {
		   	 	console.log('Error: ' + response)
		   	 	callback(1,data[1]);
		   	 }
		   }
		});

	}

	console.log(scope)

})(this);