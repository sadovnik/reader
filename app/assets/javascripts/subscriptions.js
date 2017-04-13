function findSubscription(id) {
  $subscription = $('#subscription-' + id);

  if ($subscription.length == 0) {
    throw 'Unable to find subcription with id = ' + id;
  }

  return $subscription;
}

function hide(subscriptionId) {
  findSubscription(subscriptionId).animate({ opacity: 0, height: '0px' });
}
