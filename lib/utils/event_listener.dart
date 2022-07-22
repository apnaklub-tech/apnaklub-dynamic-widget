import 'package:dynamic_widget/utils/widget_model.dart';
import 'package:logging/logging.dart';

abstract class ClickListener {
  void onClicked(String? event);
}


class EventListener {
  ClickListener? clickListener;
  Function(String, String)? onTextChange;
  Map<String, WidgetModel> controller;

  EventListener(
      {Map<String, WidgetModel>? controller,
        Function(String, String)? onTextChange})
      : controller = controller ?? {} {
    this.onTextChange = onTextChange ?? f;
  }

  void f(String s, String v) {}
}


class NonResponseWidgetClickListener implements ClickListener {
  static final Logger log = Logger('NonResponseWidgetClickListener');

  @override
  void onClicked(String? event) {
    log.info('receiver click event: $event');
    print('receiver click event: $event');
  }
}