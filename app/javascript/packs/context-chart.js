import Chart from 'chart.js';
import moment from 'moment';

const ctx = document.getElementById('contextChart');
const dataArray = ctx.dataset.context;
const contextObj = JSON.parse(dataArray);
console.log(contextObj);

const myChart = new Chart(ctx, {
    type: 'pie',
    data: {
        labels: Object.keys(contextObj),
        datasets: [{
            label: '# of Cigarettes Smoked',
            data: Object.values(contextObj),
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
        layout: {
            padding: {
                left: 50,
                right: 0,
                top: 0,
                bottom: 0
            }
        }
    }
});