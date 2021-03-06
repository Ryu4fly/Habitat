import Chart from 'chart.js';
import moment from 'moment';

const ctx = document.getElementById('cigChart');
const dataArray = ctx.dataset.cigs;
const dataJSON = JSON.parse(dataArray);
const chartData = [];

dataJSON.forEach(elem => {
  const obj = {
    x: moment(elem[0]),
    y: elem[1]
  };
  chartData.push(obj);
});

const myChart = new Chart(ctx, {
    type: 'line',
    data: {
        // labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
        labels: chartData.map(obj=> obj.x),
        datasets: [{
            label: '# of Cigarettes Smoked',
            data: chartData,
            backgroundColor: [
                'rgba(0, 166, 122, 0.2)',
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)'
            ],
            borderColor: [
                'rgba(0, 166, 122, 1)',
                'rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            xAxes: [{
                ticks: {
                    beginAtZero: true
                },
                type : 'time',
                time: {
                  unit: 'month'
                }
            }]
        }
    }
});
