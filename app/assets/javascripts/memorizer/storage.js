function Memorizer_Storage() {
  const MEMORIZE_SELECTOR = '[data-memorize=true]';

  function fetch(item) {
    return localStorage.getItem(item);
  }

  function update(item, value) {
    localStorage.setItem(item, value);
  }

  return {
    fetch: fetch,
    update: update
  };
}
