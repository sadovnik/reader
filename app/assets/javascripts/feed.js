$(() => {
  $('.entry__link').click((e) => {
    e.preventDefault();
    $readLink = $(e.target).parent().find('.entry__read-link')[0];
    $readLink.click();
    return false;
  });
})
