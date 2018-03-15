console.log("started");

var scope = this;

$(document).ready(function(){

	function drawChart1(data1,data2) {

		if(data1.length == 0) data1 = [];
		if(data2.length == 0) data2 = [];

		values = [];
		for(var i = 0; i < data2.length; i++) {
			values.push((int)data[i]);
		}

		new Chart(document.getElementById("chart1"), {

		  	type: 'bar',
		    data: {
		      labels: values,
		      datasets: [
		        {
		          label: "Items",
		          backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
		          data: data2
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

		if(data1.length == 0) data1 = [];
		if(data2.length == 0) data2 = [];

		new Chart(document.getElementById("chart2"), {

		  	type: 'bar',
		    data: {
		      labels: data1,
		      datasets: [
		        {
		          label: "Items",
		          backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
		          data: data2
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

		
});

