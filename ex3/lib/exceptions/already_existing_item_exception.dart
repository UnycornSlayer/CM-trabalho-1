class AlreadyExistingItemException implements Exception {
  final String _resource;
  final String _item;

  AlreadyExistingItemException(this._resource, this._item);

  String errorMessage() =>
      'Item with ID -$_item- already exists on $_resource.';
}
