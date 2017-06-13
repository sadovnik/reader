const log = console.log;

function onLoad(callback) {
  $(document).on('turbolinks:load', callback);
}
