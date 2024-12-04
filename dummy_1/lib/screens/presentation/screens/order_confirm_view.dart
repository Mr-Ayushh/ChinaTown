import 'package:dummy_1/screens/widgets/screen_layout.dart';

import '../../../utils/app_images.dart';
import '../../../utils/exports.dart';
import '../../widgets/main_button.dart';

class OrderConfirmView extends StatefulWidget {
  const OrderConfirmView({super.key});

  @override
  State<OrderConfirmView> createState() => _OrderConfirmViewState();
}

class _OrderConfirmViewState extends State<OrderConfirmView> {
  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      onBackPressed: () {
        Get.back();
      },
      showBackIcon: false,
      title: '¡Order Confirmed!',
      child: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          children: <Widget>[
            Image.asset(
              AppAssets.orderConfirm,
              height: 200,
            ),
            const Spacer(),
            const Text(
              'Your order has been placed succesfully',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            const Text(
              'Order will arrive within 30 mins, Thank you for your patience.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.primary,
              ),
            ),
            const Spacer(),
            MainButton(
              onPressed: () {},
              text: 'Go Home',
            )
          ],
        ),
      ),
    );
  }
}
