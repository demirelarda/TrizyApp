import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trizy_app/bloc/cart/get/get_cart_bloc.dart';
import 'package:trizy_app/bloc/cart/get/get_cart_event.dart';
import 'package:trizy_app/bloc/cart/get/get_cart_state.dart';
import 'package:trizy_app/components/cart_top_bar.dart';
import 'package:trizy_app/models/cart/response/get_cart_response.dart';
import '../../../bloc/cart/operations/cart_operation_bloc.dart';
import '../../../bloc/cart/operations/cart_operation_event.dart';
import '../../../bloc/cart/operations/cart_operation_state.dart';
import '../../../components/cart_details_secion.dart';
import '../../../components/cart_item_card.dart';
import '../../../models/cart/cart.dart';
import '../../../models/cart/request/add_item_to_cart_request.dart';


class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Bloc to fetch the cart
        BlocProvider<GetCartBloc>(
          create: (context) => GetCartBloc()..add(UserCartRequested()),
        ),
        // Bloc to perform add/remove/decrement operations
        BlocProvider<CartOperationBloc>(
          create: (context) => CartOperationBloc(),
        ),
      ],
      child: const CartPageContent(),
    );
  }
}

class CartPageContent extends StatelessWidget {
  const CartPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: BlocBuilder<GetCartBloc, GetCartState>(
          builder: (context, state) {
            if (state.isLoading) {
              return CartTopBar(
                subtotalAmount: 0.0,
                itemCount: 0,
                onMenuClicked: () {},
              );
            }

            if (state.isFailure || state.cartResponse == null) {
              return CartTopBar(
                subtotalAmount: 0.0,
                itemCount: 0,
                onMenuClicked: () {},
              );
            }

            final cartItems = state.cartResponse!.cart.items;
            final subtotal = cartItems.fold<double>(
              0.0, (sum, item) => sum + (item.price * item.quantity),
            );
            final itemCount = cartItems.fold<int>(
              0, (count, item) => count + item.quantity,
            );

            return CartTopBar(
              subtotalAmount: subtotal,
              itemCount: itemCount,
              onMenuClicked: () {},
            );
          },
        ),
      ),
      body: BlocListener<CartOperationBloc, CartOperationState>(
        listener: (context, cartOpState) {
          // If an operation is successful re-fetch the cart
          // Use the updated cart from cartOperationResponse
          if (cartOpState.isSuccess && cartOpState.cartOperationResponse != null) {
            context.read<GetCartBloc>().add(
              LocalCartUpdated(cartOpState.cartOperationResponse!.cart),
            );
          }

          if (cartOpState.isFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${cartOpState.errorMessage}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<GetCartBloc, GetCartState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.isFailure) {
              return Center(child: Text('Error: ${state.errorMessage}'));
            }

            if (state.isSuccess && state.cartResponse != null) {
              final GetCartResponse cartResponse = state.cartResponse!;
              final cartItems = cartResponse.cart.items;
              final subtotal = cartItems.fold<double>(
                0.0,
                    (sum, item) => sum + (item.price * item.quantity),
              );

              // example delivery fee
              const deliveryFee = 35.0;

              return Stack(
                children: [
                  Positioned.fill(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.only(bottom: 120),
                            itemCount: cartItems.length,
                            itemBuilder: (context, index) {
                              final item = cartItems[index];

                              return _buildCartItem(
                                context: context,
                                item: item,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  //anchored CartDetailsSection
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: CartDetailsSection(
                      subTotalPrice: subtotal,
                      deliveryFee: deliveryFee,
                      onCheckOutClicked: () {
                        debugPrint('Checkout button clicked!');
                      },
                    ),
                  ),
                ],
              );
            }

            return const Center(child: Text('Your cart is empty.'));
          },
        ),
      ),
    );
  }

  //Function to build each cart item row (CartItemCard).
  Widget _buildCartItem({
    required BuildContext context,
    required CartItem item,
  }) {
    return BlocBuilder<CartOperationBloc, CartOperationState>(
      builder: (context, cartOpState) {
        // Determine loading states for this specific item
        final bool isMinusLoading = cartOpState.isLoading &&
            cartOpState.currentProductId == item.productId &&
            cartOpState.currentOperation == CartOperation.decrement;

        final bool isPlusLoading = cartOpState.isLoading &&
            cartOpState.currentProductId == item.productId &&
            cartOpState.currentOperation == CartOperation.increment;

        final bool isRemoveLoading = cartOpState.isLoading &&
            cartOpState.currentProductId == item.productId &&
            cartOpState.currentOperation == CartOperation.remove;

        return CartItemCard(
          productImageUrl:
          item.imageURL ?? '',
          productTitle: item.title,
          productPrice: '\$${item.price.toStringAsFixed(2)}',
          quantity: item.quantity,
          onMinusClicked: () {
            // Decrement quantity
            if (!isMinusLoading && item.quantity > 0) {
              context.read<CartOperationBloc>().add(
                DecrementQuantityEvent(productId: item.productId),
              );
            }
          },
          onPlusClicked: () {
            // Increment quantity by 1
            if (!isPlusLoading) {
              context.read<CartOperationBloc>().add(
                AddItemEvent(
                  request: AddItemToCartRequest(
                    productId: item.productId,
                    quantity: 1,
                  ),
                ),
              );
            }
          },
          onRemoveClicked: () {
            // Remove the item completely
            if (!isRemoveLoading) {
              context.read<CartOperationBloc>().add(
                DeleteItemEvent(productId: item.productId),
              );
            }
          },
          isMinusLoading: isMinusLoading,
          isPlusLoading: isPlusLoading,
          isRemoveLoading: isRemoveLoading,
        );
      },
    );
  }
}