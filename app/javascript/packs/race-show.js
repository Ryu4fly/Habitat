const token = document.getElementsByName('csrf-token')[0].content;

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
  console.log(res);
};

if (raceJoinBtn) {
  raceJoinBtn.addEventListener('click', joinRace);
}
