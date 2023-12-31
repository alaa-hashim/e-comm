import 'package:ecommerce_app/core/services/stripekeys.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Myservices extends GetxService {
  late SharedPreferences sharedpreferences;
  Future<Myservices> init() async {
    Firebase.initializeApp();
    sharedpreferences = await SharedPreferences.getInstance();
    Stripe.publishableKey = ApiKeys.pusblishableKey;
    return this;
  }

  storeUser(user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', user);
  }

  getuser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(
      'user',
    );
  }

  removeuser(user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(
      'user',
    );
  }

  initialServices() async {
    await Get.putAsync(() => Myservices().init());
  }
}
