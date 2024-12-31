import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../../bloc/deals/deals_bloc.dart';
import '../../../../bloc/deals/deals_event.dart';
import '../../../../bloc/deals/deals_state.dart';
import '../../../../components/deal_holder_card.dart';

class DealsSection extends StatelessWidget {
  const DealsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DealsBloc()..add(DealsRequested()),
      child: BlocBuilder<DealsBloc, DealsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.isFailure) {
            return Center(
              child: Text(
                'Failed to load deals: ${state.errorMessage}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (state.isSuccess && state.deals != null) {
            final deals = state.deals!.deals;
            deals.sort((a, b) => a.dealOrder.compareTo(b.dealOrder));

            return MasonryGridView.count(
              padding: const EdgeInsets.all(8.0),
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              itemCount: deals.length,
              itemBuilder: (context, index) {
                final deal = deals[index];
                final aspectRatio = _calculateAspectRatio(deal.aspectRatio);
                return DealHolderCard(
                  imageUrl: deal.imageUrl,
                  aspectRatio: aspectRatio,
                );
              },
            );
          } else {
            return const Center(child: Text('No deals available.'));
          }
        },
      ),
    );
  }

  double _calculateAspectRatio(String aspectRatio) {
    final parts = aspectRatio.split(':');
    if (parts.length == 2) {
      final width = double.tryParse(parts[0]) ?? 1;
      final height = double.tryParse(parts[1]) ?? 1;
      return width / height;
    }
    return 1;
  }
}