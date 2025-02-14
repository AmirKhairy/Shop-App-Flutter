import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_app/Shop_Layout/home_layout.dart';

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Success Animation
          Lottie.asset('assets/success.json', width: 200, height: 200),

          const SizedBox(height: 20),

          // Thank You Text
          const Text(
            "Thank You!",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),

          const SizedBox(height: 10),

          // Order Confirmation Message
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "Your payment was successful. Your order has been placed!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ),

          const SizedBox(height: 30),

          // Continue Shopping Button
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomeLayout()),
                (route) => false, // Clears all previous screens
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child:
                const Text("Continue Shopping", style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
