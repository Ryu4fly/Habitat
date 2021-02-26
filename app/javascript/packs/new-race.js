for (let i = 0; i < 1000; i++) {
  let ran = Math.floor(Math.random() * 3);
  if (ran === 0) {
    console.log(`"${c.getWord(c.adjective)}-${c.getWord(c.singularNoun)}",`);
  } else if (ran === 1) {
    console.log(`"${c.getWord(c.singularNoun)}${c.getWord(c.pluralNoun)}",`);
  } else if (ran === 2) {
    console.log(`"${c.getWord(c.pluralNoun)}${Math.floor(Math.random() * 2000)}",`);
  }
}
