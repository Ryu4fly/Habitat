import Chart from 'chart.js';
import moment from 'moment';

const ctx = document.getElementById('feelingsChart');
const dataArray = ctx.dataset.feelings;
const feelingsObj = JSON.parse(dataArray);


const myChart = new Chart(ctx, {
    type: 'doughnut',
    data: {
        labels: Object.keys(feelingsObj),
        datasets: [{
            label: '# of Cigarettes Smoked',
            data: Object.values(feelingsObj),
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)'
            ],
            borderColor: [
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
            
        }
    }
});