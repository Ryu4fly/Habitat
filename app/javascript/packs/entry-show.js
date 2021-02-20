const entryTitle = document.querySelector('h1');
  const entries = Array.from(document.querySelectorAll('.color-text'));

  if (entryTitle.className === 'overcome') {
    entries.forEach( entry =>
      entry.classList.add('overcome'));
  } else {
    entries.forEach( entry => 
      entry.classList.add('smoked'));
  };