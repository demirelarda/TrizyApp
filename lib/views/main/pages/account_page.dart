import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trizy_app/bloc/auth/sign_out/sign_out_bloc.dart';
import 'package:trizy_app/bloc/auth/sign_out/sign_out_event.dart';
import 'package:trizy_app/bloc/auth/sign_out/sign_out_state.dart';
import 'package:trizy_app/theme/colors.dart';
import '../../../components/basic_list_item.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late SignOutBloc _signOutBloc;

  @override
  void initState() {
    super.initState();
    _signOutBloc = SignOutBloc();
  }

  @override
  void dispose() {
    _signOutBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _signOutBloc,
      child: BlocConsumer<SignOutBloc, SignOutState>(
        listener: (context, state) {
          if (state.isSuccess) {
            context.goNamed("login");
          }

          if (state.isFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Sign out failed: ${state.errorMessage}"),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Scaffold(
            backgroundColor: white,
            appBar: AppBar(
              title: const Text("My Account"),
              centerTitle: true,
              backgroundColor: white,
              foregroundColor: Colors.black,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  BasicListItem(
                    text: "Profile",
                    onTap: () {
                      context.pushNamed('profile');
                    },
                  ),
                  BasicListItem(
                    text: "Addresses",
                    onTap: () {
                      context.pushNamed('myAddresses');
                    },
                  ),
                  BasicListItem(
                    text: "My Orders",
                    onTap: () {
                      context.pushNamed(
                        'myOrders',
                        pathParameters: {
                          'fromAccount': "1",
                        },
                      );
                    },
                  ),
                  BasicListItem(
                    text: "Trial History",
                    onTap: () {},
                  ),
                  BasicListItem(
                    text: "Favourite Products",
                    onTap: () {
                      context.pushNamed("favouriteProducts");
                    },
                  ),
                  BasicListItem(
                    text: "My Subscription",
                    onTap: () {
                      context.pushNamed('mySubscription');
                    },
                  ),
                  BasicListItem(
                    text: "Discount Codes",
                    onTap: () {
                      context.pushNamed('discountCodes');
                    },
                  ),
                  BasicListItem(
                    text: "Sign Out",
                    onTap: () {
                      _signOutBloc.add(const SignOutRequested());
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}