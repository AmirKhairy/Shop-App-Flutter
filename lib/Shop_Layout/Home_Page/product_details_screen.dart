import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Shared/constants.dart';
import 'package:shop_app/Shop_Layout/HomeCubit/home_bloc.dart';
import 'package:shop_app/Shop_Layout/HomeCubit/home_states.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var productDetailsModel = HomeBloc.get(context).productDetailsModel;

        if (productDetailsModel == null ||
            productDetailsModel.data == null ||
            productDetailsModel.data!.images == null ||
            state is GetProductDetailsLoadingState) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              productDetailsModel.data!.name ?? 'Product',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  if (productDetailsModel.data?.id != null) {
                    HomeBloc.get(context)
                        .changeFavoriteItem(productDetailsModel.data!.id!);
                  }
                },
                icon: (productDetailsModel.data?.id != null &&
                        HomeBloc.get(context)
                                .favorites[productDetailsModel.data!.id] ==
                            true)
                    ? const Icon(
                        Icons.favorite,
                        size: 20,
                        color: Colors.red,
                      )
                    : const Icon(
                        Icons.favorite_outline,
                        size: 20,
                      ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: CarouselSlider(
                          items: productDetailsModel.data!.images!
                              .map(
                                (imageUrl) => CachedNetworkImage(
                                  imageUrl: imageUrl,
                                  width: width(context),
                                  
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(
                                      color: defualLightColor,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                ),
                              )
                              .toList(),
                          options: CarouselOptions(
                            height: 200,
                            initialPage: 0,
                            viewportFraction: 1.0,
                            autoPlay: false,
                            scrollDirection: Axis.horizontal,
                            reverse: false,
                            enableInfiniteScroll: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                const Duration(seconds: 1),
                            autoPlayCurve: Curves.linear,
                          ),
                        ),
                      ),
                      if (productDetailsModel.data?.discount != 0)
                        Container(
                          color: Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              '${productDetailsModel.data?.discount}% DISCOUNT',
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.white),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Text(
                        'Price : ',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(fontSize: 15),
                      ),
                      Text(
                        '${productDetailsModel.data!.price}\$',
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: Colors.red,
                                ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      if (productDetailsModel.data!.discount != 0)
                        Text(
                          '${productDetailsModel.data!.oldPrice}\$',
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey,
                                  ),
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Details',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      HomeBloc.get(context).changeReadMore();
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          HomeBloc.get(context).readMore
                              ? productDetailsModel.data!.description!
                              : (productDetailsModel.data!.description!.length >
                                      100
                                  ? '${productDetailsModel.data!.description!.substring(0, 100)}...'
                                  : productDetailsModel.data!.description!),
                          style: const TextStyle(height: 1.5),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          HomeBloc.get(context).readMore
                              ? 'Show Less'
                              : 'Read More',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
