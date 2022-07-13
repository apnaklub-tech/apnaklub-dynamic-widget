import 'assert_constants.dart';

class TypeAssertions {
  String widgetName;

  TypeAssertions(this.widgetName);

  /// convert a string to be logged in red color
  String toWarning(String s) {
    return '\x1B[31m$s\x1B[0m';
  }

  /// Assert type check of values of [map] at current level
  /// runs assertions on given [map].
  /// [attribute] is key of [map] on which assertion has to be performed
  /// [expectedType] is expected runtime type
  /// [allowNull] should allow null for this [attribute]
  void typeAssertionDriver(
      {required Map<String, dynamic> map,
      required String attribute,
      required String expectedType,
      bool allowNull = true}) {
    if (!allowNull && map[attribute] == null) {
      assert(
          false,
          toWarning(
              "${widgetName}WidgetParser: For $attribute null is not allowed"));
      return;
    }

    String msg =
        "${widgetName}WidgetParser: Expecting $attribute as type of $expectedType but found ${map[attribute].runtimeType}";
    bool condition = true;

    switch (expectedType) {
      case TYPE_STRING:
        condition = map[attribute] == null || map[attribute] is String;
        break;
      case TYPE_MAP:
        condition = map[attribute] == null || map[attribute] is Map;
        break;
      case TYPE_INT:
        condition = map[attribute] == null || map[attribute] is int;
        break;
      case TYPE_DOUBLE:
        condition = map[attribute] == null || map[attribute] is double;
        break;
      case TYPE_STRINGED_MAP:
        condition = map[attribute] == null || map[attribute] is String || map[attribute] is Map;
        break;
    }
    assert(condition, toWarning(msg));
  }
}
