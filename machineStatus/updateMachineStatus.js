(function(scope) {

	console.log('updateMachine.js has been invoked')

	$(document).ready(function(){

		$('.status_submit_button').click(function(e) {	

		  e.preventDefault()  

		  // debug
		  console.log("Status Submit button clicked")

		  message = "";

		  var data = $('.statusForm').serializeArray().reduce(function(obj, item) {
			obj[item.name] = item.value;
			return obj;
		  }, {});

		  var callback = function(result,message) {
		  	if(result == 0) {
		  		alert("Machine '" + data['m_id'] + "' was Updated");
		  	} else {
		  		alert("An Error Occured. " + message)
		  	}
		  }

		  var show_callback = function(result,message) {
		  	if(result == 0) {
		  		alert(message);
		  	} else {
		  		alert("An Error Occured. " + message)
		  	}
		  }

		  console.log(data);

		  // call function from dbTransactions.js
		  if(data['status'] != "") {
		  	console.log("this path");
		  	scope.fetchPHPdata(data, "updateMachineStatus.php", callback);
		  } else {
		  	scope.fetchPHPdata(data, "showMachineStatus.php", show_callback);
		  }

		});

	});

})(this);
