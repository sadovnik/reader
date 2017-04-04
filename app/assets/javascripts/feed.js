$(function() {
  $('.entry__link').click(function(e) {
    e.preventDefault();
    $readLink = $(e.target).parent().find('.entry__read-link')[0];
    $readLink.click();
    return false;
  });
})
