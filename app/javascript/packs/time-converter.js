const secondsToDaysHoursMinutesSeconds = (time) => {
  const nums = {
    days: null,
    hours: null,
    minutes: null,
    seconds: null
  };
  nums.days = Math.floor(time / 86400);
  time = time % 86400;
  nums.hours = Math.floor(time / 3600);
  time = time % 3600;
  nums.minutes = Math.floor(time / 60);
  time = time % 60;
  nums.seconds = time;
  Object.keys(nums).forEach((num) => {
    if (nums[num] === 0) {
      nums[num] = '00';
    } else if (nums[num] < 10) {
      nums[num] = `0${nums[num]}`;
    }
  });
  return `${nums.days}:${nums.hours}:${nums.minutes}:${nums.seconds}`;
};

export default secondsToDaysHoursMinutesSeconds;
