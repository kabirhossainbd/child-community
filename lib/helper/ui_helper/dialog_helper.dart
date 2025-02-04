import 'package:child_community/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class DialogHelper {
  //show error dialog
  static void showErrorDialog({String title = 'Error', String? description = 'Something went wrong'}) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Get.textTheme.bodyLarge,
              ),
              Text(
                description ?? '',
                style: Get.textTheme.displayMedium,
              ),
              ElevatedButton(
                onPressed: () {
                  if (Get.isDialogOpen!) Get.back();
                },
                child: const Text('Okay'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //show toast
  //show snack bar
  //show loading
  static void showLoading([String? message]) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 15),
              Text(message ?? 'Loading...'),
            ],
          ),
        ),
      ),
    );
  }

  //hide loading
  static void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }

  static void showNoInternetDialog(){
    Get.dialog( AlertDialog(
      alignment: Alignment.center,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        Padding(
            padding: const EdgeInsets.only(right: 50, bottom: 16, left: 20),
            child: Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  onTap: (){
                    Get.back();
                  },
                  child: Text('Ok',
                    style: interRegular.copyWith(
                        fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  )
              ),
            )
        )
      ],
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
      title: RichText(
        text:  TextSpan(text: 'Unable to log in'.tr, style: interMedium.copyWith(
            fontSize: 20)),
      ),
      content: Text('An unexpected error occurred.Please try logging in again.'.tr,  style: interRegular.copyWith(color: Colors.grey, fontSize: 16),),
    ));
  }
}
