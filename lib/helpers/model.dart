class Model {
  String _number;
  int _place;
  int _order;

  // getters
  String get number => _number;
  String get place => _place.toString();
  String get order => _order.toString();

  Model({String number, int place, int order}) {
    _number = number;
    _place = place;
    _order = order;
  }
}
