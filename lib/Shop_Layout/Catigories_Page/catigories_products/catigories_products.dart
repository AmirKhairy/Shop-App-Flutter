import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Data_Models/catigory_products_model.dart';
import 'package:shop_app/Shared/components.dart';
import 'package:shop_app/Shared/constants.dart';
import 'package:shop_app/Shop_Layout/HomeCubit/home_bloc.dart';
import 'package:shop_app/Shop_Layout/HomeCubit/home_states.dart';
import 'package:shop_app/Shop_Layout/Home_Page/product_details_screen.dart';

class Catigoriesproducts extends StatelessWidget {
  final String catigoryName;
  const Catigoriesproducts({
    super.key,
    required this.catigoryName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var categoryModel = HomeBloc.get(context).catigoriesproductsModel;

        if (categoryModel == null ||
            categoryModel.data == null ||
            categoryModel.data!.data == null ||
            state is GetCategoriesProductsLoadingState) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                catigoryName.toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(fontSize: 25),
              ),
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              catigoryName.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .displayLarge
                  ?.copyWith(fontSize: 25),
            ),
          ),
          body: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => catigoriesProductsBuilder(
              categoryModel.data!.data![index],
              context,
            ),
            separatorBuilder: (context, index) => verticalSeperatorBuilder(
              height: 2,
              color: Colors.white,
            ),
            itemCount: categoryModel.data!.data!.length,
          ),
        );
      },
    );
  }

  Widget catigoriesProductsBuilder(CategoryProductsDataData model, context) =>
      InkWell(
        onTap: () {
          HomeBloc.get(context).getProductDetails(productId: model.id!);
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
                    imageUrl: model.image ?? '',
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                        color: defualLightColor,
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                    ),
                  ),
                  if (model.discount != null && model.discount != 0)
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
                        model.name ?? 'No Name',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            '${model.price ?? 0}\$',
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
                          if (model.discount != null && model.discount != 0)
                            Text(
                              '${model.oldPrice ?? 0}\$',
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
                                  .changeFavoriteItem(model.id!);
                            },
                            icon: HomeBloc.get(context).favorites[model.id] ==
                                    true
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
