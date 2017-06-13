onLoad(function() {
  const MEMORIZE_SELECTOR = '[data-memorize=true]';

  storage = new Memorizer_Storage;

  elements = $(MEMORIZE_SELECTOR).map(function(_, element) {
    return new Memorizer_Element($(element));
  });

  elements.each(function(_, element) {
    const itemName = element.getId();
    const value = storage.fetch(itemName);

    element.setValue(value);

    // set blur handler
    element.$domElement.blur(function(_) {
      storage.update(itemName, element.getValue());
    });

    const $parent = element.$domElement.parent()

    // set form handler
    if ($parent.is('form')) {
      $parent.submit(function(event) {
        event.preventDefault();

        storage.update(itemName, element.getValue());

        return true;
      });
    }
  });
});
