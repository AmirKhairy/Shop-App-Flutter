import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Shared/components.dart';
import 'package:shop_app/Shared/constants.dart';
import 'package:shop_app/Shop_Layout/Catigories_Page/catigories_products/catigories_products.dart';
import 'package:shop_app/Shop_Layout/HomeCubit/home_bloc.dart';
import 'package:shop_app/Shop_Layout/HomeCubit/home_states.dart';
import 'package:shop_app/Data_Models/catigories_model.dart';
import 'package:shop_app/Data_Models/home_model.dart';
import 'package:shop_app/Shop_Layout/Home_Page/product_details_screen.dart';

class Products extends StatelessWidget {
  const Products({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: HomeBloc.get(context).homeModel != null,
          builder: (context) => productsBuilder(
            context,
            HomeBloc.get(context).homeModel!,
            HomeBloc.get(context).catigoriesModel,
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator(
              color: defualLightColor,
            ),
          ),
        );
      },
    );
  }

  Widget productsBuilder(
    context,
    HomeModel model,
    CatigoriesModel? catigoriesModel,
  ) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 200.0,
              child: CarouselSlider(
                items: model.data?.banners
                    .map(
                      (e) => CachedNetworkImage(
                        imageUrl: e.image!,
                        width: 300,
                        height: width(context),
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                            color: defualLightColor,
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  height: 200,
                  initialPage: 0,
                  viewportFraction: 0.8,
                  autoPlay: true,
                  scrollDirection: Axis.horizontal,
                  reverse: false,
                  enableInfiniteScroll: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlayCurve: Curves.linear,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Catigories',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 120,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => catigoriesItemBuilder(
                          catigoriesModel!.data.data[index], context),
                      separatorBuilder: (context, index) =>
                          horizentalSeperatorBuilder(
                        width: 3,
                        color: Colors.white,
                      ),
                      itemCount: HomeBloc.get(context)
                          .catigoriesModel!
                          .data
                          .data
                          .length,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'New Products',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ],
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                return GridView.count(
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                  childAspectRatio:
                      (constraints.maxWidth / 2) / (height(context) * .28),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  children: List.generate(
                    model.data!.products.length,
                    (index) =>
                        buildGridProduct(context, model.data!.products[index]),
                  ),
                );
              },
            ),
          ],
        ),
      );

  Widget buildGridProduct(context, ProductsModel model) => InkWell(
        onTap: () {
          HomeBloc.get(context).getProductDetails(productId: model.id!);
          navigatorTo(
              context: context, pageRoute: const ProductDetailsScreen());
        },
        child: Container(
          color: Theme.of(context).cardColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  CachedNetworkImage(
                    imageUrl: model.image!,
                    width: width(context),
                    height: height(context) * .1,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                        color: defualLightColor,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  if (model.discount != 0)
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(
                      width: width(context) * .5,
                      child: Row(
                        children: [
                          Text(
                            '${model.price}\$',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                  color: Colors.red,
                                ),
                          ),
                          const SizedBox(width: 5),
                          if (model.discount != 0)
                            Text(
                              '${model.oldPrice}\$',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                            ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              HomeBloc.get(context)
                                  .changeFavoriteItem(model.id!);
                            },
                            icon: HomeBloc.get(context).favorites[model.id]!
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget catigoriesItemBuilder(CatigoriesDataDataModel model, context) =>
      InkWell(
        onTap: () {
          HomeBloc.get(context).getCatigoriesProducts(id: model.id);
          navigatorTo(
            context: context,
            pageRoute: Catigoriesproducts(catigoryName: model.name),
          );
        },
        child: SizedBox(
          height: 120.0,
          width: 120.0,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              CachedNetworkImage(
                imageUrl: model.image,
                height: 120,
                width: 120,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                    color: defualLightColor,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              Container(
                height: 20,
                width: 120,
                color: Colors.black.withOpacity(.8),
                child: Center(
                  child: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    model.name,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
