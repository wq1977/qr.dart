class Grouping<K extends Hashable, V> {
  final HashMap<K, List<V>> _values;

  Grouping._internal(this._values);

  factory Grouping(Iterable<V> source, Func1<V, K> keyFunc) {
    var map = new HashMap<K, List<V>>();

    for (final V value in source) {
      K key = keyFunc(value);
      List<V> values = map.putIfAbsent(key, () => new List<V>());
      values.add(value);
    }

    return new Grouping._internal(map);
  }

  factory Grouping.from(Iterable<V> source) {
    Func1<V, K> identFunc = (v) => v;
    return new Grouping(source, identFunc);
  }

  /**
   * Returns whether this map contains the given [key].
   */
  bool containsKey(K key) => _values.containsKey(key);

  /**
   * Returns the value for the given [key] or null if [key] is not
   * in the map. Because null values are supported, one should either
   * use containsKey to distinguish between an absent key and a null
   * value, or use the [putIfAbsent] method.
   */
  List<V> operator [](K key) => _values[key];

  /**
   * Applies [f] to each {key, value} pair of the map.
   */
  void forEach(void f(K key, List<V> value)) => _values.forEach(f);

  /**
   * Returns a collection containing all the keys in the map.
   */
  Collection<K> getKeys() => _values.getKeys();

  /**
   * The number of {key, value} pairs in the map.
   */
  int get length() => _values.length;

  /**
   * Returns true if there is no {key, value} pair in the map.
   */
  bool get isEmpty() => _values.isEmpty();
}
