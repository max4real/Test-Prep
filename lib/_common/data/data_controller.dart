import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../_services/api_endpoint.dart';
import '../../models/m_onbording_model.dart';

class DataController extends GetxController {
  ValueNotifier<List<OnbordingModel>> onbordingList = ValueNotifier([]);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // initLoad();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> fetchOnboradingData() async {
    String url = ApiEndPoint.onbordingURL;

    GetConnect client = GetConnect(timeout: const Duration(seconds: 30));
    final response = await client.get(url);

    if (response.isOk) {
      List<OnbordingModel> temp = [];
      Iterable iterable = response.body;
      for (var element in iterable) {
        OnbordingModel rawData = OnbordingModel.fromAPI(data: element);
        temp.add(rawData);
      }
      onbordingList.value = [...temp];
      print(onbordingList.value.length);
    } else {
      mySuccessDialog("Something Went Wrong!", false, Colors.redAccent);
    }
  }

  Future<bool> getState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? spFirstTime = prefs.getBool('spFirstTime');

    if (spFirstTime != null) {
      return spFirstTime;
    } else {
      return true;
    }
  }

  Future<void> saveState({required bool isFirstTime}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('spFirstTime', isFirstTime);
  }
}

void dismissKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

String myFullDateTimeFormat(DateTime rawDate) {
  String formatDate = DateFormat("EEEE d MMM y  hh:mm a").format(rawDate);
  return formatDate;
}

String myDateFormat(DateTime rawDate) {
  String formatDate = DateFormat("MMMM dd h:mm a").format(rawDate);
  return formatDate;
}

String myTimeFormat(DateTime rawDate) {
  String formatDate = DateFormat("h:mm a").format(rawDate);
  return formatDate;
}

void maxSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

String formatNumber(dynamic data) {
  var formatter = NumberFormat('#,##0');
  return formatter.format(data);
}

String formatDateTimeForTile(DateTime dateTime) {
  final input = DateTime(dateTime.year, dateTime.month, dateTime.day);
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));

  if (input == today) {
    return 'Today ${DateFormat('hh:mm a').format(dateTime)}';
  } else if (input == yesterday) {
    return 'Yesterday ${DateFormat('hh:mm a').format(dateTime)}';
  } else {
    return DateFormat('MMM dd hh:mm a').format(dateTime);
  }
}

const Duration addDuration_630 = Duration(hours: 6, minutes: 30);

void myMessageLoadingDialog(String message) {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Center(
              child: CircularProgressIndicator(),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );
}

void myMessageDialog(String message) {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              // child: const Icon(
              //   Icons.info,
              //   color: Colors.white,
              //   size: 36,
              // ),
              child: const Center(
                child: Text(
                  '!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: true,
  );
}

void mySuccessDialog(String message, bool type_, Color color) {
  Get.dialog(
    Dialog(
      backgroundColor: const Color(0XFF262D39),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: type_
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 36,
                    )
                  : const Icon(
                      Icons.clear_rounded,
                      color: Colors.white,
                      size: 36,
                    ),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: true,
  );
}
