import secondsToDaysHoursMinutesSeconds from './time-converter';

const token = document.getElementsByName('csrf-token')[0].content;

const clock = document.querySelector('.new-bet-timer');
if (clock) {
  let timeAtLoad = parseInt(clock.innerText, 10);

  clock.innerText = secondsToDaysHoursMinutesSeconds(timeAtLoad);

  setInterval(() => {
    timeAtLoad -= 1;
    clock.innerText = secondsToDaysHoursMinutesSeconds(timeAtLoad);
  }, 1000);
}

const raceJoinBtn = document.getElementById('race-join-btn');

const joinRace = async () => {
  const res = await fetch(window.location, {
    method: 'PATCH',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': token
    },
    body: JSON.stringify({ join_race: true })
  });
  if (res.ok) {
    window.location.href = '/race-dashboard';
  }
};

if (raceJoinBtn) {
  raceJoinBtn.addEventListener('click', joinRace);
}
