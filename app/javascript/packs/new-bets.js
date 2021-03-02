import secondsToDaysHoursMinutesSeconds from './time-converter';
const radioLabels = Array.from(document.querySelectorAll('.form-check-label'));
const button = document.querySelector('.link-btn');
const data = JSON.parse(document.querySelector('.hidden-info').dataset.hiddenInfo);
const radios = document.querySelectorAll('.form-check');
const newBetStatsColumn = document.querySelector('.new-bet-stats-column');
const legends = Array.from(document.querySelectorAll('legend'));

const clock = document.querySelector('.new-bet-timer');
let timeAtLoad = parseInt(clock.innerText, 10);
console.log(timeAtLoad);

clock.innerText = secondsToDaysHoursMinutesSeconds(timeAtLoad);

setInterval(() => {
  timeAtLoad -= 1;
  clock.innerText = secondsToDaysHoursMinutesSeconds(timeAtLoad);
}, 1000);

legends.forEach((legend) => {
  legend.hidden = true;
});

let selectValue = '';

radios.forEach((radio) => {
  radio.addEventListener('change', (e) => {
    selectValue = e.target.value;
  });
});

radioLabels.forEach((radio, index) => {
  const userStats = data[index][radio.innerText];
  newBetStatsColumn.insertAdjacentHTML(
    'beforeend',
    `<div class="new-bet-stat"><div>🐎 Odds: ${userStats.odds}</div><div> 🚬 per day: ${userStats.avg_cig}</div> </div>`
  );
});

const form = document.querySelector('form');

const invalidAlert = () => {
  alert('Please choose a racer 🐎');
  location.reload();
};

form.addEventListener('submit', (e) => {
  if (selectValue === '') {
    e.preventDefault();
    invalidAlert();
  }
});
