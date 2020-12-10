$(window).scroll(function(){
//Window Math
var scrollTo = $(window).scrollTop(),
docHeight = $(document).height(),
windowHeight = $(window).height();
scrollPercent = (scrollTo / (docHeight-windowHeight)) * 100;
scrollPercent = scrollPercent.toFixed(0);
if (scrollPercent>0) {
  $('#percentageCounter h1').text(scrollPercent+"%");
}

}).trigger('scroll');