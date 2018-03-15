console.log("started");

$(document).ready(function(){

	function drawChart1(data1,data2) {

		new Chart(document.getElementById("chart1"), {
			
		  	type: 'bar',
		    data: {
		      labels: ["Africa", "Asia", "Europe", "Latin America", "North America"],
		      datasets: [
		        {
		          label: "Population (millions)",
		          backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
		          data: [2478,5267,734,784,433]
		        }
		      ]
		    },
		    options: {
		      legend: { display: false },
		      title: {
		        display: true,
		        text: 'Predicted world population (millions) in 2050'
		      }
		    }
		});
	}

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

