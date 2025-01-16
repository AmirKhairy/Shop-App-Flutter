import 'package:flutter/material.dart';
import 'package:shop_app/Shared/constants.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Image.asset(
              'assets/images/third_onBording.png',
              height: height(context) * .5,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Shop with Ease',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Simple and secure checkout with fast delivery. Start building your dream tech setup today with just a few clicks.',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.grey[600], fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
