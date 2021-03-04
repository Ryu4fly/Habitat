import secondsToDaysHoursMinutesSeconds from './time-converter';
const radioLabels = Array.from(document.querySelectorAll('.form-check-label'));
const data = JSON.parse(document.querySelector('.hidden-info').dataset.hiddenInfo);
const userBalance = parseInt(document.querySelector('.user-balance').dataset.balance, 10);
const radios = document.querySelectorAll('.form-check');
const newBetStatsColumn = document.querySelector('.new-bet-stats-column');
const legends = Array.from(document.querySelectorAll('legend'));
const betInput = document.getElementById('bet_amount');
console.log(userBalance);

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
let betValue = betInput.value;

radios.forEach((radio) => {
  radio.addEventListener('change', (e) => {
    selectValue = e.target.value;
  });
});

betInput.addEventListener('change', (e) => (betValue = parseInt(e.target.value, 10)));

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

const tooPoorAlert = () => {
  alert("You don't have enough money to make that bet.");
  location.reload();
};

form.addEventListener('submit', (e) => {
  if (selectValue === '') {
    e.preventDefault();
    invalidAlert();
  } else if (betValue > userBalance) {
    e.preventDefault();
    tooPoorAlert();
  }
});
