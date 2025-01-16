import 'package:flutter/material.dart';
import 'package:shop_app/Shared/constants.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Image.asset(
              'assets/images/first_onBording.png',
              height: height(context) * .5,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Welcome to Syntax Store',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Discover the ultimate tech shopping experience. Browse through a curated selection of gadgets and accessories designed for programmers and tech enthusiasts.',
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
