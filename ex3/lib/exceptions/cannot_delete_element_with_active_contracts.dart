class CannotDeleteElementWithActiveContracts implements Exception {
  final String _resource;
  final String _item;

  CannotDeleteElementWithActiveContracts(this._resource, this._item);

  String errorMessage() =>
      'Cannot delete item -$_item- because there are active contracts on $_resource.';
}
