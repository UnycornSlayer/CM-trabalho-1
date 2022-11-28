class DoesntExistOnListException implements Exception {
  final String _resource;
  final String _item;

  DoesntExistOnListException(this._resource, this._item);

  String errorMessage() =>
      'Item with ID -$_item- does not exists on $_resource.';
}
