import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shop_app/Data_Models/stripe_models/ephemeral_key_model/ephemeral_key_model.dart';
import 'package:shop_app/Data_Models/stripe_models/init_payment_sheet_model/init_payment_sheet_model.dart';
import 'package:shop_app/Data_Models/stripe_models/payment_intent_input_model/payment_intent_input_model.dart';
import 'package:shop_app/Data_Models/stripe_models/payment_intent_model/payment_intent_model.dart';
import 'package:shop_app/Shared/constants.dart';
import 'package:shop_app/Shared/payment/stripe_api_service.dart';

class StripeService {
  final ApiService apiService = ApiService();
  Future<PaymentIntentModel?> createPaymentIntent(
      PaymentIntentInputModel paymentIntentInputModel) async {
    try {
      var response = await apiService.post(
        url: 'https://api.stripe.com/v1/payment_intents',
        data: paymentIntentInputModel.toJson(),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization':
              'Bearer $secretKey',
        },
      );
      var payementIntentModel = PaymentIntentModel.fromJson(response.data);
      return payementIntentModel;
    } catch (e) {
      log('Create payment intent Error :${e.toString()}');
      return null;
    }
  }

  Future initPaymentSheet({
    required InitPaymentSheetModel initPaymentSheetModel,
  }) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: initPaymentSheetModel.clientSecret,
          customerEphemeralKeySecret: initPaymentSheetModel.ephemeralKeySecret,
          customerId: initPaymentSheetModel.customerId,
          merchantDisplayName: 'Amir Khairy',
        ),
      );
    } catch (e) {
      log('Init payment sheet Error :${e.toString()}');
    }
  }

  Future displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      log('Display payment sheet Error :${e.toString()}');
    }
  }

  Future<EphemeralKeyModel?> createEphemeralKey({
    required String customerId,
  }) async {
    try {
      var response = await apiService.post(
        url: 'https://api.stripe.com/v1/ephemeral_keys',
        data: {
          'customer': customerId,
        },
        headers: {
          'Content-Type': Headers.formUrlEncodedContentType,
          'Authorization':
              'Bearer $secretKey',
          'Stripe-Version': '2025-01-27.acacia',
        },
      );
      var ephemeralKey = EphemeralKeyModel.fromJson(response.data);

      return ephemeralKey;
    } catch (e) {
      log('Create ephemeral key Error :${e.toString()}');
      return null;
    }
  }

  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    var paymentIntentModel = await createPaymentIntent(paymentIntentInputModel);

    var ephemeralKeyModel = await createEphemeralKey(
      customerId: paymentIntentInputModel.customerId,
    );

    var intitPaymentSheetModel = InitPaymentSheetModel(
      clientSecret: paymentIntentModel!.clientSecret!,
      customerId: paymentIntentInputModel.customerId,
      ephemeralKeySecret: ephemeralKeyModel!.secret!,
    );

    await initPaymentSheet(
      initPaymentSheetModel: intitPaymentSheetModel,
    );

    await displayPaymentSheet();
  }
}
