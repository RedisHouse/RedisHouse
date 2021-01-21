class Pair<E, F> {
  E first;
  F last;
  Pair(this.first, this.last);

  @override
  String toString() {
    return "[$first, $last]";
  }
}