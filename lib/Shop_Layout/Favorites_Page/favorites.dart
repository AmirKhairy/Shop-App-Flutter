import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Shared/components.dart';
import 'package:shop_app/Shared/constants.dart';
import 'package:shop_app/Shop_Layout/HomeCubit/home_bloc.dart';
import 'package:shop_app/Shop_Layout/HomeCubit/home_states.dart';
import 'package:shop_app/Data_Models/get_favorites_model.dart';
import 'package:shop_app/Shop_Layout/Home_Page/product_details_screen.dart';

class Favorites extends StatelessWidget {
  Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) => ConditionalBuilder(
        condition: state is! FavoritesLoadingDataState,
        builder: (context) =>
            HomeBloc.get(context).favoritesModel?.data?.data?.length != 0
                ? ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => favoriteItemBuilder(
                      HomeBloc.get(context).favoritesModel!.data!.data![index],
                      context,
                    ),
                    separatorBuilder: (context, index) =>
                        verticalSeperatorBuilder(
                      height: 2,
                      color: Colors.white,
                    ),
                    itemCount: HomeBloc.get(context)
                            .favoritesModel
                            ?.data
                            ?.data
                            ?.length ??
                        0,
                  )
                : Center(
                    child: Text(
                      'No Favorites',
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
  }

  Widget favoriteItemBuilder(GetFavoritesData2 model, context) => InkWell(
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
                  height: 100,
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
                          IconButton(
                            onPressed: () {
                              HomeBloc.get(context)
                                  .changeFavoriteItem(model.product!.id!);
                            },
                            icon: HomeBloc.get(context)
                                    .favorites[model.product!.id]!
                                ? const Icon(
                                    Icons.favorite,
                                    size: 20,
                                    color: Colors.red,
                                  )
                                : const Icon(
                                    Icons.favorite_outline,
                                    size: 20,
                                    color: Colors.black,
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
