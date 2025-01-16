import 'package:flutter/material.dart';
import 'package:shop_app/Shared/constants.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Image.asset(
              'assets/images/second_onBoarding.png',
              height: height(context) * .5,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Exclusive Deals, Just for You',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Get access to exclusive discounts and offers. Enjoy seamless shopping with products tailored to your coding journey and tech needs.',
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
