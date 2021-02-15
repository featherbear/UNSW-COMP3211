for (let elem of document.querySelectorAll('.typedjs')) {
  let strings = eval(elem.getAttribute('data-strings')); // # XSS me!
  console.log(strings);
  new Typed(elem, {
    strings: strings,
    typeSpeed: 20,
    backSpeed: 0,
    backDelay: 3000,
    fadeOut: true,
    loop: true
  });
}
