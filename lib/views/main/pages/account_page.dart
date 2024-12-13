import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Spacer(),
          Center(
              child: Column(
                children: [
                  Text("Account Page"),
                ],
              )
          ),
          Spacer()
        ],
      ),
    );
  }
}
