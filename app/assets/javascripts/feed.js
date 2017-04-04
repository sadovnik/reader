$(function() {
  $entryLinks = $('.entry__link');

  function fetchReadLink($element) {
    $readLink = $element.parent().find('.entry__read-link');

    if ($readLink.length === 0) {
      throw 'Unable to find read-link'
    }

    return $readLink[0];
  }

  $entryLinks.click(function(e) {
    e.preventDefault();

    $originalLink = $(e.target);

    $entry = $originalLink.parent().parent();
    $entry.addClass('entries__entry_muted');

    $readLink = fetchReadLink($originalLink);
    $readLink.click();

    return false;
  });
})
