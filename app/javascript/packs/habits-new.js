const token = document.getElementsByName('csrf-token')[0].content;
console.log(token);
let avgCig = '';
let cost_a_pack = '';
let currency;
let which = 'avg_cig';

const numBtns = Array.from(document.querySelectorAll('.num-btn'));
const numView = document.querySelector('.num-view');
const question = document.querySelector('.question');

console.log(numBtns);

const refresh = () => {
  question.innerText = 'How much does a pack of cigarettes cost?';
  numView.innerText = '';
  which = 'cost_a_pack';
  console.log('avg cigs: ', avgCig);
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
      if (which === 'avg_cig') {
        refresh();
      } else {
        postData();
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
