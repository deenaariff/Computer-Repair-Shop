var scope = this;

$(document).ready(function(){

	console.log("started");

	function drawChart1(data1,data2) {

		if(data1.length == 1 && data1[0] == "") data1 = ["No Customers"];
		if(data2.length == 1 && data2[0] == "") data2 = [0];

		var values = [];
		for(var i = 0; i < data2.length; i++) {
			var val = parseInt(data2[i]);
			values.push(val);
		}

		console.log("Test1: " + data1);
		console.log("Test2: " + values);

		new Chart(document.getElementById("chart1"), {

		  	type: 'bar',
		    data: {
		      labels: data1,
		      datasets: [
		        {
		          label: "Items",
		          backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
		          data: values
		        }
		      ]
		    },
		    options: {
		      legend: { display: false },
		      title: {
		        display: true,
		        text: 'Repair Logs Per Customer'
		      },
		      scales: {
	            yAxes: [{
	                ticks: {
	                    beginAtZero:true
	                }
	            }]
		      }
		    }

		});
	}

	scope.fetchPHPdata({}, "repairLogStats.php", function(result,data) {
		if(result == 0) {
			var labels = data[0].split("|");
			var data = data[1].split("|");
			drawChart1(labels,data);
		} else {
			console.log("Error");
		}
	});

	function drawChart2(data1,data2) {

		if(data1.length == 1 && data1[0] == "") data1 = ["No Customers"];
		if(data2.length == 1 && data2[0] == "") data2 = [0];

		var values = [];
		for(var i = 0; i < data2.length; i++) {
			var val = parseInt(data2[i]);
			values.push(val);
		}

		new Chart(document.getElementById("chart2"), {

		  	type: 'bar',
		    data: {
		      labels: data1,
		      datasets: [
		        {
		          label: "Items",
		          backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
		          data: values
		        }
		      ]
		    },
		    options: {
		      legend: { display: false },
		      title: {
		        display: true,
		        text: 'Repair Jobs Per Customer'
		      }
		    }
		});
	}

	scope.fetchPHPdata({}, "repairJobStats.php", function(result,data) {
		if(result == 0) {
			var labels = data[0].split("|");
			var data = data[1].split("|");
			drawChart2(labels,data);
		} else {
			console.log("Error");
		}
	});

	var createRow = function (model,price,cost,hours,description,classr) {
		return "<tr class='row_entry "+classr+"'>" +
               "<td>" + model + "</td>" +
               "<td>" + price + "</td>" +
               "<td>" + cost + "</td>" +
               "<td>" + hours + "</td>" +
               "<td>" + description + "</td>" +
               "</tr>"
	}

	//itemID, contractID, custPhone, empNo, timeOfArrival, DONEDATE
	var createRows = function(rows) {
		$('#repairTable').append(createRow("ItemID","ContractID","EmpNo","Arrival","Done","heading"));
		for(var i = 0; i < rows.length; i++) {
			row = rows[i].split("|");
			$('#repairTable').append(createRow(row[0],row[1],row[2],row[3],row[4],"title"));
		}
	}
		
	scope.fetchPHPdata({}, "getRepairJobs.php", function(result,data) {
		if(result == 0) {
			createRows(data);
		} else {
			console.log("Error");
		}
	});

	//contractId, custPhone, startDate, endDate, contractType
	var createRows2 = function(rows) {
		$('#contractTable').append(createRow("ContractID","Phone","Start Date","End Date","Type","heading"));
		for(var i = 0; i < rows.length; i++) {
			row = rows[i].split("|");
			$('#contractTable').append(createRow(row[0],row[1],row[2],row[3],row[4],"title"));
		}
	}

	scope.fetchPHPdata({}, "getContracts.php", function(result,data) {
		if(result == 0) {
			createRows2(data);
		} else {
			console.log("Error");
		}
	});

	var createRow2 = function (model,price,cost,classr) {
		return "<tr class='row_entry "+classr+"'>" +
               "<td>" + model + "</td>" +
               "<td>" + price + "</td>" +
               "<td>" + cost + "</td>" +
               "</tr>"
	}

	//employeeNo, empName, empPhone
	var createRows3 = function(rows) {
		$('#empTable').append(createRow2("Emp Id","Employee","Phone","heading"));
		for(var i = 0; i < rows.length; i++) {
			row = rows[i].split("|");
			$('#empTable').append(createRow2(row[0],row[1],row[2],"title"));
		}
	}

	scope.fetchPHPdata({}, "getContracts.php", function(result,data) {
		if(result == 0) {
			createRows3(data);
		} else {
			console.log("Error");
		}
	});

		
});

