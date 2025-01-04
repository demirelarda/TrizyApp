import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trizy_app/bloc/profile/user_profile_bloc.dart';
import 'package:trizy_app/bloc/profile/user_profile_event.dart';
import 'package:trizy_app/bloc/profile/user_profile_state.dart';
import 'package:trizy_app/components/app_bar_with_back_button.dart';
import 'package:trizy_app/components/buttons/custom_button.dart';

import '../../theme/colors.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  late UserProfileBloc _userProfileBloc;

  @override
  void initState() {
    super.initState();
    _userProfileBloc = UserProfileBloc();
    _userProfileBloc.add(UserProfileRequested());
  }

  @override
  void dispose() {
    _userProfileBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _userProfileBloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWithBackButton(
          onBackClicked: () {
            context.pop();
          },
          title: "My Profile",
        ),
        body: BlocBuilder<UserProfileBloc, UserProfileState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.isFailure) {
              return Center(
                child: Text(
                  state.errorMessage ?? "Failed to load profile.",
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else if (state.isSuccess && state.userProfileResponse != null) {
              final user = state.userProfileResponse!.data;

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 16),

                      const CircleAvatar(
                        radius: 50,
                        backgroundImage:
                        AssetImage('assets/images/profileholder.png'),
                      ),
                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${user.userFirstName} ${user.userLastName}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          if (user.hasActiveSubscription) ...[
                            const SizedBox(width: 8),
                            Image.asset(
                              'assets/images/trizyprologo.png',
                              height: 20,
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 8),

                      Text(
                        user.email,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 24),

                      if (!user.hasActiveSubscription) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: CustomButton(
                            text: "Subscribe Now!",
                            textColor: Colors.white,
                            color: primaryLightColor,
                            onClick: () {
                              context.pushNamed("subscriptionPromotionPage");
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }

            return const Center(
              child: Text(
                "No profile data available.",
                style: TextStyle(fontSize: 16),
              ),
            );
          },
        ),
      ),
    );
  }
}