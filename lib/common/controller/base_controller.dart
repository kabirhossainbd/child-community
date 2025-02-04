
import 'package:child_community/helper/ui_helper/dialog_helper.dart';

class BaseController {
  showLoading([String? message]) {
    DialogHelper.showLoading(message);
  }
  hideLoading() {
    DialogHelper.hideLoading();
  }
}
