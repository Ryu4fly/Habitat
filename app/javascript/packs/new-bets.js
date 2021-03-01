//const select = document.querySelector('select');
const radioLabels = Array.from(document.querySelectorAll('.form-check-label'));
const button = document.querySelector('.link-btn');
const data = JSON.parse(document.querySelector('.hidden-info').dataset.hiddenInfo);
const radios = document.querySelectorAll('.form-check');
const newBetStatsColumn = document.querySelector('.new-bet-stats-column');
const legends = Array.from(document.querySelectorAll('legend'));

const clock = document.querySelector('.new-bet-timer');
let timeAtLoad = parseInt(clock.innerText, 10);
console.log(timeAtLoad);

const secondsToDaysHoursMinutesSeconds = (time) => {
  const nums = {
    days: null,
    hours: null,
    minutes: null,
    seconds: null
  };
  nums.days = Math.floor(time / 86400);
  time = time % 86400;
  nums.hours = Math.floor(time / 3600);
  time = time % 3600;
  nums.minutes = Math.floor(time / 60);
  time = time % 60;
  nums.seconds = time;
  Object.keys(nums).forEach((num) => {
    if (nums[num] === 0) {
      nums[num] = '00';
    } else if (nums[num] < 10) {
      nums[num] = `0${nums[num]}`;
    }
  });
  return `${nums.days}:${nums.hours}:${nums.minutes}:${nums.seconds}`;
};

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
