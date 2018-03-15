(function(scope) {

	console.log('updateMachine.js has been invoked')

	$(document).ready(function(){

		var createRevenueChart = function (days,data) {

			new Chart(document.getElementById("line-chart"), {
				  type: 'line',
				  data: {
				    labels: days,
				    datasets: [{ 
				        data: data,
				        label: "Date",
				        borderColor: "#3e95cd",
				        fill: false
				    }]
				  },
				  options: {
				    title: {
				      display: true,
				      text: 'Revenue in March'
				    }
				  }
			});

		}

	});

});