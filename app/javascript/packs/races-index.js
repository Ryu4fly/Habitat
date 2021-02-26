const upcomingCards = Array.from(document.querySelectorAll('.upcoming-card'));
const ongoingCards = Array.from(document.querySelectorAll('.ongoing-card'));
const upcomingBtn = document.getElementById('upcoming-btn');
const ongoingBtn = document.getElementById('ongoing-btn');

upcomingBtn.addEventListener('click', () => {
  upcomingBtn.hidden = true;
  ongoingBtn.hidden = false;
  upcomingCards.forEach((card) => card.hidden && (card.hidden = false));
  ongoingCards.forEach((card) => !card.hidden && (card.hidden = true));
});

ongoingBtn.addEventListener('click', () => {
  ongoingBtn.hidden = true;
  upcomingBtn.hidden = false;
  ongoingCards.forEach((card) => card.hidden && (card.hidden = false));
  upcomingCards.forEach((card) => !card.hidden && (card.hidden = true));
});
