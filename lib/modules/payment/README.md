# Stripe Payment Integration

This module integrates Stripe payments for the Driving License Management System.

## Files Created

- `payment_service.dart` - API service for payment endpoints
- `payment_controller.dart` - GetX controller for payment logic
- `payment_screen.dart` - Payment UI screen
- `payment_history_screen.dart` - Payment history list
- `widgets/pay_button.dart` - Reusable pay button widget

## Backend Integration

Your backend already handles:
- Creating Stripe Checkout Sessions
- Webhooks for payment confirmation
- Payment status tracking

APIs used:
- `GET /applications/{id}/fee` - Get application fee
- `POST /applications/{id}/payments` - Create payment (returns `checkout_url`)
- `GET /applications/{id}/payments/{id}/status` - Check payment status
- `GET /applications/{id}/payments` - List payments

## Usage

### Navigate to Payment Screen

```dart
import 'modules/payment/payment_screen.dart';

// From any screen
Get.to(() => PaymentScreen(applicationId: applicationId));
```

### Add Pay Button to Application Details

```dart
import 'modules/payment/widgets/pay_button.dart';

PayButton(
  applicationId: applicationId,
  amount: 5000, // Optional: show amount on button
  isEnabled: true, // Optional: disable if already paid
)
```

### View Payment History

```dart
import 'modules/payment/payment_history_screen.dart';

Get.to(() => PaymentHistoryScreen(applicationId: applicationId));
```

## Next Steps

1. Run `flutter pub get` to install dependencies
2. Android: Ensure `minSdkVersion` is 21 or higher in `android/app/build.gradle`
3. iOS: Add stripe setup to `ios/Runner/Info.plist` (if using native Stripe UI)

## How It Works

1. User opens PaymentScreen with application ID
2. Screen fetches fee amount from backend
3. User clicks "الدفع الآن" (Pay Now)
4. Backend creates Stripe Checkout Session, returns `checkout_url`
5. App opens checkout URL in external browser using `url_launcher`
6. User completes payment on Stripe
7. User returns to app and confirms
8. App polls payment status every 5 seconds
9. On success, shows success message

## Notes

- The backend handles webhooks, so the Flutter app just needs to poll for status
- No need to initialize Stripe in Flutter since we use Checkout redirect flow
- The `checkout_url` approach is simpler than integrating Stripe SDK directly
