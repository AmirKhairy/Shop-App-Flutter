import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Data_Models/get_carts_model/cart_item.dart';
import 'package:shop_app/Shared/components.dart';
import 'package:shop_app/Shared/constants.dart';
import 'package:shop_app/Shop_Layout/Cart_Page/thank_you_screen.dart';
import 'package:shop_app/Shop_Layout/HomeCubit/home_bloc.dart';
import 'package:shop_app/Shop_Layout/HomeCubit/home_states.dart';
import 'package:shop_app/Shop_Layout/Home_Page/product_details_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeStates>(
      listener: (context, state) {
        if (state is AddOrDeleteItemInCartSuccessState) {
          showToast(
              msg: HomeBloc.get(context)
                  .addOrRemoveProductInCartWithProductIdmodel!
                  .message!,
              color: Colors.green);
        }
        if (state is AddOrDeleteItemInCartErrorState) {
          showToast(
              msg: HomeBloc.get(context)
                  .addOrRemoveProductInCartWithProductIdmodel!
                  .message!,
              color: Colors.red);
        }
        if (state is EditItemQuantitySuccessState) {
          showToast(msg: 'Quantity Updated Successfully', color: Colors.green);
        }
        if (state is EditItemQuantityErrorState) {
          showToast(msg: 'Error Updating Quantity', color: Colors.green);
        }
        if (state is CardPaymentSuccessState) {
          showToast(msg: 'Payment Done Successfully', color: Colors.green);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>  const ThankYouScreen(),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Your Cart',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: 25,
                  ),
            ),
          ),
          body: ConditionalBuilder(
            condition: !(state is GetCartsLoadingState ||
                state is EditItemQuantityLoadingState),
            builder: (context) => HomeBloc.get(context)
                        .getCartsModel
                        ?.data
                        ?.cartItems
                        ?.length !=
                    0
                ? Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => cartItemBuilder(
                              HomeBloc.get(context)
                                  .getCartsModel!
                                  .data!
                                  .cartItems![index],
                              context),
                          separatorBuilder: (context, index) =>
                              verticalSeperatorBuilder(
                            height: 2,
                            color: Colors.white,
                          ),
                          itemCount: HomeBloc.get(context)
                              .getCartsModel!
                              .data!
                              .cartItems!
                              .length,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          height: 50,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              'Total: ${HomeBloc.get(context).getCartsModel!.data!.total} \$',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          int? amount = HomeBloc.get(context)
                                  .getCartsModel!
                                  .data!
                                  .total! *
                              100;
                          if (amount > 0) {
                            HomeBloc.get(context).makePayment(
                              amount: amount.toString(),
                            );
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 10,
                            left: 20,
                            right: 20,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: defualLightColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            height: 50,
                            width: double.infinity,
                            child: Center(
                              child: state is CardPaymentLoadingState
                                  ? const CircularProgressIndicator(
                                      color: Colors.orange,
                                    )
                                  : const Text(
                                      'Purchase',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Text(
                      'No Items In Cart',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
            fallback: (context) => Center(
              child: CircularProgressIndicator(
                color: defualLightColor,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget cartItemBuilder(CartItem model, context) => InkWell(
        onTap: () {
          HomeBloc.get(context)
              .getProductDetails(productId: model.product!.id!);
          navigatorTo(
              context: context, pageRoute: const ProductDetailsScreen());
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  CachedNetworkImage(
                    imageUrl: model.product!.image!,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                        color: defualLightColor,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  if (model.product!.discount != 0)
                    Container(
                      color: Colors.red,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          'DISCOUNT',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: SizedBox(
                  height: 113,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.product!.name!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            '${model.product!.price}\$',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color: Colors.red,
                                ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          if (model.product!.discount != 0)
                            Text(
                              '${model.product!.oldPrice}\$',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey,
                                  ),
                            ),
                          const Spacer(),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Quantity: ',
                          ),
                          Text('${model.quantity}'),
                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              size: 20,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  final quantityController =
                                      TextEditingController(
                                          text: model.quantity.toString());

                                  return AlertDialog(
                                    title: const Text('Enter new quantity'),
                                    content: TextField(
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.black),
                                      controller: quantityController,
                                      keyboardType: TextInputType.number,
                                    ),
                                    actions: [
                                      TextButton(
                                        child: const Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: const Text('Save'),
                                        onPressed: () {
                                          // Get the new quantity from the text field
                                          final newQuantity = int.parse(
                                              quantityController.text);

                                          HomeBloc.get(context)
                                              .increaseItemQuantity(
                                            id: model.id!,
                                            quantity: newQuantity,
                                          );

                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              HomeBloc.get(context).addOrDeleteItemInCart(
                                productId: model.product!.id!,
                              );
                            },
                            icon: const Icon(
                              Icons.delete,
                              size: 20,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
