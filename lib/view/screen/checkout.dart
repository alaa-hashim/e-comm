import 'package:ecommerce_app/controller/checkoutcontroller.dart';
import 'package:ecommerce_app/core/constant/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../widget/chechout/address.dart';
import '../widget/chechout/bottombar.dart';
import '../widget/chechout/paymentmethod.dart';
import '../widget/chechout/subtotal.dart';

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CheckoutController());
    return GetBuilder<CheckoutController>(
      builder: (controller) => Scaffold(
        bottomNavigationBar: controller.paymentmetheod != null
            ? const Checkoutbottom()
            : const Uncheckoutbottom(),
        backgroundColor: AppColor.bg,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColor.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          backgroundColor: AppColor.white,
          title: const Center(
            child: Text(
              "Checkout",
              style: TextStyle(color: AppColor.black),
            ),
          ),
        ),
        body: GetBuilder<CheckoutController>(
          builder: (controller) => ListView(children: [
            ...List.generate(
                controller.data.length,
                (index) => InkWell(
                      onTap: () {
                        controller
                            .choiceaddress(controller.data[index].addressId);
                      },
                      child: Checkoutaddress(
                        icon: Icons.abc_outlined,
                        isActive: controller.defalutAddress ==
                                controller.data[index].addressId
                            ? true
                            : false,
                        tital: controller.data[index].addressName +
                            controller.data[index].city,
                      ),
                    )),
            InkWell(
              onTap: () {
                controller.choicepaymentmethod("cash");
              },
              child: Paymentmethod(
                isActive: controller.paymentmetheod == "cash" ? true : false,
                icon: FontAwesomeIcons.moneyBill,
                tital: 'Cash on delivery',
              ),
            ),
            InkWell(
              onTap: () {
                controller.choicepaymentmethod("card");
              },
              child: Paymentmethod(
                icon: FontAwesomeIcons.creditCard,
                isActive: controller.paymentmetheod == "card" ? true : false,
                tital: 'Debit/Credit Card',
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Checkoutsubtotal(),
            ),
          ]),
        ),
      ),
    );
  }
}
