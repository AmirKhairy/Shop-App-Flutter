import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Shared/components.dart';
import 'package:shop_app/Shared/constants.dart';
import 'package:shop_app/Shop_Layout/HomeCubit/home_bloc.dart';
import 'package:shop_app/Shop_Layout/HomeCubit/home_states.dart';
import 'package:shop_app/Data_Models/search_model.dart';
import 'package:shop_app/Shop_Layout/Home_Page/product_details_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Search',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: 25,
                  ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 22,
                      ),
                  onFieldSubmitted: (value) {
                    if (value != '') {
                      HomeBloc.get(context)
                          .getSearchItmes(text: searchController.text);
                    }
                  },
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    fillColor: defualLightColor,
                    filled: true,
                    labelText: 'Search',
                    hintText: '',
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                    labelStyle: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ConditionalBuilder(
                    condition: state is! SearchLoadingDataState,
                    builder: (context) => HomeBloc.get(context)
                                .searchModel
                                ?.data
                                ?.data
                                ?.length !=
                            0
                        ? Expanded(
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) =>
                                  searchItemBuilder(
                                HomeBloc.get(context)
                                    .searchModel!
                                    .data!
                                    .data![index],
                                context,
                              ),
                              separatorBuilder: (context, index) =>
                                  verticalSeperatorBuilder(
                                height: 3,
                                color: Colors.white,
                              ),
                              itemCount: HomeBloc.get(context)
                                      .searchModel
                                      ?.data
                                      ?.data
                                      ?.length ??
                                  0,
                            ),
                          )
                        : Center(
                            child: Text(
                              'No Items',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          ),
                    fallback: (context) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: CircularProgressIndicator(
                            color:
                                Theme.of(context).progressIndicatorTheme.color,
                          ),
                        )),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget searchItemBuilder(SearchDataData model, context) => InkWell(
        onTap: () {
          HomeBloc.get(context).getProductDetails(productId: model.id!);
          navigatorTo(
              context: context, pageRoute: const ProductDetailsScreen());
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              CachedNetworkImage(
                imageUrl: model.image!,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).progressIndicatorTheme.color,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                ),
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
                        model.name!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const Spacer(),
                      Row(
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
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              HomeBloc.get(context)
                                  .changeFavoriteItem(model.id!);
                            },
                            icon: HomeBloc.get(context).favorites[model.id!] ??
                                    false
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
