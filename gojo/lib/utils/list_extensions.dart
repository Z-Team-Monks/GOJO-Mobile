extension ListExtensions<T> on List<T> {
  /// Returns a new list containing the items at the specified indices.
  ///
  /// Example:
  /// ```
  /// final list = ['a', 'b', 'c', 'd'];
  /// final indices = [0, 2];
  /// final result = list.getItemsAtIndices(indices); // returns ['a', 'c']
  /// ```
  List<T> getItemsAtIndices(List<int> indices) {
    return indices.map((i) => this[i]).toList();
  }

  /// Returns a list of indices of the selected items in the list.
  ///
  /// Example:
  /// ```
  /// final list = ['a', 'b', 'c', 'd'];
  /// final selectedItems = ['a', 'c'];
  /// final result = list.getSelectedIndices(selectedItems); // returns [0, 2]
  /// ```
  List<int> getSelectedIndices(List<T> selectedItems) {
    return List.generate(
            selectedItems.length, (index) => this.indexOf(selectedItems[index]))
        .where((index) => index >= 0)
        .toList();
  }

  /// Returns a list of indices of the items that are not selected in the list.
  ///
  /// Example:
  /// ```
  /// final list = ['a', 'b', 'c', 'd'];
  /// final selectedItems = ['a', 'c'];
  /// final result = list.getNotSelectedIndices(selectedItems); // returns [1, 3]
  /// ```
  List<int> getNotSelectedIndices(List<T> selectedItems) {
    return List.generate(this.length,
            (index) => selectedItems.contains(this[index]) ? -1 : index)
        .where((index) => index != -1)
        .toList();
  }
}
