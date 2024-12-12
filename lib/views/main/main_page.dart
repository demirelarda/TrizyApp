import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trizy_app/components/buttons/custom_button.dart';
import 'package:trizy_app/theme/colors.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          Center(
            child: Column(
              children: [
                const Text("Main Page"),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child:CustomButton(text: "Sign Out", textColor: white, color: primaryLightColor, onClick: (){
                    context.goNamed("login");
                  })
                ),
              ],
            )
          ),
          const Spacer()
        ],
      ),
    );
  }
}
