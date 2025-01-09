import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trizy_app/bloc/trial/details/active_trial_details_bloc.dart';
import 'package:trizy_app/bloc/trial/details/active_trial_details_event.dart';
import 'package:trizy_app/bloc/trial/details/active_trial_details_state.dart';
import 'package:trizy_app/components/trial/active_trial_details_card.dart';
import 'package:trizy_app/theme/colors.dart';
import 'package:trizy_app/theme/text_styles.dart';

class ActiveTrialSection extends StatefulWidget {
  const ActiveTrialSection({super.key});

  @override
  State<ActiveTrialSection> createState() => _ActiveTrialSectionState();
}

class _ActiveTrialSectionState extends State<ActiveTrialSection> {
  late ActiveTrialDetailsBloc _activeTrialDetailsBloc;

  @override
  void initState() {
    super.initState();
    _activeTrialDetailsBloc = ActiveTrialDetailsBloc();
    _fetchActiveTrialDetails();
  }

  @override
  void dispose() {
    _activeTrialDetailsBloc.close();
    super.dispose();
  }

  void _fetchActiveTrialDetails() {
    _activeTrialDetailsBloc.add(const ActiveTrialDetailsRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _activeTrialDetailsBloc,
      child: BlocBuilder<ActiveTrialDetailsBloc, ActiveTrialDetailsState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state.isLoading)
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  else if (state.isFailure)
                    Center(
                      child: Text(
                        state.errorMessage!.contains("404")
                            ? "You have no active trial."
                            : "An error occurred, please check your network connection",
                        style: AppTextStyles.bodyText,
                      ),
                    )
                  else if (state.isSuccess && state.getActiveTrialResponse != null)
                      ActiveTrialDetailsCard(trialDetail: state.getActiveTrialResponse!.trial)
                    else
                      const Center(
                        child: Text(
                          "No active trial found.",
                          style: TextStyle(color: gray),
                        ),
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