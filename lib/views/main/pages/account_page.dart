import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          Center(
            child: TextButton(
                onPressed: (){
                  context.pushNamed("myAddresses");
                },
                child: const Text("Addresses")
            ),
          ),
          const Spacer()
        ],
      ),
    );
  }
}
