const token = document.getElementsByName('csrf-token')[0].content;

const btns = Array.from(document.querySelectorAll('.claim-bet-btn'));
const cards = Array.from(document.querySelectorAll('.race-index-custom-card'));
const currentBalanceDisplay = document.querySelector('.unclaimed-bet-page-current-balance');
let originalBalance = parseInt(document.querySelector('.original-balance').dataset.balance, 10);

function numberWithCommas(x) {
  return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}

const saveEarnings = async (earnings, bet_id) => {
  const res = await fetch('/update-balance', {
    method: 'PUT',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': token
    },
    body: JSON.stringify({ earned_money: earnings, bet_id: bet_id })
  });
  if (res.ok) {
    originalBalance += parseInt(earnings, 10);
    console.log(originalBalance);
    currentBalanceDisplay.innerText = `💰CURRENT BALANCE: $${numberWithCommas(originalBalance)}💰`;
    for (let i = 0; i < cards.length; i++) {
      if (cards[i].dataset.betId === bet_id) {
        cards[i].parentElement.removeChild(cards[i]);
        break;
      }
    }
  }
};

btns.forEach((btn) => {
  btn.addEventListener('click', (e) => saveEarnings(e.target.value, e.target.dataset.betId));
});
