import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Shared/components.dart';
import 'package:shop_app/Shared/constants.dart';
import 'package:shop_app/Shop_Layout/HomeCubit/home_bloc.dart';
import 'package:shop_app/Data_Models/catigories_model.dart';
import 'package:shop_app/Shop_Layout/Catigories_Page/catigories_products/catigories_products.dart';

class Catigories extends StatelessWidget {
  const Catigories({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => buildCatigoriesItem(
          HomeBloc.get(context).catigoriesModel!.data.data[index], context),
      separatorBuilder: (context, index) => verticalSeperatorBuilder(
        height: 2,
        color: Colors.white,
      ),
      itemCount: HomeBloc.get(context).catigoriesModel!.data.data.length,
    );
  }

  Widget buildCatigoriesItem(CatigoriesDataDataModel model, context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: model.image,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(
                  color: defualLightColor,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              model.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(fontSize: 18),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                HomeBloc.get(context).getCatigoriesProducts(id: model.id);
                navigatorTo(
                  context: context,
                  pageRoute: Catigoriesproducts(catigoryName: model.name),
                );
              },
              icon: const Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      );
}
