const carousel = () => {
  $('.slider').owlCarousel({
              items: 3,
              singleItem:true,
              nav: true,
              dots: false,
              loop: true,
              autoPlay: 3000
          });
}


export { carousel };
