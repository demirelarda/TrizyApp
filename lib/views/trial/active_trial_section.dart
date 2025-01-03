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
    _activeTrialDetailsBloc.add(ActiveTrialDetailsRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _activeTrialDetailsBloc,
      child: BlocBuilder<ActiveTrialDetailsBloc, ActiveTrialDetailsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.isFailure) {
            late String errorMessage;
            if(state.errorMessage!.contains("404")){
              errorMessage = "You have no active trial.";
            }
            else{
              errorMessage = "An error occurred, please check your network connection";
            }
            return Center(
              child: Text(
                errorMessage,
                style: AppTextStyles.bodyText
              ),
            );
          }

          if (state.isSuccess && state.getActiveTrialResponse != null) {
            final trialDetail = state.getActiveTrialResponse!.trial;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ActiveTrialDetailsCard(trialDetail: trialDetail),
            );
          }

          return const Center(
            child: Text(
              "No active trial found.",
              style: TextStyle(color: gray),
            ),
          );
        },
      ),
    );
  }
}