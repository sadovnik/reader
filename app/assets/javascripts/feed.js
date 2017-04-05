$(function() {
  const $feed = $('#feed');
  const $entryLinks = $('.entries__entry_unread .entry__link');

  function findEntryById(id) {
    $entry = $('#entry-' + id);

    if ($entry.length === 0) {
      throw 'Unable to find entry'
    }

    return $entry;
  }

  function fetchReadLink($element) {
    const $readLink = $element.parent().find('.entry__read-link');

    if ($readLink.length === 0) {
      throw 'Unable to find read-link'
    }

    return $readLink[0];
  }

  function setupClickHandler($elements) {
    $elements.click(function(event) {
      const $originalLink = $(event.target);
      const $readLink = fetchReadLink($originalLink);
      $readLink.click();
    });
  }

  setupClickHandler($entryLinks);

  $feed.on('entry-unread', function(event, entryId) {
    $entry = findEntryById(entryId);
    setupClickHandler($entry);
  });
});
