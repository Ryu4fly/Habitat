import s from 's2pd';
import groundPath from '../../assets/images/ground.png';
import cloudsPath from '../../assets/images/clouds.png';
import mountainsPath from '../../assets/images/mountains.png';
import lungsPath from '../../assets/images/lungs.png';
import heartPath from '../../assets/images/heart.png';
import cigPath from '../../assets/images/cig.png';
import bgmPath from '../../assets/audios/bgm.mp3';
import gameOverMusicPath from '../../assets/audios/game-over';
import ouchPath from '../../assets/audios/ouch';

const token = document.getElementsByName('csrf-token')[0].content;

const btn = document.getElementById('game-btn');
const canvas = document.getElementById('game-canvas');
const gameTime = document.querySelector('.game-time');
const moneyEarned = document.querySelector('.money-earned');
const moneyFlashText = document.querySelector('.money-flash-text');
const gameMessage = document.querySelector('.game-message');
const gameOverScreen = document.querySelector('.game-over-screen');
const playAgainBtn = document.getElementById('play-again-btn');
const raceDashboardBtn = document.getElementById('race-dashboard-btn');
const profileBtn = document.getElementById('profile-btn');

const bgm = new s.Sound(bgmPath, 0.3, true, 1);
const gameOverMusic = new s.Sound(gameOverMusicPath, 0.6, false, 1);
const ouch = new s.Sound(ouchPath, 0.3, false, 1);
s.loadAudio();

let moneyBonus = 1;
let currentMoney = 0;

if (window.innerWidth < window.innerHeight) {
  s.addCanvas(canvas, window.innerWidth - 16, window.innerWidth / 1.4);
} else {
  s.addCanvas(canvas, 300, 200);
}

s.stillCanvas();
const clouds = new s.Background(cloudsPath);
const mountains = new s.Background(mountainsPath);
const ground = new s.Tile(groundPath, 0, 10, 0, 1);
const lungs = new s.Sprite(40, 100, lungsPath, 4, 8);

const cig1 = new s.Sprite(100, s.height - 90, cigPath, 3, 8);
const cig2 = new s.Sprite(100, s.height - 90, cigPath, 3, 8);
const cig3 = new s.Sprite(100, s.height - 90, cigPath, 3, 8);
const cig4 = new s.Sprite(100, s.height - 90, cigPath, 3, 8);
const cigs = [cig1, cig2, cig3, cig4];

let gameStarted = 0;
let timeSinceStart = 0;
let lives = 3;

const setCigPos = (cig) => (cig.xPos = s.randomBetween(s.width + 12, s.width * 2));

cigs.forEach((cig) => {
  s.onCollision(cig, lungs, true, () => {
    if (lives) {
      ouch.play();
      lives -= 1;
    }
  });
  setCigPos(cig);
});

setCigPos;
const hearts = new s.Tile(heartPath, 10, 10, 3, 1); // repeatX changes repeats
const startText = new s.Text('red', 'center', 'center', 'PRESS JUMP TO START', 'VT323', 24);
startText.center = true;
lungs.feelGravity(11);

lungs.addAnimation('still', 0, 1);
lungs.addAnimation('running', 1, 2);
lungs.addAnimation('dead', 3, 1);
lungs.changeAnimationTo('still');

ground.yPos = s.height - 30;
ground.platform(true);

const checkIfCigsTooClose = () => {
  cigs.forEach((outerCig) => {
    cigs.forEach((innerCig) => {
      if (innerCig.id !== outerCig.id) {
        if (innerCig.xPos - outerCig.xPos > 100 && innerCig.xPos - outerCig.xPos < 225) {
          if (innerCig.xPos > s.width) {
            setCigPos(innerCig);
          }
        }
      }
    });
  });
};

s.loop(() => {
  checkIfCigsTooClose();
  hearts.repeatX = lives;
  if (gameStarted === 1) {
    timeSinceStart += 1;
    gameTime.innerText = `TIME: ${s.roundToDecimals(timeSinceStart / 60, 2)}`.replace('.', ':');
    cigs.forEach((cig) => {
      if (cig.xPos < 0 - cig.width) {
        setCigPos(cig);
      }
    });
    if (timeSinceStart % 600 === 0) {
      currentMoney = currentMoney + moneyBonus * 10;
      moneyFlashText.innerText = `$${currentMoney}!`;
      moneyFlashText.hidden = false;
      setTimeout(() => {
        moneyFlashText.hidden = true;
      }, 1500);
      moneyBonus += 0.5;
      moneyEarned.innerText = `CASH EARNED: $${currentMoney} 💰💵🤑`;
    }
  }
  if (lives <= 0) {
    if (gameStarted === 1) {
      gameStarted = 2;
      cigs.forEach((cig) => {
        cig.velX = 0;
        cig.opacity = 0;
        lungs.changeAnimationTo('dead');
      });
      gameMessage.innerText = `You earned $${currentMoney}!`;
      gameOverScreen.hidden = false;
      bgm.stop();
      gameOverMusic.play();
      ground.innerVelX = 0;
      mountains.velX = 0;
      clouds.velX = -0;
    }
  }
});

const saveEarnings = async (callback) => {
  const res = await fetch('/update-balance', {
    method: 'PUT',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': token
    },
    body: JSON.stringify({ earned_money: currentMoney })
  });
  if (res.ok) {
    callback();
  }
};

const handleClick = () => {
  btn.style.transform = 'translate(1px, 2px)';
  setTimeout(() => {
    btn.style.transform = 'translate(-1px, -2px)';
  }, 100);

  if (!gameStarted) {
    gameStarted = 1;
    startText.opacity = 0;
    cigs.forEach((cig) => (cig.velX = -5));
    ground.innerVelX = -1.5;
    mountains.velX = -0.4;
    clouds.velX = -0.1;
    lungs.changeAnimationTo('running');
    bgm.play();
  }
  if (gameStarted === 1) {
    lungs.jump(100, true);
  }
};

btn.addEventListener('click', handleClick);

profileBtn.addEventListener('click', () => {
  saveEarnings(() => (window.location.href = '/profile'));
});

raceDashboardBtn.addEventListener('click', () => {
  saveEarnings(() => (window.location.href = '/race-dashboard'));
});

playAgainBtn.addEventListener('click', () => {
  saveEarnings(() => window.location.reload());
});
