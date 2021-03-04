const closerBtn = document.querySelector('.closer-btn');
const uncollectedEarnings = document.querySelector('.uncollected-earnings');
const claimMoneyBtn = document.getElementById('claim-money-btn');

if (closerBtn) {
  closerBtn.addEventListener('click', () => {
    uncollectedEarnings.hidden = true;
  });
}
if (claimMoneyBtn) {
  claimMoneyBtn.addEventListener('click', () => {
    window.location.href = '/claim-bets';
  });
}

const activeColor = '#312f2f';
const inactiveColor = '#37463a';
let openElement = 'openRaces';
const buttons = {
  upcomingRacesBtn: document.getElementById('upcoming-race-btn'),
  openRacesBtn: document.getElementById('open-race-btn'),
  completedRacesBtn: document.getElementById('finished-race-btn')
};
const elements = {
  upcomingRaces: document.querySelector('.upcoming-races'),
  openRaces: document.querySelector('.open-races'),
  completedRaces: document.querySelector('.completed-races')
};

const handleClick = (e) => {
  openElement = e.target.value;
  Object.keys(elements).forEach((key) => {
    if (key === openElement) {
      elements[key].hidden = false;
      Object.keys(buttons).forEach((key) => {
        buttons[key].style.backgroundColor = inactiveColor;
      });
      buttons[`${e.target.value}Btn`].style.backgroundColor = activeColor;
    } else {
      elements[key].hidden = true;
    }
  });
};

handleClick({ target: { value: 'openRaces' } });

Object.keys(buttons).forEach((key) => {
  buttons[key].addEventListener('click', handleClick);
});
