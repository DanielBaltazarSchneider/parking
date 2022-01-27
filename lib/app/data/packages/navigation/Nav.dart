import 'package:get/get.dart';

class Nav {
  static Future<dynamic> to(dynamic page, context) async {
    return await Get.to(page);
    // return await Navigator.push(
    //   context,
    //   PageRouteBuilder(
    //     pageBuilder: (c, a1, a2) => page,
    //     transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
    //     transitionDuration: const Duration(milliseconds: 500),
    //   ),
    // );
  }

  static Future<dynamic> off({dynamic page, context}) async {
    return await Get.off(page);
    // return Navigator.of(context).pushAndRemoveUntil(
    //     PageRouteBuilder(
    //       pageBuilder: (c, a1, a2) => page,
    //       transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
    //       transitionDuration: const Duration(milliseconds: 500),
    //     ),
    //     (Route<dynamic> route) => false);
  }

  static Future<dynamic> offAll({dynamic page, context}) async {
    return await Get.offAll(page);
    // return Navigator.pushAndRemoveUntil(
    //   context,
    //   PageRouteBuilder(
    //     pageBuilder: (c, a1, a2) => page,
    //     transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
    //     transitionDuration: const Duration(milliseconds: 500),
    //   ),
    //   (route) => false,
    // );
  }

  static void back({dynamic result, context}) {
    return Get.back(result: result);
    // return Navigator.pop(context, result);
  }
}
