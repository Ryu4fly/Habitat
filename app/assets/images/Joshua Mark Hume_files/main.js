const pictureBoxes = Array.from(document.querySelectorAll('.picture'));
console.log(pictureBoxes);

const picturePaths = {
  ohb: { num: 0, path: ['./ohb-screenshot.png', './drum-machine.png'] },
  nicotine: { num: 0, path: ['./nicotine.png'] },
  kanjikakikikai: { num: 0, path: ['./kanji1.png', './kanji2.png'] },
  cook: { num: 0, path: ['./cook1.png', './cook2.png'] },
  chinpun: { num: 0, path: ['./chinpun1.png', './chinpun2.png'] },
  s2pd: { num: 0, path: ['./s2pd1.png', './s2pd2.png', './sp2d3.png'] },
  mumbo: { num: 0, path: ['./mumbo1.png', './mumbo2.png'] },
  theremin: { num: 0, path: ['./theremin1.png'] }
};

const images = [];
Object.keys(picturePaths).forEach((key) => {
  console.log(key);
  picturePaths[key].path.forEach((path) => {
    const img = new Image();
    img.src = path;
    images.push(img);
  });
});

pictureBoxes.forEach((picture) => {
  picture.style.backgroundImage = `url(${picturePaths[picture.id].path[0]})`;
  picture.style.backgroundSize = 'cover';
  picture.style.backgroundRepeat = 'no-repeat';
  picture.style.backgroundPosition = 'center';
  setInterval(() => {
    if (picturePaths[picture.id].num < picturePaths[picture.id].path.length - 1) {
      picturePaths[picture.id].num += 1;
    } else {
      picturePaths[picture.id].num = 0;
    }
    picture.style.backgroundImage = `url(${picturePaths[picture.id].path[picturePaths[picture.id].num]})`;
  }, 5000);
});
