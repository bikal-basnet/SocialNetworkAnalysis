WebFontConfig = {
  google: { families: ['Droid Serif:400,700,400italic,700italic', 'Shadows Into Light Two'] },
  custom: { families: ['Hoefler'],
    urls: ['//cloud.typography.com/684222/756420/css/fonts.css'] }
};
(function () {
  var wf = document.createElement('script');
  wf.src = ('https:' == document.location.protocol ? 'https' : 'http') +
    '://ajax.googleapis.com/ajax/libs/webfont/1/webfont.js';
  wf.type = 'text/javascript';
  wf.async = 'true';
  var s = document.getElementsByTagName('script')[0];
  s.parentNode.insertBefore(wf, s);
})();
