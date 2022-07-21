import 'package:dynamic_widget/utils/widget_model.dart';
import 'package:logging/logging.dart';

abstract class ClickListener {
  void onClicked(int? event);
}


class EventListener {
  ClickListener? clickListener;
  Function(String, String)? onTextChange;
  Map<int, WidgetModel> controller;

  EventListener(
      {Map<int, WidgetModel>? controller,
        Function(String, String)? onTextChange})
      : this.controller = controller ?? {} {
    this.onTextChange = onTextChange ?? f;
  }

  void f(String s, String v) {}
}


class NonResponseWidgetClickListener implements ClickListener {
  static final Logger log = Logger('NonResponseWidgetClickListener');

  @override
  void onClicked(int? event) {
    log.info("receiver click event: $event");
    print("receiver click event: $event");
  }
}