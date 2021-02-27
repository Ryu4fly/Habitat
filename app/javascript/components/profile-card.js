const tabs = document.querySelectorAll('[data-tab-target]');
const tabContents = document.querySelectorAll('[data-tab-content]');

const cardsNavigation = () => {
  tabs.forEach(tab => {
    tab.addEventListener('click', () => {
      const target = document.querySelector(tab.dataset.tabTarget);
      tabs.forEach(tab => {
        tab.style.zIndex = "0";
      })
      tabContents.forEach(tabContent => {
        tabContent.classList.remove('active');
      })
      tab.style.zIndex = "1";
      target.classList.add("active");
    });
  });
}


export { cardsNavigation };
