// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from '@rails/ujs';
import Turbolinks from 'turbolinks';
import * as ActiveStorage from '@rails/activestorage';
import 'channels';

Rails.start();
Turbolinks.start();
ActiveStorage.start();

// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import 'bootstrap';
import Iconify from '@iconify/iconify';

// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';

const showCircle = (cursor, seconds) => {
  // console.log(cursor);
  const circle = document.createElement('div');
  circle.style.position = 'fixed';
  circle.style.backgroundColor = 'grey';
  circle.style.borderRadius = '50%';
  circle.style.left = `${cursor.clientX - 24}px`;
  circle.style.top = `${cursor.clientY - 24}px`;
  circle.style.height = '48px';
  circle.style.width = '48px';
  circle.style.opacity = 0.8;
  document.body.appendChild(circle);
  setTimeout(() => {
    circle.remove();
  }, seconds * 500);
};

document.addEventListener('touchmove', (event) => {
  showCircle(event.targetTouches[0], 0.1);
});
document.addEventListener('click', (event) => {
  showCircle(event, 1);
});

document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  // initSelect2();
  Iconify.scanDOM();
});
