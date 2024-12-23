import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trizy_app/components/app_bar_with_back_button.dart';
import 'package:trizy_app/components/checkout_section.dart';
import 'package:trizy_app/theme/colors.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBarWithBackButton(
        title: "Check Out",
          onBackClicked: (){
            context.pop();
          }
      ),
      
      body: const Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10),
        child: Column(
          children: [
            CheckoutSection(title: "Delivery Address", content: "Test address etc.est address etc.est address etc.est address etc.est address etc.", actionText: "Update",)
          ],
        ),
      ),


    );
  }
}
