console.log("started");

var scope = this;

$(document).ready(function(){

	function drawChart1(data1,data2) {

		new Chart(document.getElementById("chart1"), {

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

	scope.fetchPHPdata(data, "repairJobStats.php", function(result,data) {
		if(result == 0) {
			var split = data.split(",");
			var labels = split[0].split("|");
			var data = split[1].split("|");
			drawChart1(labels,data);
		} else {
			console.log("Error");
		}
	});

	function drawChart2(data1,data2) {

		new Chart(document.getElementById("chart2"), {
		  type: 'line',
		  data: {
		    labels: [1500,1600,1700,1750,1800,1850,1900,1950,1999,2050],
		    datasets: [
		      { 
		        data: [86,114,106,106,107,111,133,221,783,2478],
		        label: "Africa",
		        borderColor: "#3e95cd",
		        fill: false
		      }
		    ]
		  },
		  options: {
		    title: {
		      display: true,
		      text: 'World population per region (in millions)'
		    }
		  }
		});
	}

	function drawChart3(data1,data2) {

		new Chart(document.getElementById("chart3"), {
		  type: 'line',
		  data: {
		    labels: [1500,1600,1700,1750,1800,1850,1900,1950,1999,2050],
		    datasets: [
		      { 
		        data: [86,114,106,106,107,111,133,221,783,2478],
		        label: "Africa",
		        borderColor: "#3e95cd",
		        fill: false
		      }
		    ]
		  },
		  options: {
		    title: {
		      display: true,
		      text: 'World population per region (in millions)'
		    }
		  }
		});
	}

	function drawChart4(data1,data2) {

		new Chart(document.getElementById("chart4"), {
		  type: 'line',
		  data: {
		    labels: [1500,1600,1700,1750,1800,1850,1900,1950,1999,2050],
		    datasets: [
		      { 
		        data: [86,114,106,106,107,111,133,221,783,2478],
		        label: "Africa",
		        borderColor: "#3e95cd",
		        fill: false
		      }
		    ]
		  },
		  options: {
		    title: {
		      display: true,
		      text: 'World population per region (in millions)'
		    }
		  }
		});
	}

	drawChart1();
	drawChart2();
	drawChart3();
	drawChart4();

		
});

