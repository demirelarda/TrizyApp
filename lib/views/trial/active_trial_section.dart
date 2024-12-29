import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trizy_app/bloc/trial/details/active_trial_details_bloc.dart';
import 'package:trizy_app/bloc/trial/details/active_trial_details_event.dart';
import 'package:trizy_app/bloc/trial/details/active_trial_details_state.dart';
import 'package:trizy_app/components/trial/active_trial_details_card.dart';
import 'package:trizy_app/theme/colors.dart';

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
            return Center(
              child: Text(
                "Error: ${state.errorMessage}",
                style: const TextStyle(color: Colors.red),
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