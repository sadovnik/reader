function Memorizer_Element($element) {
  const itemName = $element.prop('id');

  if (!$element.is('input')) {
    throw 'Memorized element must be input';
  }

  if (!itemName) {
    throw 'Memorized inputs must have `id` property';
  }

  function setValue(value) {
    return $element.val(value);
  }

  function getValue() {
    return $element.val();
  }

  function getId() {
    return $element.prop('id');
  }

  return {
    $domElement: $element,
    setValue: setValue,
    getValue: getValue,
    getId: getId
  };
}
