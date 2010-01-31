/*
 *
 * Flaunt 0.2 - http://github.com/ippa/flaunt
 *
 * Minimalistic one-file presentations with sinatra, html and jquery.
 *
 * author: ippa
 *
 * Initially made for Shrug meetup 28 jan 2010.
 *
 */
$(function() {

  /* Each window resize, set new heights for the slides */
  $(window).resize(function() { update_slide_height(); });
  
  /* If user scrolls manually, we need to update the progress box */
  $(window).scroll(function() { update_progress(); });

  $(document).keyup(function (e) {
    if (e.keyCode == 32 || e.keyCode == 39) { /* Right or Space */
      next();
      return false
    }
    if (e.keyCode == 37) {  /* Left */
      prev();
      return false
    }
  });
  
  update_progress();

  update_slide_height();

});

function create_slides()  {
  $("hr").each(function(){
    $(this).precss('height', slide_height() );
  });
}

/* Resize all slides to fit the current window, this is done when loaded + on window resize */
function update_slide_height() {
  $(".slide").each(function(){
    $(this).css('height', slide_height() );
  });
}

/* Scroll down one slide */
function next() {
  $.scrollTo('+=' + slide_height() + 'px', { axis:'y' });
}

/* Scroll up one slide */
function prev() {
  $.scrollTo('-=' + slide_height() + 'px', { axis:'y' });
}

/* Update progress_box with current slide and total slides */
function update_progress() {
  $("#progress_box").text(current_slide() + " / " + total_slides() );
}

/* Return the index of current slide */
function current_slide() {
  return parseInt($(window).scrollTop() / slide_height() + 1);
}

/* Return total amount of slides in current presentation */
function total_slides() {
  return $(".slide").size();
}

/* How big is each slide */
function slide_height() {
  return $(window).height();
}
