const token = document.getElementsByName('csrf-token')[0].content;
let avgCig = '';
let cost_a_pack = '';
let currency;
let which = 'avg_cig';

const numBtns = Array.from(document.querySelectorAll('.num-btn'));
const numView = document.querySelector('.num-view');
const firstQuestion = document.querySelector('.first-question');
const numContainer = document.querySelector('.num-container');
const question = document.querySelector('.question');
const yesButton = document.getElementById('yes-button');
const noButton = document.getElementById('no-button');

noButton.addEventListener('click', () => (window.location.href = '/profile'));

yesButton.addEventListener('click', () => {
  numContainer.style.display = 'flex';
  firstQuestion.style.display = 'none';
});

const refresh = () => {
  question.innerText = 'How much does a pack of cigarettes cost?';
  numView.innerText = '';
  which = 'cost_a_pack';
};

const postData = async () => {
  const res = await fetch('/habits', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': token
    },
    body: JSON.stringify({ avg_cig: parseInt(avgCig, 10), cost_a_pack: parseInt(cost_a_pack, 10) })
  });
  console.log(res);
  if (res.ok && res.url) {
    window.location.href = res.url;
  } else {
    location.reload();
  }
};

numBtns.forEach((btn) => {
  btn.addEventListener('click', () => {
    if (btn.innerText === '⬅️') {
      if (avgCig.length) {
        avgCig = avgCig.slice(0, -1);
        console.log(avgCig);
        numView.innerText = avgCig;
      }
      if (cost_a_pack.length) {
        cost_a_pack = cost_a_pack.slice(0, -1);
        numView.innerText = cost_a_pack;
      }
    } else if (btn.innerText === 'OK') {
      if (which === 'avg_cig' && avgCig.length > 0) {
        refresh();
      } else if (which === 'cost_a_pack' && cost_a_pack.length > 0) {
        postData();
      } else {
        alert('Please enter a number.');
      }
    } else {
      if (which === 'avg_cig' && avgCig.length < 4) {
        avgCig += btn.innerText;
        numView.innerText = avgCig;
      } else if (which === 'cost_a_pack' && cost_a_pack.length < 4) {
        cost_a_pack += btn.innerText;
        numView.innerText = cost_a_pack;
        console.log('COST A PACK', cost_a_pack);
      }
    }
  });
});
